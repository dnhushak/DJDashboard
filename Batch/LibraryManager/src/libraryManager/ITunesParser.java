package libraryManager;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
/**
 * 
 * @author travis
 * From http://trav.is/thoughts/2010/03/30/parsing-itunes-library-using-sax-parser-java/
 * Modified to fit existing libraryManager package
 *
 */
public class ITunesParser extends DefaultHandler 
{

    private static String LIBRARY_FILE_PATH = "/tmp/iTunes Music Library.xml"; //"C:\\iTunes Music Library.xml";
    private List<Track> myTracks;
	private SubsonicLibrary subsonicLibrary;
    private String tempVal;
    private Track tempTrack;
    private boolean foundTracks = false;
    private String previousTag;
    private String previousTagVal;

    public ITunesParser() 
	{
        myTracks = new ArrayList<Track>();
		subsonicLibrary = new SubsonicLibrary();
    }
    
    public static void setFilePath(String filePath)
    {
    	ITunesParser.LIBRARY_FILE_PATH = filePath;
    }

    public void run() 
	{
        parseDocument();
    }
    
    /**
     * Retrieves the list of tracks
     * @return TrackList
     */
    public List<Track> getTracks()
    {
    	return myTracks;
    }

    private void parseDocument() 
	{
        SAXParserFactory spf = SAXParserFactory.newInstance();
        try 
		{
            SAXParser sp = spf.newSAXParser();
            sp.parse(LIBRARY_FILE_PATH, this);
        }
        catch(SAXException se) 
        {
            se.printStackTrace();
        }
        catch(ParserConfigurationException pce) 
        {
            pce.printStackTrace();
        }
        catch (IOException ie) 
        {
            ie.printStackTrace();
        }
    }

    //Event Handlers
    @Override
    public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException 
	{
        tempVal = "";
        if (foundTracks) 
        {
            if ("key".equals(previousTag) && "dict".equalsIgnoreCase(qName)) 
            {
                tempTrack = new Track();
                myTracks.add(tempTrack);
            }
        } 
        else 
        {
            if ("key".equals(previousTag) && "Tracks".equalsIgnoreCase(previousTagVal) && "dict".equalsIgnoreCase(qName)) 
            {
                foundTracks = true;
            }
        }
    }

    public void characters(char[] ch, int start, int length) throws SAXException 
	{
        if(previousTagVal != null && (previousTagVal.equals("Name") || previousTagVal.equals("Artist") || previousTagVal.equals("Album") || previousTagVal.equals("Grouping")))
        {
        	String temp = new String(ch, start, length);
        	tempVal = tempVal + temp;
        }
        else
        {
        	tempVal = new String(ch,start,length);
        }
    }

    public void endElement(String uri, String localName, String qName) throws SAXException 
	{
         if (foundTracks) 
        {
            if (previousTagVal.equalsIgnoreCase("Name") && qName.equals("string"))
            {
                    String name = tempVal.trim();
            		int subsonicID = subsonicLibrary.getSubsonicTrackID(name);
            		tempTrack.setSubsonicID(subsonicID);
                    tempTrack.setName(name);
            }
            else if (previousTagVal.equalsIgnoreCase("Artist") && qName.equals("string"))
            {
                    tempTrack.setArtist(tempVal.trim());
            }
            else if (previousTagVal.equalsIgnoreCase("Album") && qName.equals("string"))
            {
                    tempTrack.setAlbum(tempVal.trim());
            }
            else if (previousTagVal.equalsIgnoreCase("Play Count") && qName.equals("integer"))
            {
                    Integer value = Integer.parseInt(tempVal);
                    tempTrack.setPlayCount(value.intValue());
            }
            else if (previousTagVal.equalsIgnoreCase("Location") && qName.equals("string"))
            {
            	tempTrack.setPath(tempVal.trim());
            }
            else if (previousTagVal.equalsIgnoreCase("Track Number") && qName.equals("integer"))
            {
            	Integer value = Integer.parseInt(tempVal);
            	tempTrack.setTrackNumber(value);
            }
            else if (previousTagVal.equalsIgnoreCase("Sample Rate") && qName.equals("integer"))
            {
            	Integer value = Integer.parseInt(tempVal);
            	tempTrack.setSampleRate(value);
            }
            else if (previousTagVal.equalsIgnoreCase("Track ID") && qName.equals("integer"))
            {
            	Integer value = Integer.parseInt(tempVal);
            	tempTrack.setITL(value);
            }
            else if (previousTagVal.equalsIgnoreCase("Total Time") && qName.equals("integer"))
            {
            	Integer value = Integer.parseInt(tempVal);
            	tempTrack.setTotalTime(value);
            }
            else if (previousTagVal.equalsIgnoreCase("Grouping") && qName.equals("string"))
            {
            	Scanner scan = new Scanner(tempVal);
            	scan.useDelimiter(",");
            	tempTrack.setPrimaryGenre(scan.hasNext() ? scan.next().toLowerCase().trim() : null);
            	tempTrack.setSecondaryGenre(scan.hasNext() ? scan.next().toLowerCase().trim() : null);
            	scan.close();
            }
          
            if ("key".equals(qName) && "Playlists".equalsIgnoreCase(tempVal)) 
			{
                foundTracks = false;
            }
        }

        // Keep track of the previous tag so we can track the context when we're at the second tag in a key, value pair.
        previousTagVal = tempVal;
        previousTag = qName;
    }
}