package libraryManager;

import sqlConnect.DatabaseConnection;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.sql.*;



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
		parser.run();  //Will take a long time
		
		library = parser.getTracks();
	}
	
	
	public boolean addAllToDB()
	{
		try
		{
			DatabaseConnection conn = new DatabaseConnection();
			Iterator<Track> libIter = library.iterator();
			while(libIter.hasNext())
			{
				try
				{
					Track t = libIter.next();
					conn.callQuery(t.dbQuery());
				}
				catch(Exception e)
				{
					System.out.println(e.getMessage());
				}
				
			}
			return true;
		}
		catch(Exception e)
		{
			return false;
		}
	}
	
	

}
