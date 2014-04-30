package libraryManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DBTest 
{
	public static void main(String[] args) 
	{
		SAXParserExample parser = new SAXParserExample();
		SAXParserExample.setFilePath("C:\\iTunes Library.xml");
		parser.run();
		List<Track> library = parser.getTracks();
		
		/*ArrayList<String> genres = new ArrayList<String>();
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
		}*/
		
		Connection conn;
		try 
		{
			conn = DriverManager.getConnection("jdbc:mysql://mysql.cs.iastate.edu/db30919", "u30919", "pkMDpK6Rh");
			
			//test to see if connected to the database. This returned all table names
			/*DatabaseMetaData md = conn.getMetaData();
			ResultSet rs = md.getTables(null, null, "%", null);
			while (rs.next())
			{
				System.out.println(rs.getString(3));
			}
			rs.close();*/
			
			Statement stmt = conn.createStatement();
			
			//inserted genres
			/*PreparedStatement stmt1 = conn.prepareStatement("insert into genre (name) values(?)");
			int numRows = 0;
			for(String genre : genres)
			{
				stmt1.setString(1, genre);
				numRows += stmt1.executeUpdate();
				
			}
			System.out.println(numRows);
			stmt1.close();*/
			
			//check to see how many lower case explicit and reco tags
			ResultSet rs1 = stmt.executeQuery("Select * from track");
			/*String name;
			int eCount = 0;
			int rCount = 0;
			while(rs1.next())
			{
				name = rs1.getString("name");
				if(name.contains("[Explicit]"))
				{
					System.out.println("Explicit track: " + name);
					eCount++;
				}
				
				if(name.contains("[Reco]"))
				{
					System.out.println("Reco track: " + name);
					rCount++;
				}
			}
			System.out.println("\nTotal explicit tracks: " + eCount); //118 of these
			System.out.println("\nTotal reco tracks: " + rCount); //3196 of these*/
			
			//check to see column names in track table
			System.out.println();
			ResultSet rs2 = stmt.executeQuery("SELECT * FROM track");
			ResultSetMetaData rsmd = rs2.getMetaData();
			int count = 1;
			while (count < 16)
			{
				String cname = rsmd.getColumnName(count);
				System.out.println(cname);
				count++;
			}
			rs2.close();
			
			PreparedStatement selectTrack = conn.prepareStatement("select * from track where ITLID = ?");
			PreparedStatement updateTrackGenre = conn.prepareStatement("update track set idPrimaryGenre = ?, idSecondaryGenre = ? where ITLID = ?");
			PreparedStatement selectGenre = conn.prepareStatement("select * from genre where name = ?");
			ResultSet rsTrack = null;
			ResultSet rsGenre = null;
			int trackUpdated = 0;
			int tracks = 0;
			for(Track track : library)
			{
				int pID = 0;
				int sID = 0;
				boolean pGenreNull = track.getPrimaryGenre() == null;
				boolean sGenreNull = track.getSecondaryGenre() == null;
				
				selectTrack.setInt(1, track.getITunesID());
				rsTrack= selectTrack.executeQuery();
				rsTrack.next();
				
				if(pGenreNull) 
				{ 
					updateTrackGenre.setNull(1, Types.INTEGER);
				}
				else
				{
					selectGenre.setString(1, track.getPrimaryGenre());
					rsGenre = selectGenre.executeQuery();
					rsGenre.next();
					pID = rsGenre.getInt("idgenre");
					updateTrackGenre.setInt(1, pID);
				}
		
				if(sGenreNull) 
				{ 
					updateTrackGenre.setNull(2, Types.INTEGER);
				}
				else
				{
					selectGenre.setString(1, track.getSecondaryGenre());
					rsGenre = selectGenre.executeQuery();
					rsGenre.next();
					sID = rsGenre.getInt("idgenre");
					updateTrackGenre.setInt(2, sID);
				}
				updateTrackGenre.setInt(3, track.getITunesID());
				tracks++;
				System.out.println("Tracks looked at: " + tracks + ";Update Count: " + (trackUpdated += updateTrackGenre.executeUpdate()));
			}
			System.out.println("\nTotal Tracks updated: " + trackUpdated);
			
			if(rsTrack != null) { rsTrack.close(); }
			if(rsGenre != null) { rsGenre.close(); }
			selectTrack.close();
			updateTrackGenre.close();
			selectGenre.close();
			
			rs1.close();
			stmt.close();
			conn.close();
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
	}
}
