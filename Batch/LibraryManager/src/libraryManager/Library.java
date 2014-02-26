package libraryManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
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
			List<String> genres = List<String> genres = getDatabaseGenres(conn);
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
	
	private List<String> getDatabaseGenres(DatabaseConnection conn) throws SQLException
	{
		Statement stmt = conn.getConnection().createStatement();
		ResultSet rs = stmt.executeQuery("Select * from genre");
		List<String> genres = new ArrayList<String>();
		while(rs.next())
		{
			genres.add(rs.getString("name"));
		}
		rs.close();
		stmt.close();
		return genres;
	}
}
