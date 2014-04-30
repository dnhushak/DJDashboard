package libraryManager;

public class Track 
{
	protected String name;
	protected String path;
	protected int id;
	
	protected Track() {}
	
	protected Track(String name, String path, int id)
	{
		this.name = name;
		this.path = path;
		this.id = id;
	}
	
	public String getName() 
	{
		return name;
	}

	public void setName(String name) 
	{
		this.name = name;
	}
	
	public String getPath()
	{
		return path;
	}
	
	public void setPath(String path)
	{
		this.path = path;
	}
	
	public int getID()
	{
		return id;
	}
	
	public void setID(int id)
	{
		this.id = id;
	}
}
