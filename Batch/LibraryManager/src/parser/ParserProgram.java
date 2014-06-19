package parser;

import libraryManager.Library;

/**
 * Main for the iTunesLibrary parser. Takes in a file path
 * to the iTunes library xml file or uses the default path
 * if one is not given. A copy of the file is created and
 * then removed once the program is done with it. A library
 * of tracks is generated from the file and then sent to 
 * the database.
 */
public class ParserProgram 
{
	public static void main(String[] args) 
	{	
		Settings settings = null;
		try
		{
			//creates the library from the itunes xml file and then sends that info to the database
			settings = new Settings(args);
			new Library().createFromITunesDB(settings);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			if(settings != null) settings.removeTempItunesLibrary();
		}
	}
}
