package parser;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import libraryManager.ITunesParser;
import libraryManager.SubsonicLibrary;

public class Settings 
{
	private String csv;
	private boolean buildCSV;
	private File directory;
	private File dest;
	
	public Settings() throws IOException
	{
		csv = SubsonicLibrary.CSV;
		buildCSV = false;
		createTempITunesLibraryFile(ITunesParser.LIBRARY_FILE_PATH);
	}
	
	public Settings(String[] args) throws IOException
	{
		csv = args.length == 2 ? args[1] : SubsonicLibrary.CSV;
		buildCSV = args.length == 3 && args[3].equalsIgnoreCase("true") ? true : false; 
		createTempITunesLibraryFile(args.length == 1 ? args[0] : ITunesParser.LIBRARY_FILE_PATH);
	}
	
	public String subsonicCSVPath()
	{
		return csv;
	}
	
	public boolean buildCSV()
	{
		return buildCSV;
	}
	
	public String tempITunesLibraryLocation()
	{
		
		return dest.getAbsolutePath();
	}
	
	public void removeTempItunesLibrary()
	{
		if(dest.exists()) dest.delete();
    	if(directory.exists()) directory.delete();
	}
	
	private void createTempITunesLibraryFile(String path) throws IOException
	{
		File src = new File(path);
		directory = new File(src.getParent() + "DupLibrary");
		dest = new File(directory.getAbsolutePath() + "\\" + src.getName());
		
		if(!directory.exists()) directory.mkdir();
		if(dest.exists()) dest.delete();
		Files.copy(src.toPath(), dest.toPath());
	}
}
