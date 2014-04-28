package libraryManager;

public class DatabaseTrack 
{
	int idalbum;
	int idartist;
	String name;
	boolean FCC;
	boolean Recommened;
	int ITLID;
	String Path;
	Integer idPrimaryGenre;
	Integer idSecondaryGenre;
	Integer idsubsonic;
	
	DatabaseTrack(int idalbum, int idartist, String name, boolean FCC, boolean Recommened, int ITLID, String Path, Integer idPrimaryGenre, Integer idSecondaryGenre, Integer idsubsonic)
	{
		this.idalbum = idalbum;
		this.idartist = idartist;
		this.name = name;
		this.FCC = FCC;
		this.Recommened = Recommened;
		this.ITLID = ITLID;
		this.Path = Path;
		this.idPrimaryGenre = idPrimaryGenre == null ? 0 : idPrimaryGenre;
		this.idSecondaryGenre = idSecondaryGenre == null ? 0 : idSecondaryGenre;
		this.idsubsonic = idsubsonic == null ? 0 : idsubsonic;
	}
	
	public int get_idalbum()
	{
		return idalbum;
	}
	
	public int get_idartist()
	{
		return idartist;
	}
	
	public String get_name()
	{
		return name;
	}
	
	public boolean get_FCC()
	{
		return FCC;
	}
	
	public boolean get_Recommended()
	{
		return Recommened;
	}
	
	public int get_ITLID()
	{
		return ITLID;
	}
	
	public String get_Path()
	{
		return Path;
	}
	
	public Integer get_idPrimaryGenre()
	{
		return idPrimaryGenre;
	}
	
	public Integer get_idSecondaryGenre()
	{
		return idSecondaryGenre;
	}
	
	public Integer get_idsubsonic()
	{
		return idsubsonic;
	}
	
	@Override
	public boolean equals(Object obj)
	{
		if(obj == null) { return false; }
		if(!(obj instanceof DatabaseTrack)) { return false; }
			
		DatabaseTrack other = (DatabaseTrack) obj;
		boolean result = this.idalbum == other.idalbum &&
					this.idartist == other.idartist &&
					this.name.equals(other.name) &&
					this.FCC == other.FCC &&
					this.Recommened == other.Recommened &&
					this.ITLID == other.ITLID &&
					this.Path.equals(other.Path);
		
		result = this.idPrimaryGenre == null ? this.idPrimaryGenre == other.idPrimaryGenre && result : this.idPrimaryGenre.equals(other.idPrimaryGenre) && result;
		result = this.idSecondaryGenre == null ? this.idSecondaryGenre == other.idSecondaryGenre && result : this.idSecondaryGenre.equals(other.idSecondaryGenre) && result;
		result = this.idsubsonic == null ? this.idsubsonic == other.idsubsonic && result : this.idsubsonic.equals(other.idsubsonic) && result;
		return result;
	}
}
