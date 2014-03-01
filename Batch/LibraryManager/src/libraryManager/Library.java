package libraryManager;

import java.sql.*;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import sqlConnect.DatabaseConnection;

public class Library 
{
	private List<Track> library;

	public Library()
	{
		library = new LinkedList<Track>();
	}
		
	/**
	 * Takes the path to an iTunes data file and deserializes it into the library
	 * @param iTunesLibPath URI pathname to itunes data file
	 */
	public void createFromITunesDB(String iTunesLibPath)
	{
		//Parse XML to TrackList
		SAXParserExample parser = new SAXParserExample();
		SAXParserExample.setFilePath(iTunesLibPath);
		parser.run();
		
		library = parser.getTracks();
	}
	
	public boolean addAllToDB()
	{
		try
		{
			DatabaseConnection conn = new DatabaseConnection();
			Map<String, Pair<Integer, String>> genres = getDatabaseGenres(conn);
			Iterator<Track> libIter = library.iterator();
			while(libIter.hasNext())
			{
				try
				{
					Track t = libIter.next();
					conn.callQuery(t.dbQuery(genres));
				}
				catch(Exception e)
				{
					//System.out.println(e.getMessage());
				}
				
			}
			return true;
		}
		catch(Exception e)
		{
			return false;
		}
	}
	
	private Map<String, Pair<Integer, String>> getDatabaseGenres(DatabaseConnection conn) throws SQLException
	{
		ResultSet rs = conn.callProcedure("GetAllGenre");
		Map<String, Pair<Integer, String>> genres = new HashMap<String, Pair<Integer, String>>();
		String gName = null;
		while(rs.next())
		{
			gName = rs.getString("name");
			genres.put(gName.toUpperCase(), new Pair<Integer, String>(rs.getInt("idgenre"), gName));
		}
		System.out.println(genres.toString());
		rs.close();
		return genres;
	}
}
