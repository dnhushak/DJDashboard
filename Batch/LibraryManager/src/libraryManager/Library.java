package libraryManager;

import java.nio.charset.Charset;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import sqlConnect.DatabaseConnection;

public class Library 
{
	private Map<String, Map<String, Map<Integer, Track>>> library;
	
	public Library()
	{
		library = new HashMap<String, Map<String, Map<Integer, Track>>>();
	}
	
	/**
	 * Takes the path to an iTunes data file and deserializes it into the library
	 * @param iTunesLibPath URI pathname to itunes data file
	 */
	public void createFromITunesDB(String iTunesLibPath)
	{
		//Parse XML to TrackList
		ITunesParser parser = new ITunesParser();
		ITunesParser.setFilePath(iTunesLibPath);
		parser.run();
		library = parser.getTracks();
	}
	
	public boolean addAllToDB()
	{
		DatabaseConnection conn = null;
		try
		{
			conn = new DatabaseConnection();
			sendArtistsToDatabase(conn);
			sendAlbumsToDatabase(conn);
			sendTracksToDatabase(conn);
			return true;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			if(conn != null) try { conn.getConnection().close(); } catch (SQLException e1) {}
			return false;
		}
	}
		
	private void sendArtistsToDatabase(DatabaseConnection conn) throws SQLException
	{
		List<String> artists = new ArrayList<String>();
		Map<String, Integer> databaseArtists = getNameIDMap(conn, "GetArtistList", "Artist", "ID");
		
		Iterator<Map.Entry<String,Map<String,Map<Integer,Track>>>> iter = library.entrySet().iterator();
		while(iter.hasNext())
		{
			Map.Entry<String, Map<String, Map<Integer, Track>>> artistAlbumPair = iter.next();
			String artist = artistAlbumPair.getKey();
			String utf8Artist = new String(artist.getBytes(), Charset.forName("UTF-8"));
			if(databaseArtists.get(utf8Artist) == null && databaseArtists.get(artist) == null) { artists.add(artist); }
		}
		insertIntoArtistTable(conn, artists);
	}
	
	private void insertIntoArtistTable(DatabaseConnection conn, List<String> artists) throws SQLException
	{
		PreparedStatement statement = conn.getConnection().prepareStatement(INSERT_ARTIST);
		for(int i = 0; i < artists.size(); i++)
		{
			String artist = artists.get(i);
			statement.setString(1, artist);
			statement.addBatch();
			if((i + 1) % 1000 == 0)
			{
				statement.executeBatch();
			}
		}
		statement.executeBatch();
		statement.close();
	}
	
	public void sendAlbumsToDatabase(DatabaseConnection conn) throws SQLException
	{
		List<Pair<Integer, String>> albums = new ArrayList<Pair<Integer, String>>();
		Map<String, Integer> databaseArtists = getNameIDMap(conn, "GetArtistList", "Artist", "ID");	
		Map<Integer, List<String>> databaseAlbums = getIDNameListMap(conn, "GetAlbumList", "Artist ID", "Album Name");
	
		Iterator<Map.Entry<String,Map<String,Map<Integer,Track>>>> artistIter = library.entrySet().iterator();
		while(artistIter.hasNext())
		{
			Map.Entry<String, Map<String, Map<Integer, Track>>> artistAlbumPair = artistIter.next();
			String artist = artistAlbumPair.getKey();
			String utf8Artist = new String(artist.getBytes(), Charset.forName("UTF-8"));
			Integer artistID = databaseArtists.get(utf8Artist) == null ? databaseArtists.get(artist) : databaseArtists.get(utf8Artist);
			buildAlbumList(artistAlbumPair.getValue(), databaseAlbums, albums, artistID);
		}
		insertIntoAlbumTable(conn, albums);
	}
	
	public void buildAlbumList(Map<String, Map<Integer, Track>> albumMap, Map<Integer, List<String>> databaseAlbums, List<Pair<Integer, String>> albums, int artistID)
	{
		Iterator<Map.Entry<String, Map<Integer, Track>>> albumIter = albumMap.entrySet().iterator();
		while(albumIter.hasNext())
		{
			Map.Entry<String, Map<Integer, Track>> albumSongPair = albumIter.next();
			String album = albumSongPair.getKey();
			String utf8Album = new String(album.getBytes(), Charset.forName("UTF-8"));
			if(!foundAlbumInDatabase(databaseAlbums.get(artistID), utf8Album, album)) { albums.add(new Pair<Integer, String>(artistID, album)); }
		}
	}
	
