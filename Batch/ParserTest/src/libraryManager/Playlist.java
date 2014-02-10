package libraryManager;

import java.util.List;
import java.util.ArrayList;

public class Playlist 
{
	private String name;
	private int id;
	private String persistentID;
	private List<Track> tracks;
	
	public Playlist()
	{
		tracks = new ArrayList<Track>();
	}
	
	public String getName()
	{
		return name;
	}
	
	public void setName(String pname)
	{
		name = pname;
	}
	
	public int getID()
	{
		return id;
	}
	
	public void setID(int pid)
	{
		id = pid;
	}
	
	public String getPersistenID()
	{
		return persistentID;
	}
	
	public void setPersistentID(String persistentID)
	{
		this.persistentID = persistentID;
	}
	
	public List<Track> getTracks()
	{
		return tracks;
	}
	
	public void setTracks(List<Track> ptracks)
	{
		tracks = ptracks;
	}
	
	public List<Integer> getTrackIDList()
	{
		return toTrackIDList(tracks);
	}
	
	public List<Integer> toTrackIDList(List<Track> ptracks)
	{
		List<Integer> list = new ArrayList<Integer>();
		for(Track track : ptracks)
		{
			list.add(track.getID());
		}
		return list;
	}
	
	public List<Track> duplicateTracks(Playlist other)
	{
		return duplicateTracks(other.getTracks());
	}
	
	public List<Track> duplicateTracks(List<Track> ptracks)
	{
		List<Track> dups = new ArrayList<Track>();
		List<Integer> trackIDS = toTrackIDList(ptracks);
		for(Track track : tracks)
		{
			if(trackIDS.contains(track.getID()))
			{
				dups.add(track);
			}
		}
		return dups;
	}
}
