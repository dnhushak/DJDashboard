package Parser;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import libraryManager.Library;

public class ParserProgram 
{
	public static void main(String[] args) 
	{
		String path = "C:\\iTunes Library.xml";	
		if(args.length == 1)
		{
			path = args[0];
		}
		
	
		File src = new File(path);
		File directory = new File(src.getParent() + "DupLibrary");
		File dest = new File(directory.getAbsolutePath() + "\\" + src.getName());
		try 
		{
			if(!directory.exists())
			{
				directory.mkdir();
			}
			
			
			if(dest.exists())
			{
				dest.delete();
			}
			
			Files.copy(src.toPath(), dest.toPath());
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
		
		Library library = new Library();
		library.createFromITunesDB(dest.getAbsolutePath());
    	library.addAllToDB();
    	
    	if(directory.exists() && dest.exists())
    	{
    		System.out.println(dest.delete());
    		System.out.println(directory.delete());
    	}
	}
}