	private boolean foundAlbumInDatabase(List<String> databaseAlbums, String utf8Target, String target)
	{
		if(databaseAlbums == null) return false;
		
		for(int i = 0; i < databaseAlbums.size(); i++)
		{
			String album = databaseAlbums.get(i);
			if(album.equalsIgnoreCase(utf8Target) || album.equalsIgnoreCase(target)) return true;
		}
		return false;
	}
	
	private void insertIntoAlbumTable(DatabaseConnection conn, List<Pair<Integer, String>> albums) throws SQLException
	{
		PreparedStatement statement = conn.getConnection().prepareStatement(INSERT_ALBUM);
		for(int i = 0; i < albums.size(); i++)
		{
			Pair<Integer, String> album = albums.get(i);
			statement.setInt(1, album.getFirst());
			statement.setString(2, album.getSecond());
			statement.addBatch();
			if((i + 1) % 1000 == 0)
			{
				statement.executeBatch();
			}
		}
		statement.executeBatch();
		statement.close();
	}
	
	private void sendTracksToDatabase(DatabaseConnection conn) throws SQLException
	{
		List<DatabaseTrack> insertTracks = new ArrayList<DatabaseTrack>();
		List<DatabaseTrack> updateTracks = new ArrayList<DatabaseTrack>();
		Map<String, Integer> databaseArtists = getNameIDMap(conn, "GetArtistList", "Artist", "ID");	
		Map<Integer, List<Pair<Integer,String>>> databaseAlbums = getIDPairListMap(conn, "GetAlbumList", "Artist ID", "ID", "Album Name");	
		Map<String, Integer> databaseGenres = getNameIDMap(conn, "GetAllGenre", "Name", "idGenre");			
		Map<Integer, DatabaseTrack> databaseTracks = getDatabaseTracks(conn);
		
		Iterator<Map.Entry<String,Map<String,Map<Integer,Track>>>> artistIter = library.entrySet().iterator();
		while(artistIter.hasNext())
		{
			Map.Entry<String, Map<String, Map<Integer, Track>>> artistAlbumPair = artistIter.next();
			String artist = artistAlbumPair.getKey();
			String utf8Artist = new String(artist.getBytes(), Charset.forName("UTF-8"));
			Integer artistID = databaseArtists.get(utf8Artist) == null ? databaseArtists.get(artist) : databaseArtists.get(utf8Artist);
			buildTrackListByAlbum(artistAlbumPair.getValue(), databaseAlbums, databaseGenres, databaseTracks, insertTracks, updateTracks, artistID);
		}	
		insertIntoTrackTable(conn, insertTracks);
		updateTrackTable(conn, updateTracks);
	}
	
	private void buildTrackListByAlbum(Map<String, Map<Integer, Track>> albumMap, Map<Integer, List<Pair<Integer,String>>> databaseAlbums, Map<String, Integer> databaseGenres, 
			Map<Integer, DatabaseTrack> databaseTracks, List<DatabaseTrack> insertTracks, List<DatabaseTrack> updateTracks, int artistID)
	{
		Iterator<Map.Entry<String, Map<Integer, Track>>> albumIter = albumMap.entrySet().iterator();
		while(albumIter.hasNext())
		{
			Map.Entry<String, Map<Integer, Track>> albumSongPair = albumIter.next();
			String album = albumSongPair.getKey();
			String utf8Album = new String(album.getBytes(), Charset.forName("UTF-8"));
			
			Integer albumID = getAlbumID(databaseAlbums.get(artistID), utf8Album, album);
			buildTrackLists(albumSongPair.getValue(), databaseGenres, databaseTracks, insertTracks, updateTracks, albumID, artistID);
		}
	}
	
