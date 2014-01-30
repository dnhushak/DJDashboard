package sqlConnect;

public class DBINFO 
{
	public static final String DATABASE = "db30919";
	public static final String ADDTRACK = "AddTrack";
	private static final boolean PROD = true;
	private static final boolean DEV = false;
	private static final String DEVCONNSTRING = "jdbc:mysql://skynet.from-ia.com:4002/kure?"
		              + "user=rclabough&password=NULL";
	private static final String PRODCONNSTRING = "jdbc:mysql://mysql.cs.iastate.edu/db30919?" + "user=u30919&password=pkMDpK6Rh";

	/**
	 * Connection string for each prod and dev server
	 * @return
	 */
	public static String ConnectionString()
	{
		if (PROD)
		{
			return PRODCONNSTRING;
		}
		if (DEV)
		{
			return DEVCONNSTRING;
		}
		
		return null;
	}
}
