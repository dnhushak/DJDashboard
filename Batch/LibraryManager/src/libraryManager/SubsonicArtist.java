package libraryManager;

public class SubsonicArtist 
{
	private int id;
	private String name;
	private int albumCount;
	
	public SubsonicArtist(int id, String name, int albumCount)
	{
		this.id = id;
		this.name = name;
		this.albumCount = albumCount;
	}
	
	public int getID()
	{
		return id;
	}
	
	public String getName()
	{
		return name;
	}
	
	public int getAlbumCount()
	{
		return albumCount;
	}
	
	@Override
	public boolean equals(Object obj)
	{
		if(obj == null || !(obj instanceof SubsonicArtist)) { return false; }
		
		SubsonicArtist other = (SubsonicArtist) obj;
		
		return other.id == this.id && other.name.equalsIgnoreCase(this.name);
	}
}