	private void buildTrackLists(Map<Integer, Track> trackMap, Map<String, Integer> databaseGenres, Map<Integer, DatabaseTrack> databaseTracks, 
			List<DatabaseTrack> insertTracks, List<DatabaseTrack> updateTracks, int albumID, int artistID)
	{
		Iterator<Map.Entry<Integer, Track>> trackIter = trackMap.entrySet().iterator();
		while(trackIter.hasNext())
		{
			Map.Entry<Integer, Track> idTrackPair = trackIter.next();
			int trackID = idTrackPair.getKey();
			Track libraryTrack = idTrackPair.getValue();
			DatabaseTrack newTrack = new DatabaseTrack(
					albumID,
					artistID,
					libraryTrack.getName(),
					libraryTrack.getFCC(),
					libraryTrack.getRecommended(),
					libraryTrack.getITunesID(),
					libraryTrack.getPath(),
					getGenre(databaseGenres, libraryTrack.getPrimaryGenre()),
					getGenre(databaseGenres, libraryTrack.getSecondaryGenre()),
					libraryTrack.getSubsonicID());
			DatabaseTrack databaseTrack = databaseTracks.get(trackID);
			if(databaseTrack == null)
			{
				insertTracks.add(newTrack);
			}
			else if(!newTrack.equals(databaseTrack))
			{
				updateTracks.add(newTrack);
			}
		}
	}
	
	private Integer getGenre(Map<String, Integer> genres, String genre)
	{
		if(genre == null) return null;
		Integer ret = genres.get(genre);
		if(ret == null) ret = genres.get(genre.toUpperCase());
		return ret;
	}
	
	private Map<Integer, DatabaseTrack> getDatabaseTracks(DatabaseConnection conn) throws SQLException
	{
		ResultSet rs = conn.getConnection().prepareStatement(SELECT_TRACK).executeQuery();
		Map<Integer, DatabaseTrack> ret = new HashMap<Integer, DatabaseTrack>();
		while(rs.next())
		{
			DatabaseTrack track = new DatabaseTrack(
					rs.getInt("idalbum"), 
					rs.getInt("idartist"),
					rs.getString("Name"),
					rs.getBoolean("FCC"),
					rs.getBoolean("Recommended"),
					rs.getInt("ITLID"),
					rs.getString("Path"),
					rs.getInt("idPrimaryGenre"),
					rs.getInt("idSecondaryGenre"),
					rs.getInt("idsubsonic"));
				ret.put(rs.getInt("ITLID"), track);
		}
		rs.close();
		return ret;
	}
	
	private Integer getAlbumID(List<Pair<Integer, String>> databaseAlbums, String utf8Target, String target)
	{
		if(databaseAlbums == null) return null;
		
		for(Pair<Integer, String> databaseAlbum : databaseAlbums)
		{
			String album = databaseAlbum.getSecond();
			if(album.equalsIgnoreCase(utf8Target) || album.equalsIgnoreCase(target)) return databaseAlbum.getFirst();
		}
		return null;
	}
	
	private void insertIntoTrackTable(DatabaseConnection conn, List<DatabaseTrack> tracks) throws SQLException
	{
		PreparedStatement statement = conn.getConnection().prepareStatement(INSERT_TRACK);
		for(int i = 0; i < tracks.size(); i++)
		{
			DatabaseTrack track = tracks.get(i);
			statement.setInt(1, track.get_idalbum());
			statement.setInt(2, track.get_idartist());
			statement.setString(3, track.get_name());
			statement.setBoolean(4, track.get_FCC());
			statement.setBoolean(5, track.get_Recommended());
			statement.setInt(6, track.get_ITLID());
			statement.setString(7, track.get_Path());
			
			Integer pGenre = track.get_idPrimaryGenre();
			Integer sGenre = track.get_idSecondaryGenre();
			Integer subsonic = track.get_idsubsonic();
			if(pGenre != null) { statement.setInt(8, pGenre); } else { statement.setNull(8, Types.INTEGER); }
			if(sGenre != null) { statement.setInt(9, sGenre); } else { statement.setNull(9, Types.INTEGER); }
			if(subsonic != null && subsonic != -1) { statement.setInt(10, subsonic); } else { statement.setNull(10, Types.INTEGER); }
			statement.addBatch();
			if((i + 1) % 1000 == 0)
			{
				statement.executeBatch();
			}
		}
		statement.executeBatch();
		statement.close();
	}
	
