package libraryManager;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import au.com.bytecode.opencsv.CSVReader;
import au.com.bytecode.opencsv.CSVWriter;
import utility.JsonReader;

public class SubsonicLibrary 
{
	public static String CSV = "subsonic_library.csv";
	private List<String[]> tracks;
	
	public SubsonicLibrary() 
	{
		this(CSV, true);
	}
	
	public SubsonicLibrary(String csvFile, boolean buildLibrary)
	{
		CSV = csvFile;
		try 
		{
			if(buildLibrary || !libraryExists() || needsToBeBuilt())buildLibrary();
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
	
	private boolean libraryExists()
	{
		File file = new File(CSV);
		return file.exists() && file.isFile();
	}
	
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

	public int subsonicID(Track track)
	{
		if(track == null) return -1;
		String artist = ((ITunesTrack) track).getArtist() == null ? "Unknown Artist" : ((ITunesTrack) track).getArtist().trim();
		String album = ((ITunesTrack) track).getAlbum() == null ? "Unknown Album" : ((ITunesTrack) track).getAlbum().trim();
		String name = ((ITunesTrack) track).getName() == null ? "Unknown Name" : ((ITunesTrack) track).getName().trim();
		
		int trackID = -1;
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
		return trackID;
	}
	
	public static int findArtist(String artist)
	{
		try 
		{
		    JSONObject json = JsonReader.readJsonFromUrl("http://kure-automation.stuorg.iastate.edu/rest/getArtists.view?u=kuredj&p=kuredj&v=1.8.0&c=myapp&f=json");
		    JSONArray artistArr = json.getJSONObject("subsonic-response").getJSONObject("artists").getJSONArray("index");
		    for(int i = 0; i < artistArr.length(); i++)
		    {
		    	JSONArray artistsByLetter = artistArr.getJSONObject(i).getJSONArray("artist");
		    	for(int j = 0; j < artistsByLetter.length(); j++)
		    	{
		    		JSONObject subsonicArtist = artistsByLetter.getJSONObject(j);
		    		if(artist.equalsIgnoreCase(subsonicArtist.getString("name").trim()))
		    		{
		    			return subsonicArtist.getInt("id");
		    		}
		    	}
		    }
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return -1;
	}
	
	public static int findAlbumID(int artistID, String album)
	{
		if(artistID == -1) return -1;
		try 
		{
			JSONObject json = JsonReader.readJsonFromUrl("http://kure-automation.stuorg.iastate.edu/rest/getArtist.view?u=kuredj&p=kuredj&v=1.8.0&c=myapp&f=json&id=" + artistID);
				
			JSONObject subsonicAlbum;
			int albumCount = json.getJSONObject("subsonic-response").getJSONObject("artist").getInt("albumCount");
			if(albumCount < 2)
			{
				subsonicAlbum = json.getJSONObject("subsonic-response").getJSONObject("artist").getJSONObject("album");
				if(album.equalsIgnoreCase(subsonicAlbum .getString("name")))
				{
					return subsonicAlbum .getInt("id");
				}
			}
			else
			{
				JSONArray albumArr = json.getJSONObject("subsonic-response").getJSONObject("artist").getJSONArray("album");
				for(int j = 0; j < albumArr.length(); j++)
				{
					subsonicAlbum = albumArr.getJSONObject(j);
					if(album.equalsIgnoreCase(subsonicAlbum .getString("name")))
					{
						return subsonicAlbum.getInt("id");
					}
				}
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return -1;
	}
	
	public static int findTrackID(int albumID, String name)
	{
		if(albumID == -1) return -1;
		try 
		{
			JSONObject json = JsonReader.readJsonFromUrl("http://kure-automation.stuorg.iastate.edu/rest/getAlbum.view?u=kuredj&p=kuredj&v=1.8.0&c=myapp&f=json&id=" + albumID);
				
			JSONObject subsonicTrack;
			int songCount = json.getJSONObject("subsonic-response").getJSONObject("album").getInt("songCount");
			if(songCount < 2)
			{
				subsonicTrack = json.getJSONObject("subsonic-response").getJSONObject("album").getJSONObject("song");
				if(name.equalsIgnoreCase(subsonicTrack.getString("title")))
				{
					return subsonicTrack.getInt("id");
				}
			}
			else
			{
				JSONArray trackArr = json.getJSONObject("subsonic-response").getJSONObject("album").getJSONArray("song");
				for(int j = 0; j < trackArr.length(); j++)
				{
					subsonicTrack = trackArr.getJSONObject(j);
					if(name.equalsIgnoreCase(subsonicTrack.getString("title")))
					{
						return subsonicTrack.getInt("id");
					}
				}
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return -1;
	}
	
	public static void addTrackToCSV(String artist, String album, String name, int trackID)
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
	
	private void buildLibrary() throws IOException, JSONException 
	{
		CSVWriter writer = new CSVWriter(new FileWriter(CSV));
		List<SubsonicArtist> artists = new ArrayList<SubsonicArtist>();
		JSONObject json = JsonReader.readJsonFromUrl("http://kure-automation.stuorg.iastate.edu/rest/getArtists.view?u=kuredj&p=kuredj&v=1.8.0&c=myapp&f=json");
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
		writer.close();
	}
	
	private void readAlbums(List<SubsonicArtist> artists, CSVWriter writer) throws IOException, JSONException 
	{
		List<SubsonicAlbum> albums = new ArrayList<SubsonicAlbum>();
		SubsonicArtist artist;
		for(int i = 0; i < artists.size(); i++)
		{
			artist = artists.get(i);
			int artistID = artist.getID();
			JSONObject json = JsonReader.readJsonFromUrl("http://kure-automation.stuorg.iastate.edu/rest/getArtist.view?u=kuredj&p=kuredj&v=1.8.0&c=myapp&f=json&id=" + artistID);
				
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
	
	private void readTracks(List<SubsonicAlbum> albums, CSVWriter writer) throws IOException, JSONException 
	{
		SubsonicAlbum album;
		for(int i = 0; i < albums.size(); i++)
		{
			album = albums.get(i);
			JSONObject json = JsonReader.readJsonFromUrl("http://kure-automation.stuorg.iastate.edu/rest/getAlbum.view?u=kuredj&p=kuredj&v=1.8.0&c=myapp&f=json&id=" + album.getID());
				
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
}
