package libraryManager;

import java.util.ArrayList;
import java.util.List;
import org.junit.*;
import static org.junit.Assert.*;

public class TestParser 
{
	private SAXParserExample parser;
	private List<Track> library;
	private List<Playlist> playlists;
	
	@Before
	public void setUp()
	{
		parser = new SAXParserExample();
		SAXParserExample.setFilePath("C:\\iTunes Library.xml");
		parser.run();
		library = parser.getTracks();
		playlists = parser.getPlaylists();
	}
	
	@After
	public void tearDown()
	{
		parser = null;
		library = null;
		playlists = null;
	}
	
	@Test
	public void testParseTracks()
	{
		assertEquals("Library should contain 20624 tracks", 20624, library.size());
	}
	
	@Test
	public void testParsePlaylists()
	{
		assertEquals("Library should contain 41 playlists", 41, playlists.size());
	}
	
	@Test
	public void testDuplicateTracksInPlaylists()
	{
		for(Playlist playlist : playlists)
		{
			assertEquals("All tracks in a playlist should also be in the library", playlist.getTracks().size(), playlist.duplicateTracks(library).size());
		}
	}
	
	@Test
	public void testTracCountWithDuplicates()
	{
		int trackCount = 0;
		for(Playlist playlist : playlists)
		{
			trackCount += playlist.getTracks().size();
		}
		assertEquals("File should contain 88139 tracks including duplicates", 88139, trackCount + library.size());
	}
	
	@Test
	public void testUniqueGenres()
	{
		ArrayList<String> genres = new ArrayList<String>();
		for(Track track : library)
		{
			String primaryGenre = track.getPrimaryGenre();
			String secondaryGenre = track.getSecondaryGenre();
			if(primaryGenre != null && !genres.contains(primaryGenre))
			{
				genres.add(primaryGenre);
			}
			if(secondaryGenre != null && !genres.contains(secondaryGenre))
			{
				genres.add(secondaryGenre);
			}
		}
		assertEquals("Library should contain 19 unique genres", 19, genres.size());
	}
	
	@Test
	public void testTracksWithSecondaryGenre()
	{
		int count = 0;
		for(Track track : library)
		{
			String secondaryGenre = track.getSecondaryGenre();
			if(secondaryGenre != null)
			{
				count++;
			}
		}
		assertEquals("Library should contain 147 tracks with a secondary genre", 147, count);
	}
	
	@Test
	public void testContainsExplicitTag()
	{
		int count = 0;
		for(Track track : library)
		{
			if(track.getName().contains("[EXPLICIT]"))
			{
				count++;
			}
		}
		assertEquals("Library should have all [EXPlICIT] tags removed", 0, count);
	}
	
	@Test
	public void testContainsRecoTag()
	{
		int count = 0;
		for(Track track : library)
		{
			if(track.getName().contains("[RECO]"))
			{
				count++;
			}
		}
		assertEquals("Library should have all [RECO] tags removed", 0, count);
	}
	
	@Test
	public void testRemoveMultipleTagsOnOneTrack()
	{
		Track track = new Track();
		track.setName("[EXPLICIT] [RECO] This is a track name [RECO] [EXPLICIT]");
		assertEquals("Track name should contain no tags", "This is a track name", track.getName());
	}
}