	private void updateTrackTable(DatabaseConnection conn, List<DatabaseTrack> tracks) throws SQLException
	{
		PreparedStatement statement = conn.getConnection().prepareStatement(UPDATE_TRACK);
		for(int i = 0; i < tracks.size(); i++)
		{
			DatabaseTrack track = tracks.get(i);
			statement.setInt(1, track.get_idalbum());
			statement.setInt(2, track.get_idartist());
			statement.setString(3, track.get_name());
			statement.setBoolean(4, track.get_FCC());
			statement.setBoolean(5, track.get_Recommended());
			statement.setString(6, track.get_Path());
				
			Integer pGenre = track.get_idPrimaryGenre();
			Integer sGenre = track.get_idSecondaryGenre();
			Integer subsonic = track.get_idsubsonic();
			if(pGenre != null) { statement.setInt(7, pGenre); } else { statement.setNull(7, Types.INTEGER); }
			if(sGenre != null) { statement.setInt(8, sGenre); } else { statement.setNull(8, Types.INTEGER); }
			if(subsonic != null && subsonic != -1) { statement.setInt(9, subsonic); } else { statement.setNull(9, Types.INTEGER); }
			
			statement.setInt(10, track.get_ITLID());
			statement.addBatch();
			if((i + 1) % 1000 == 0)
			{
				statement.executeBatch();
			}
		}
		statement.executeBatch();
		statement.close();
	}
	
	private Map<String, Integer> getNameIDMap(DatabaseConnection conn, String procedure, String nameCol, String idCol) throws SQLException
	{
		ResultSet rs = conn.callProcedure(procedure);
		Map<String, Integer> ret = new HashMap<String, Integer>();
		while(rs.next())
		{
			ret.put(rs.getString(nameCol), rs.getInt(idCol));
		}
		rs.close();
		return ret;
	}
	
	private Map<Integer, List<String>> getIDNameListMap(DatabaseConnection conn, String procedure, String idCol, String nameCol) throws SQLException
	{
		ResultSet rs = conn.callProcedure(procedure);
		Map<Integer, List<String>> ret = new HashMap<Integer, List<String>>();
		while(rs.next())
		{
			int id = rs.getInt(idCol);
			if(ret.get(id) == null)
			{
				ret.put(id, new ArrayList<String>());
				ret.get(id).add(rs.getString(nameCol));
			}
			else
			{
				ret.get(id).add(rs.getString(nameCol));
			}
		}
		rs.close();
		return ret;
	}
	
	private Map<Integer, List<Pair<Integer, String>>> getIDPairListMap(DatabaseConnection conn, String procedure, String idCol1, String idCol2, String nameCol) throws SQLException
	{
		ResultSet rs = conn.callProcedure(procedure);
		Map<Integer, List<Pair<Integer, String>>> ret = new HashMap<Integer, List<Pair<Integer, String>>>();
		while(rs.next())
		{
			int id = rs.getInt(idCol1);
			if(ret.get(id) == null)
			{
				ret.put(id, new ArrayList<Pair<Integer, String>>());
				ret.get(id).add(new Pair<Integer, String>(rs.getInt(idCol2), rs.getString(nameCol)));
			}
			else
			{
				ret.get(id).add(new Pair<Integer, String>(rs.getInt(idCol2), rs.getString(nameCol)));
			}
		}
		rs.close();
		return ret;
	}
	
	public static final String INSERT_ARTIST = "INSERT INTO artist (Name) VALUES (?);";
	public static final String INSERT_ALBUM = "INSERT INTO album (idartist,Name) VALUES (?,?);";
	public static final String INSERT_TRACK = "INSERT INTO track (idalbum,idartist,Name,FCC,Recommended, ITLID, Path, idPrimaryGenre,idSecondaryGenre,idsubsonic) VALUES (?,?,?,?,?,?,?,?,?,?);";
	public static final String UPDATE_TRACK = "update track set idalbum = ?, idartist = ?, Name = ?, FCC = ?, Recommended = ?, Path = ?, idPrimaryGenre = ?, idSecondaryGenre = ?, idsubsonic = ? where ITLID = ?;";
	public static final String SELECT_TRACK = "SELECT * FROM track;";
	
}
