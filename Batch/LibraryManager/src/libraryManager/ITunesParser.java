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
    private Map<String, Map<String, Map<Integer, Track>>> tracks; //Artist -> Album -> iTunes Library ID -> ITunesTrack

	/**
	 * Initializes iTunes tracks and builds the subsonic library if
	 * necessary.
	 *
	 * @param subsonicCSV		the file path to the subsonicCSV file
	 * @param buildSubsonicCSV	should the subsonicCSV file be built or not
	 */
    public ITunesParser(String subsonicCSV, boolean buildSubsonicCSV) 
    {
        tracks = new HashMap<String, Map<String, Map<Integer, Track>>>();
        subsonicLibrary = new SubsonicLibrary(subsonicCSV, buildSubsonicCSV);
    }
    
	/**
	 * set the file path for iTunes Library xml file
	 * 
	 * @param filePath the file path for the iTunes Library xml file
	 */
    public static void setFilePath(String filePath)
    {
    	ITunesParser.LIBRARY_FILE_PATH = filePath;
    }

	/**
	 * Starts the parser.
	 */
    public void run() 
    {
        parseDocument();
        subsonicLibrary.clear();
    }
    
    /**
     * Retrieves the list of tracks
     * @return TrackList
     */
    public Map<String, Map<String, Map<Integer, Track>>> getTracks()
    {
    	return tracks;
    }

	/**
	 * Gets the tracks from the iTunes Library xml file and
	 * add the subsonic id to the track if it is in the subsonic
	 * library
	 */
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
		//checks for Name, Artist, etc are to make sure that the value is not cut off by the parser
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
    
	/**
	 * Adds a new track to tracks.
	 */
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
    
	/**
	 * Adds an album if it doesn't exist otherwise adds a track
	 * to an existing album.
	 */
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
    
	/**
	 * Adds a new Artist, then adds the album and track to that artist.
	 */
    private void addNewArtist()
    {
    	tracks.put(((ITunesTrack) tempTrack).getArtist(), new HashMap<String, Map<Integer, Track>>());
    	Map<String, Map<Integer, Track>> albums = tracks.get(((ITunesTrack) tempTrack).getArtist());
    	albums.put(((ITunesTrack) tempTrack).getAlbum(), new HashMap<Integer, Track>());
		Map<Integer, Track> songs = albums.get(((ITunesTrack) tempTrack).getAlbum());
		songs.put(tempTrack.getID(), tempTrack);
    }
    
	/**
	 * Adds a new album to an existing Artist and then adds a track to that album.
	 *
	 * @param songs  a map of songs. ITLID -> ITunesTrack
	 */
    private void addNewAlbum(Map<Integer, Track> songs)
    {
    	Map<String, Map<Integer, Track>> albums = tracks.get(((ITunesTrack) tempTrack).getArtist());
    	albums.put(((ITunesTrack) tempTrack).getAlbum(), new HashMap<Integer, Track>());
    	songs = albums.get(((ITunesTrack) tempTrack).getAlbum());
		songs.put(tempTrack.getID(), tempTrack);
    }
}