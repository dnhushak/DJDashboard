package libraryManager;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

/**
 * From http://trav.is/thoughts/2010/03/30/parsing-itunes-library-using-sax-parser-java/
 * Modified to fit existing libraryManager package
 * 
 * Parses through an iTumes xml file with a SAX parser to pull
 * track information and created a library of tracks.
 */
public class ITunesParser extends DefaultHandler 
{
    public static String LIBRARY_FILE_PATH = "C:\\iTunes Library.xml";
    private String tempVal;
    private Track tempTrack;
    private boolean foundTracks = false;
    private String previousTag;
    private String previousTagVal;
    private SubsonicLibrary subsonicLibrary;
    private Map<String, Map<String, Map<Integer, Track>>> tracks;
    int count = 0;

    public ITunesParser(String subsonicCSV, boolean buildSubsonicCSV) 
    {
        tracks = new HashMap<String, Map<String, Map<Integer, Track>>>();
        subsonicLibrary = new SubsonicLibrary(subsonicCSV, buildSubsonicCSV);
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
    public Map<String, Map<String, Map<Integer, Track>>> getTracks()
    {
    	return tracks;
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

    @Override
    public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException 
    {
        tempVal = "";
        if (foundTracks) 
        {
            if ("key".equals(previousTag) && "dict".equalsIgnoreCase(qName)) 
            {
            	if(tempTrack != null)
				{
            		((ITunesTrack) tempTrack).setSubsonicID(subsonicLibrary.subsonicID(tempTrack));
            		((ITunesTrack) tempTrack).sanitize();
					addTrack();
					count++;
					System.out.println("Track: " + count);
					
				}
                tempTrack = new ITunesTrack();
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
        if(previousTagVal != null && (previousTagVal.equals("Name") || 
        		previousTagVal.equalsIgnoreCase("Artist") || 
        		previousTagVal.equalsIgnoreCase("Album") || 
        		previousTagVal.equalsIgnoreCase("Grouping") ||
        		previousTagVal.equalsIgnoreCase("Location")))
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
            	tempTrack.setName(tempVal.trim());
            }
            else if (previousTagVal.equalsIgnoreCase("Artist") && qName.equals("string"))
            {
            	((ITunesTrack) tempTrack).setArtist(tempVal.trim());
            }
            else if (previousTagVal.equalsIgnoreCase("Album") && qName.equals("string"))
            {
            	((ITunesTrack) tempTrack).setAlbum(tempVal.trim());
            }
            else if (previousTagVal.equalsIgnoreCase("Location") && qName.equals("string"))
            {
            	tempTrack.setPath(tempVal.trim());
            }
            else if (previousTagVal.equalsIgnoreCase("Track ID") && qName.equals("integer"))
            {
            	Integer value = Integer.parseInt(tempVal);
            	tempTrack.setID(value);
            }
            else if (previousTagVal.equalsIgnoreCase("Grouping") && qName.equals("string"))
            {
            	Scanner scan = new Scanner(tempVal);
            	scan.useDelimiter(",");
            	((ITunesTrack) tempTrack).setPrimaryGenre(scan.hasNext() ? scan.next().toLowerCase().trim() : null);
            	((ITunesTrack) tempTrack).setSecondaryGenre(scan.hasNext() ? scan.next().toLowerCase().trim() : null);
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
    
    private void addTrack()
    {
    	if(tracks.get(((ITunesTrack) tempTrack).getArtist()) == null)
		{
			addNewArtist();
		}
		else
		{
			addAlbum();
		}
    }
    
    private void addAlbum()
    {
    	Map<Integer, Track> songs = tracks.get(((ITunesTrack) tempTrack).getArtist()).get(((ITunesTrack) tempTrack).getAlbum());
		if(songs == null)
		{
			addNewAlbum(songs);
		}
		else
		{
			songs.put(tempTrack.getID(), tempTrack);
		}
    }
    
    private void addNewArtist()
    {
    	tracks.put(((ITunesTrack) tempTrack).getArtist(), new HashMap<String, Map<Integer, Track>>());
    	Map<String, Map<Integer, Track>> albums = tracks.get(((ITunesTrack) tempTrack).getArtist());
    	albums.put(((ITunesTrack) tempTrack).getAlbum(), new HashMap<Integer, Track>());
		Map<Integer, Track> songs = albums.get(((ITunesTrack) tempTrack).getAlbum());
		songs.put(tempTrack.getID(), tempTrack);
    }
    
    private void addNewAlbum(Map<Integer, Track> songs)
    {
    	Map<String, Map<Integer, Track>> albums = tracks.get(((ITunesTrack) tempTrack).getArtist());
    	albums.put(((ITunesTrack) tempTrack).getAlbum(), new HashMap<Integer, Track>());
    	songs = albums.get(((ITunesTrack) tempTrack).getAlbum());
		songs.put(tempTrack.getID(), tempTrack);
    }
}