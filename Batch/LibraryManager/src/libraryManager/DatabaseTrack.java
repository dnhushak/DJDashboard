package libraryManager;

public class DatabaseTrack extends Track
{
	private int idalbum;
	private int idartist;
	private boolean FCC;
	private boolean Recommened;
	private Integer idPrimaryGenre;
	private Integer idSecondaryGenre;
	private Integer idsubsonic;
	
	DatabaseTrack(int idalbum, 
			int idartist, 
			String name, 
			boolean FCC, 
			boolean Recommened, 
			int ITLID, 
			String Path, 
			Integer idPrimaryGenre, 
			Integer idSecondaryGenre, 
			Integer idsubsonic)
	{
		super(name, Path, ITLID);
		this.idalbum = idalbum;
		this.idartist = idartist;
		this.FCC = FCC;
		this.Recommened = Recommened;
		this.idPrimaryGenre = idPrimaryGenre == null ? 0 : idPrimaryGenre;
		this.idSecondaryGenre = idSecondaryGenre == null ? 0 : idSecondaryGenre;
		this.idsubsonic = idsubsonic == null || idsubsonic == -1 ? 0 : idsubsonic;
	}
	
	public int get_idalbum()
	{
		return idalbum;
	}
	
	public int get_idartist()
	{
		return idartist;
	}
	
	public boolean get_FCC()
	{
		return FCC;
	}
	
	public boolean get_Recommended()
	{
		return Recommened;
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
					this.id == other.id &&
					this.path.equals(other.path);
		
		result = this.idPrimaryGenre == null ? this.idPrimaryGenre == other.idPrimaryGenre && result : this.idPrimaryGenre.equals(other.idPrimaryGenre) && result;
		result = this.idSecondaryGenre == null ? this.idSecondaryGenre == other.idSecondaryGenre && result : this.idSecondaryGenre.equals(other.idSecondaryGenre) && result;
		result = this.idsubsonic == null ? this.idsubsonic == other.idsubsonic && result : this.idsubsonic.equals(other.idsubsonic) && result;
		return result;
	}
}
