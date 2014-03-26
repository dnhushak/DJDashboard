package libraryManager;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

public class SubsonicLibrary 
{
	private List<SubsonicArtist> artists;
	private List<SubsonicAlbum> albums;
	private List<SubsonicTrack> tracks;
	
	public SubsonicLibrary()
	{
		initializeLibrary();
	}
	
	void initializeLibrary()
	{
		generateArtistList();
		generateAlbumList();
		generateTrackList();
	}
	
	private void generateArtistList()
	{
		artists = new ArrayList<SubsonicArtist>();
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
	}
	
	private void generateAlbumList()
	{
		albums = new ArrayList<SubsonicAlbum>();
		try 
		{
			for(int i = 0; i < artists.size(); i++)
			{
				SubsonicArtist artist = artists.get(i);
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
	}
	
	private void generateTrackList()
	{
		tracks = new ArrayList<SubsonicTrack>();
		try 
		{
			for(int i = 0; i < albums.size(); i++)
			{
				SubsonicAlbum album = albums.get(i);
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
	
	public List<SubsonicArtist> getArtists()
	{
		return artists;
	}
	
	public List<SubsonicAlbum> getAlbums()
	{
		return albums;
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
