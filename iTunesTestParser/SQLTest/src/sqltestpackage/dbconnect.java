package sqltestpackage;

import java.sql.*;

public class dbconnect {
	
	private String connectionString;
	private String userName;
	private String password;
	private boolean isConfigured;
	
	public dbconnect()
	{
		isConfigured = false;
	
	}
	
	public void buildFromXML(String xmlPath)
	{
		isConfigured = false;
	}
	
	public void buildFromConfig(String connectionString, String username, String password)
	{
		

	}

	public ResultSet getResultSet(String storedProc) throws Exception
	{
		if(!isConfigured)
		{
			throw new Exception("SQL Connection not yet configured! (Have you called a build method?)");
		}
		
		try
		{
			Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
			Connection conn = DriverManager.getConnection(connectionString, userName, password);
			
			
		}
		catch(Exception e)
		{
			//Publish.log(e); To be implemented alter
			throw e;
		
		}
		return null;
		
	}
	
	

}
