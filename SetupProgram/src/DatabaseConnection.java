import java.sql.*;
import java.util.Iterator;
import java.util.List;

public class DatabaseConnection {
	/**
	 * Sample code taken from
	 * http://www.vogella.com/tutorials/MySQLJava/article.html
	 **/
	private Connection connect = null;
	private String database = null;
	private String password = null;
	private String username = null;
	private String connectionString = null;
	private String port = null;

	public DatabaseConnection(String schema, String connectionString,
			String username, String password, String port) throws ClassNotFoundException,
			SQLException {
		this.password = password;
		this.username = username;
		this.connectionString = connectionString;
		this.database = schema;
		this.port = port;
		initDB();
	}

	/**
	 * Creates a new Database Connection with the database name (for multiple
	 * databases)
	 * 
	 * @param dbName
	 *            Name of database connecting to
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 */
	public DatabaseConnection(String dbName) throws ClassNotFoundException,
			SQLException {
		database = dbName;
		initDB();
	}

	private void initDB() throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://"+ connectionString+":" + port;
		connect = DriverManager.getConnection(url, this.username,
				password);
	}

	public int callProcedure(String query) throws SQLException {

		CallableStatement stat;
		String qString = query;
		stat = connect.prepareCall(qString);
		int r = stat.executeUpdate();
		return r;
	}

	public ResultSet callProcedure(String procedureName, List<String> variables)
			throws SQLException {
		StringBuilder query = new StringBuilder();
		query.append("Call ");
		query.append(database);
		query.append(".");
		query.append(procedureName);
		query.append("('");
		Iterator<String> iter = variables.iterator();
		for (int i = 0; i < variables.size(); i++) {
			query.append(iter.next());
			if (iter.hasNext()) {
				query.append("','");
			}
		}
		query.append("');");

		CallableStatement stat;
		stat = connect.prepareCall(query.toString());
		ResultSet r = stat.executeQuery();
		return r;
	}

	public int callQuery(String query) throws SQLException {
		PreparedStatement stat;
		stat = connect.prepareCall(query);
		ResultSet r = stat.executeQuery();
		if (r.next()) {
			return r.getInt("ID");
		}
		return -1;
	}
}
