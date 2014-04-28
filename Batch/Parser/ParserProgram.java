package Parser;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import libraryManager.ITunesParser;
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
		String path = args.length == 1 ? args[0] : ITunesParser.LIBRARY_FILE_PATH;	
		File src = new File(path);
		File directory = new File(src.getParent() + "DupLibrary");
		File dest = new File(directory.getAbsolutePath() + "\\" + src.getName());
		try 
		{
			if(!directory.exists()) directory.mkdir();
			if(dest.exists()) dest.delete();
			Files.copy(src.toPath(), dest.toPath());
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
		
		Library library = new Library();
		library.createFromITunesDB(dest.getAbsolutePath());
		library.addAllToDB();
    	
    	if(dest.exists()) dest.delete();
    	if(directory.exists()) directory.delete();
	}
}
