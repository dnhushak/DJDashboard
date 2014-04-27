package libraryManager;

import java.util.ArrayList;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

public class SubsonicLibrary 
{
	private List<SubsonicTrack> tracks;
	
	public SubsonicLibrary()
	{
		initializeLibrary();
	}

	public static int subsonicID(Track track)
	{
		int id = -1;
		try
		{
			String artist = track.getArtist() == null ? "Unknown Artist" : track.getArtist().trim();
			int artistID = findArtist(artist);
		
			String album = track.getAlbum() == null ? "Unknown Album" : track.getAlbum().trim();
			int albumID = findAlbumID(artistID, album);
		
			id = findTrackID(albumID, track.getName().trim());
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return id;
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
		if(artistID == -1) { return -1; }
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
		if(albumID == -1) { return -1; }
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
	
	private void initializeLibrary()
	{
		List<SubsonicArtist> artists = new ArrayList<SubsonicArtist>();
		try 
		{
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
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		readAlbums(artists);
	}
	
	private void readAlbums(List<SubsonicArtist> artists)
	{
		List<SubsonicAlbum> albums = new ArrayList<SubsonicAlbum>();
		try 
		{
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
					albums.add(new SubsonicAlbum(album.getInt("id"), album.getInt("songCount"), artistID, album.getString("name"), artistName));
				}
				else
				{
					JSONArray albumArr = json.getJSONObject("subsonic-response").getJSONObject("artist").getJSONArray("album");
					for(int j = 0; j < albumArr.length(); j++)
					{
						album = albumArr.getJSONObject(j);
						albums.add(new SubsonicAlbum(album.getInt("id"), album.getInt("songCount"), artistID, album.getString("name"), artistName));
					}
				}
			}
		}	 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		readTracks(albums);
	}
	
	private void readTracks(List<SubsonicAlbum> albums)
	{
		tracks = new ArrayList<SubsonicTrack>();
		try 
		{
			SubsonicAlbum album;
			for(int i = 0; i < albums.size(); i++)
			{
				album = albums.get(i);
				int albumID = album.getID();
				JSONObject json = JsonReader.readJsonFromUrl("http://kure-automation.stuorg.iastate.edu/rest/getAlbum.view?u=kuredj&p=kuredj&v=1.8.0&c=myapp&f=json&id=" + albumID);
				
				JSONObject track;
				int artistID = album.getArtistID();
				String albumName = album.getName();
				String artist = album.getArtist();
				if(album.getSongCount() < 2)
				{
					track = json.getJSONObject("subsonic-response").getJSONObject("album").getJSONObject("song");
					tracks.add(new SubsonicTrack(albumID, albumName, track.getInt("id"), track.getString("title"), artistID, track.getString("path"), artist));
				}
				else
				{
					JSONArray trackArr = json.getJSONObject("subsonic-response").getJSONObject("album").getJSONArray("song");
					for(int j = 0; j < trackArr.length(); j++)
					{
						track = trackArr.getJSONObject(j);
						tracks.add(new SubsonicTrack(albumID, albumName, track.getInt("id"), track.getString("title"), artistID, track.getString("path"), artist));
					}
				}
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
	
	public List<SubsonicTrack> getTracks()
	{
		return tracks;
	}
	
	public int getSubsonicTrackID(String name)
	{
		for(int i = 0; i < tracks.size(); i++)
		{
			SubsonicTrack track = tracks.get(i);
			if(name.equalsIgnoreCase(track.getName().trim()))
			{
				return track.getID();
			}
		}
		return -1;
	}
}
