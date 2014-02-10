package libraryManager;

import java.util.List;

public class TestParser 
{
	public static void main(String[] args)
	{
		SAXParserExample parser = new SAXParserExample();
		SAXParserExample.setFilePath("C:\\iTunes Library.xml");
		parser.run();
		List<Track> library = parser.getTracks();
		List<Playlist> playlists = parser.getPlaylists();
		
		int trackCount = 0;
		
		trackCount += library.size();
		System.out.println("Library track count: " + trackCount);
		
		
		System.out.println("Number of Playlists: " + playlists.size());
		System.out.println();
		for(Playlist playlist : playlists)
		{
			int playlistSize = playlist.getTracks().size();
			int dups = playlist.duplicateTracks(library).size();
			System.out.println("Playlist: " + playlist.getName() + "; Number of tracks: " + playlistSize + "; Number of duplicate tacks: " + dups);
			trackCount += playlistSize;
		}
		System.out.println();
		System.out.println("Track count with all tracks in playlists: "+ trackCount);
		
		
		
	}
}
