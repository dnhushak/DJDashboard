package sqlConnect;

import java.sql.*;
import java.util.Iterator;
import java.util.List;

public class DatabaseConnection 
{
	/**
	Sample code taken from 
	http://www.vogella.com/tutorials/MySQLJava/article.html
	**/
	  private Connection connect = null;
	  private String database = null;
	  
	  public DatabaseConnection() throws ClassNotFoundException, SQLException
	  {
		  database = DBINFO.DATABASE;
		  initDB();
	  }
	  
	  /**
	   * Creates a new Database Connection with the database name (for multiple databases)
	   * @param dbName Name of database connecting to
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	   */
	  public DatabaseConnection(String dbName) throws ClassNotFoundException, SQLException
	  {
		  database = dbName;
		  initDB();
	  }
	  
	  private void initDB() throws SQLException, ClassNotFoundException
	  {
		  Class.forName("com.mysql.jdbc.Driver");
		  connect = DriverManager
		          .getConnection(DBINFO.ConnectionString());
	  }
	  
	  
	  public ResultSet callProcedure(String procedureName) throws SQLException
	  {
		  
		  StringBuilder query = new StringBuilder();
		  query.append("Call ");
		  query.append(database);
		  query.append(".");
		  query.append(procedureName);
		  query.append("();");
		  CallableStatement stat;
		  String qString =  query.toString();
		  stat = connect.prepareCall(qString);
		  ResultSet r = stat.executeQuery();
		  return r;
	  }
	  
	  public ResultSet callProcedure(String procedureName, List<String> variables) throws SQLException
	  {
		  StringBuilder query = new StringBuilder();
		  query.append("Call ");
		  query.append(database);
		  query.append(".");
		  query.append(procedureName);
		  query.append("('");
		  Iterator<String> iter = variables.iterator();
		  for(int i = 0; i < variables.size(); i++)
		  {
			  query.append(iter.next());
			  if(iter.hasNext())
			  {
				  query.append("','");
			  }
		  }
		  query.append("');");
		  
		  CallableStatement stat;
		  stat = connect.prepareCall(query.toString());
		  ResultSet r = stat.executeQuery();
		  return r;
	  }
	  
	  
	  public int callQuery(String query) throws SQLException
	  {
		  PreparedStatement stat;
		  stat = connect.prepareCall(query);
		  ResultSet r = stat.executeQuery();
		  if(r.next())
		  {
			return r.getInt("ID");  
		  }
		  return -1;
	  }
	 
	  
	  
}
