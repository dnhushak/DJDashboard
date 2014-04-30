package libraryManager;

public class SubsonicTrack extends Track
{
	private String album;
	private String artist;
	
	public SubsonicTrack(String album, int id, String name, String artist, String path)
	{
		super(name, path, id);
		this.album = album;
		this.artist = artist;
	}
	
	public String getAlbum()
	{
		return album;
	}
	
	public String getArtist()
	{
		return artist;
	}
}
