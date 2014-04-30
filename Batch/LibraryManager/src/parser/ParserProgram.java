package parser;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import libraryManager.ITunesParser;
import libraryManager.Library;
import libraryManager.SubsonicLibrary;

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
		String path = args.length == 1 ? args[0] : ITunesParser.LIBRARY_FILE_PATH;
		String csv = args.length == 2 ? args[1] : SubsonicLibrary.CSV;
		boolean buildCSV = args.length == 3 && args[3].equalsIgnoreCase("true") ? true : false; 
		
		//Figures out where to create a copy of the itunes xml file
		File src = new File(path);
		File directory = new File(src.getParent() + "DupLibrary");
		File dest = new File(directory.getAbsolutePath() + "\\" + src.getName());
		try 
		{
			//creates the location of where the copy is to be made if it doesn't exist
			//and then copies the file into that location
			if(!directory.exists()) directory.mkdir();
			if(dest.exists()) dest.delete();
			Files.copy(src.toPath(), dest.toPath());
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
		
		try
		{
			//creates the library from the itunes xml file and then sends that info to the database
			Library library = new Library();
			library.createFromITunesDB(dest.getAbsolutePath(), csv, buildCSV);
			library.addAllToDB();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
    	
		//removes temporary copy of itunes xml file
    	if(dest.exists()) dest.delete();
    	if(directory.exists()) directory.delete();
	}
}
