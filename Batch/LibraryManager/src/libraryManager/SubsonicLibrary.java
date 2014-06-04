package libraryManager;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import au.com.bytecode.opencsv.CSVReader;
import au.com.bytecode.opencsv.CSVWriter;
import utility.JsonReader;
import utility.Pair;

/**
 * Represents the subsonic library that kure uses to store their music
 * by storing the track information into a CSV file that can be added to
 * or re-built if necessary.
 * 
 * @author Alex Cole 
 */
public class SubsonicLibrary 
{
	public static String CSV = "subsonic_library.csv";
	private List<String[]> tracks;
	private Map<String, Integer> artists; //Artist -> Artist ID
	private Map<Pair<Integer, String>, Integer> albums; //<Artist ID, Album> -> Album ID
	private Map<Pair<Integer, String>, Integer> songs; //<Album ID, Subsonic Track> -> Subsonic Track ID
	
	/**
	 * Default constructor that builds the subsonic
	 * library csv file.
	 */
	public SubsonicLibrary() 
	{
		this(CSV, true);
	}
	
	/**
	 * Constructor that takes in the csv file location and builds
	 * the subsonic csv file if necessary.
	 *
	 * @param csvFile the location of the csv file
	 * @param buildLibrary if the csv file should be built or not
	 */
	public SubsonicLibrary(String csvFile, boolean buildLibrary)
	{
		CSV = csvFile;
		try 
		{
			//will build the csv if told to, if the csv file doesn't exist, or if the csv file is empty
			if(buildLibrary || !libraryExists() || needsToBeBuilt()) buildLibrary();
			buildTrackList();
		} 
		catch(IOException e) 
		{
			e.printStackTrace();
		} 
		catch(JSONException e) 
		{
			e.printStackTrace();
		}
	}
	
	/**
	 * Clears the temporary stored version of the subsonic library.
	 */
	public void clear()
	{
		if(tracks != null) tracks.clear();
		if(artists != null) artists.clear();
		if(albums != null) albums.clear();
		if(songs != null) songs.clear();
	}
	
	/**
	 * Checks to see if the subsonic csv file exists.
	 *
	 * @return true if the csv file exists otherwise false.
	 */
	private boolean libraryExists()
	{
		File file = new File(CSV);
		return file.exists() && file.isFile();
	}
	
