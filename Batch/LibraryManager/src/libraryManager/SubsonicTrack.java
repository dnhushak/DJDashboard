package libraryManager;

public class SubsonicTrack 
{
	private int albumID;
	private String album;
	private int id;
	private String name;
	private int artistID;
	private String path;
	private String artist;
	
	public SubsonicTrack(int albumID, String album, int id, String name, int artistID, String path, String artist)
	{
		this.albumID = albumID;
		this.album = album;
		this.id = id;
		this.name = name;
		this.artistID = artistID;
		this.path = path;
		this.artist = artist;
	}
	
	public int getAlbumID()
	{
		return albumID;
	}
	
	public String getAlbum()
	{
		return album;
	}
	
	public int getID()
	{
		return id;
	}
	
	public String getName()
	{
		return name;
	}
	
	public int artistID()
	{
		return artistID;
	}
	
	public String getPath()
	{
		return path;
	}
	
	public String getArtist()
	{
		return artist;
	}
}
