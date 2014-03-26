package libraryManager;

public class SubsonicAlbum 
{
	private int id;
	private int songCount;
	private int artistID;
	private String name;
	private String artist;
	
	public SubsonicAlbum(int id, int songCount, int artistID, String name, String artist)
	{
		this.id = id;
		this.songCount = songCount;
		this.artistID = artistID;
		this.name = name;
		this.artist = artist;
	}
	
	public int getID()
	{
		return id;
	}
	
	public int getSongCount()
	{
		return songCount;
	}
	
	public int getArtistID()
	{
		return artistID;
	}
	
	public String getName()
	{
		return name;
	}
	
	public String getArtist()
	{
		return artist;
	}
	
	@Override
	public boolean equals(Object obj)
	{
		if(obj == null || !(obj instanceof SubsonicAlbum)) { return false; }
		
		SubsonicAlbum other = (SubsonicAlbum) obj;
		
		return other.id == this.id && other.name.equalsIgnoreCase(this.name);
	}
}