	/**
	 * Checks to see if the csv file needs to be built.
	 * 
	 * @return true if the csv file has less than 2 entries otherwise false.
	 */
	private boolean needsToBeBuilt()
	{
		try 
		{
			CSVReader reader = new CSVReader(new FileReader(CSV));
			int count = 0;
			while(reader.readNext() != null)
			{
				count++;
				if(count > 1)
				{
					reader.close();
					return false;
				}
			}
			reader.close();
		}
		catch(FileNotFoundException e) 
		{
			e.printStackTrace();
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
		return true;
	}
	
	/**
	 * Reads and stores all the tracks in the csv file.
	 */
	private void buildTrackList() throws IOException
	{
		CSVReader reader = null;
		try 
		{
			reader = new CSVReader(new FileReader(CSV));
			tracks = reader.readAll();
		} 
		catch(FileNotFoundException e) 
		{
			e.printStackTrace();
		}
		finally
		{
			if(reader != null) reader.close();
		}
	}

	/**
	 * Gets the subsonic id for the given track.
	 * 
	 * @param track the track to get the subsonic id
	 * @return the subsonic id if the track is found otherwise -1
	 */
	public int subsonicID(Track track)
	{
		if(track == null) return -1;
		String artist = ((ITunesTrack) track).getArtist() == null ? "Unknown Artist" : ((ITunesTrack) track).getArtist().trim();
		String album = ((ITunesTrack) track).getAlbum() == null ? "Unknown Album" : ((ITunesTrack) track).getAlbum().trim();
		String name = ((ITunesTrack) track).getName() == null ? "Unknown Name" : ((ITunesTrack) track).getName().trim();
		
		for(String[] entry: tracks)
		{
			if(entry.length == 4)
			{
				if((entry[0].equalsIgnoreCase(artist) && entry[1].equalsIgnoreCase(album) && entry[2].equalsIgnoreCase(name)) ||
						(entry[0].equalsIgnoreCase(artist) && entry[2].equalsIgnoreCase(name)))
				{
					return Integer.parseInt(entry[3]);
				}
			}	
		}
		
		int artistID = findArtistID(artist);
		int albumID = findAlbumID(artistID, album);
		int trackID = findTrackID(albumID, name);
		addTrackToCSV(artist, album, name, trackID);
		return trackID;
	}
	
	/**
	 * Gets the subsonic artist ID.
	 * 
	 * @param artist the name of the artist
	 * @return the artist ID if the artist exists otherwise -1
	 */
	private int findArtistID(String artist)
	{
		if(artists == null) getArtistsFromSubsonic();
		Integer artistID = artists.get(artist);
		if(artistID == null) return -1;
		return artistID;
	}
	
	/**
	 * Creates a map of subsonic artists (Artist -> Artist ID).
	 */
	private void getArtistsFromSubsonic()
	{
		artists = new HashMap<String, Integer>();
		try 
		{
		    JSONObject json = JsonReader.readJsonFromUrl(GET_ARTISTS);
		    JSONArray artistArr = json.getJSONObject("subsonic-response").getJSONObject("artists").getJSONArray("index");
		    for(int i = 0; i < artistArr.length(); i++)
		    {
		    	JSONArray artistsByLetter = artistArr.getJSONObject(i).getJSONArray("artist");
		    	for(int j = 0; j < artistsByLetter.length(); j++)
		    	{
		    		JSONObject subsonicArtist = artistsByLetter.getJSONObject(j);
		    		artists.put(subsonicArtist.getString("name"), subsonicArtist.getInt("id"));
		    	}
		    }
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
	
	/**
	 * Gets the subsonic album ID
	 *
	 * @param artistID the artist ID in subsonic
	 * @param album the name of the album
	 * @return the subsonic album ID if the album exists otherwise -1
	 */
	private int findAlbumID(int artistID, String album)
	{
		if(artistID == -1) return -1;
		if(albums == null) albums = new HashMap<Pair<Integer, String>, Integer>();
		
		Pair<Integer, String> uniqueAlbum = new Pair<Integer, String>(artistID, album); 
		Integer albumID = albums.get(uniqueAlbum);
		if(albumID == null) getAlbumsFromSubsonic(artistID);
		albumID = albums.get(uniqueAlbum);
		if(albumID == null) return -1;
		return albumID;
	}
	
	/**
	 * Gets the albums from subsonic for an artist and adds them to the map of albums (<Artist ID, Album> -> Album ID).
	 *
	 * @param artistID the subsonic artist ID
	 */
	private void getAlbumsFromSubsonic(int artistID)
	{
		try 
		{
			JSONObject json = JsonReader.readJsonFromUrl(GET_ARTIST + artistID);
			JSONObject subsonicAlbum;
			int albumCount = json.getJSONObject("subsonic-response").getJSONObject("artist").getInt("albumCount");
			if(albumCount < 2)
			{
				subsonicAlbum = json.getJSONObject("subsonic-response").getJSONObject("artist").getJSONObject("album");
				albums.put(new Pair<Integer, String>(artistID, subsonicAlbum.getString("name")), subsonicAlbum.getInt("id"));
	
			}
			else
			{
				JSONArray albumArr = json.getJSONObject("subsonic-response").getJSONObject("artist").getJSONArray("album");
				for(int j = 0; j < albumArr.length(); j++)
				{
					subsonicAlbum = albumArr.getJSONObject(j);
					albums.put(new Pair<Integer, String>(artistID, subsonicAlbum.getString("name")), subsonicAlbum.getInt("id"));
				}
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
	
	/**
	 * Gets the subsonic track ID by album ID and track name.
	 *
	 * @param albumID the subsonic album ID
	 * @param name the name of the track
	 * @return the subsonic track ID if the track exists otherwise -1
	 */
	private int findTrackID(int albumID, String name)
	{
		if(albumID == -1) return -1;
		if(songs == null) songs = new HashMap<Pair<Integer, String>, Integer>();
		
		Pair<Integer, String> uniqueSong = new Pair<Integer, String>(albumID, name); 
		Integer trackID = songs.get(uniqueSong);
		if(trackID == null) getTracksFromSubsonic(albumID);
		trackID = songs.get(uniqueSong);
		if(trackID == null) return -1;
		return trackID;
	}
	
	/**
	 * Gets the tracks from subsonic for an album and adds them to the map of songs (<Album ID, Subsonic Track> -> Subsonic Track ID).
	 *
	 * @param albumID the subsonic album ID
	 */
	private void getTracksFromSubsonic(int albumID)
	{
		try 
		{
			JSONObject json = JsonReader.readJsonFromUrl(GET_ALBUM + albumID);
			JSONObject subsonicTrack;
			int songCount = json.getJSONObject("subsonic-response").getJSONObject("album").getInt("songCount");
			if(songCount < 2)
			{
				subsonicTrack = json.getJSONObject("subsonic-response").getJSONObject("album").getJSONObject("song");
				songs.put(new Pair<Integer, String>(albumID, subsonicTrack.getString("title")), subsonicTrack.getInt("id"));
			}
			else
			{
				JSONArray trackArr = json.getJSONObject("subsonic-response").getJSONObject("album").getJSONArray("song");
				for(int j = 0; j < trackArr.length(); j++)
				{
					subsonicTrack = trackArr.getJSONObject(j);
					songs.put(new Pair<Integer, String>(albumID, subsonicTrack.getString("title")), subsonicTrack.getInt("id"));
				}
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
	
	/**
	 * Adds a track to the subsonic CSV file
	 * 
	 * @param artist the artist name
	 * @param album the album name
	 * @param name the track name
	 * @param trackID the subsonic track ID
	 */
	public void addTrackToCSV(String artist, String album, String name, int trackID)
	{
		try 
		{
			CSVWriter writer = new CSVWriter(new FileWriter(CSV, true));
			writer.writeNext(new String[] { artist, album, name, Integer.toString(trackID) });
			writer.close();
		} 
		catch(IOException e) 
		{
			e.printStackTrace();
		}
	}
	
	/**
	 * Builds the subsonic CSV file from the subsonic database.
	 */
	private void buildLibrary() throws IOException, JSONException 
	{
		
		CSVWriter writer = null;
		try
		{
			writer = new CSVWriter(new FileWriter(CSV));
			List<SubsonicArtist> artists = new ArrayList<SubsonicArtist>();
			JSONObject json = JsonReader.readJsonFromUrl(GET_ARTISTS);
			JSONArray artistArr = json.getJSONObject("subsonic-response").getJSONObject("artists").getJSONArray("index");
			for(int i = 0; i < artistArr.length(); i++)
			{
				JSONArray artistsByLetter = artistArr.getJSONObject(i).getJSONArray("artist");
				for(int j = 0; j < artistsByLetter.length(); j++)
				{
					JSONObject artist = artistsByLetter.getJSONObject(j);
					artists.add(new SubsonicArtist(artist.getInt("id"), artist.getString("name"), artist.getInt("albumCount")));
				}
			}
			readAlbums(artists, writer);
		}
		finally
		{
			if(writer != null) writer.close();
		}
	}
	
	/**
	 * Goes through all the albums in the subsonic database for each artist in order to read through the subsonic tracks.
	 */
	private void readAlbums(List<SubsonicArtist> artists, CSVWriter writer) throws IOException, JSONException 
	{
		List<SubsonicAlbum> albums = new ArrayList<SubsonicAlbum>();
		SubsonicArtist artist;
		for(int i = 0; i < artists.size(); i++)
		{
			artist = artists.get(i);
			int artistID = artist.getID();
			JSONObject json = JsonReader.readJsonFromUrl(GET_ARTIST + artistID);
				
			JSONObject album;
			String artistName = artist.getName();
			if(artist.getAlbumCount() < 2)
			{
				album = json.getJSONObject("subsonic-response").getJSONObject("artist").getJSONObject("album");
				albums.add(new SubsonicAlbum(album.getInt("id"), album.getInt("songCount"), album.getString("name"), artistName));
			}
			else
			{
				JSONArray albumArr = json.getJSONObject("subsonic-response").getJSONObject("artist").getJSONArray("album");
				for(int j = 0; j < albumArr.length(); j++)
				{
					album = albumArr.getJSONObject(j);
					albums.add(new SubsonicAlbum(album.getInt("id"), album.getInt("songCount"), album.getString("name"), artistName));
				}
			}
		}	 
		readTracks(albums, writer);
	}
	
	/**
	 * Goes trough all the tracks of each album and writes the tracks to the subsonic CSV file.
	 */
	private void readTracks(List<SubsonicAlbum> albums, CSVWriter writer) throws IOException, JSONException 
	{
		SubsonicAlbum album;
		for(int i = 0; i < albums.size(); i++)
		{
			album = albums.get(i);
			JSONObject json = JsonReader.readJsonFromUrl(GET_ALBUM + album.getID());
				
			JSONObject track;
			String albumName = album.getName();
			String artist = album.getArtist();
			if(album.getSongCount() < 2)
			{
				track = json.getJSONObject("subsonic-response").getJSONObject("album").getJSONObject("song");
				writer.writeNext(new String[] { artist, albumName, track.getString("title"), track.getString("id") });
			}
			else
			{
				JSONArray trackArr = json.getJSONObject("subsonic-response").getJSONObject("album").getJSONArray("song");
				for(int j = 0; j < trackArr.length(); j++)
				{
					track = trackArr.getJSONObject(j);
					writer.writeNext(new String[] { artist, albumName, track.getString("title"), track.getString("id") });
				}
			}
		}
	}
		
	public static final String GET_ALBUM = "http://kure-automation.stuorg.iastate.edu/rest/getAlbum.view?u=kuredj&p=kuredj&v=1.8.0&c=myapp&f=json&id=";
	public static final String GET_ARTIST = "http://kure-automation.stuorg.iastate.edu/rest/getArtist.view?u=kuredj&p=kuredj&v=1.8.0&c=myapp&f=json&id=";
	public static final String GET_ARTISTS = "http://kure-automation.stuorg.iastate.edu/rest/getArtists.view?u=kuredj&p=kuredj&v=1.8.0&c=myapp&f=json";
}
