package libraryManager;

import java.util.List;
import sqlConnect.DBINFO;


public class Track
{
		private static final String EXPLICIT_TAG = "[EXPLICIT]";
		private static final String RECO_TAG = "[RECO]";
        private String name;
        private String artist;
        private String album;
        private int ID;
        private String path;
        private int trackNum;
        private int iTunesID;
        private String primaryGenre;
        private String secondaryGenre;
        private long totalTime;
        private long sampleRate;
        private boolean FCC;
        private int playCount;
        private boolean recommended;

        public Track()
        {
        	FCC = false;
        	recommended = false;
        }
        
        public String getName() 
        {
            return name;
        }

        public void setName(String name) 
        {
            this.name = name;
            if(name.toUpperCase().contains(EXPLICIT_TAG))
            {
            	setFCC(true);
            	stripTag(EXPLICIT_TAG);
            }
            if(name.toUpperCase().contains(RECO_TAG))
            {
            	setRecommended(true);
            	stripTag(RECO_TAG);
            }
        }
        
        public void setRecommended(boolean value)
        {
        	recommended = value;
        }
        
        public void setFCC(boolean value)
        {
        	FCC = value;
        }

        public String getArtist() 
        {
            return artist;
        }

        public void setArtist(String artistName) 
        {
            this.artist = artistName;
        }

        public String getAlbum() 
        {
            return album;
        }

        public void setAlbum(String albumName) 
        {
            this.album = albumName;
        }

        public int getPlayCount() 
        {
            return playCount;
        }

        public void setPlayCount(int playCount) 
        {
            this.playCount = playCount;
        }
        
        public void setID(int newId)
        {
        	ID = newId;
        }
        
        public int getID()
        {
        	return ID;
        }
        
       public String dbQuery(List<String> genres)
        {
        	//Escape apostrophes
        	this.name = this.name.replaceAll("'","");
        	this.name = this.name.length() > 100 ? this.name.substring(0, 99) : this.name;
        	this.artist = this.artist.replaceAll("'","");
        	this.artist = this.artist.length() > 100 ? this.artist.substring(0, 99) : this.artist;
        	this.album = this.album.replaceAll("'","");
        	this.album = this.album.length() > 100 ? this.album.substring(0, 99) : this.album;
        	if(this.primaryGenre != null)
        	{
        		int gPos = genres.indexOf(primaryGenre.toLowerCase());
        		if(gPos != -1)
        		{
        			this.primaryGenre = this.primaryGenre.replaceAll("'","");
        			this.primaryGenre = this.primaryGenre.length() > 100 ? this.primaryGenre.substring(0, 99) : this.primaryGenre;
        		}
        		else
        		{
        			primaryGenre = null;
        		}
        	}
        	if(this.secondaryGenre != null)
        	{
        		int gPos = genres.indexOf(secondaryGenre.toLowerCase());
        		if(gPos != -1)
        		{
        			this.secondaryGenre = this.secondaryGenre.replaceAll("'","");
        			this.secondaryGenre = this.secondaryGenre.length() > 100 ? this.secondaryGenre.substring(0, 99) : this.secondaryGenre;
        		}
        		else
        		{
        			secondaryGenre = null;
        		}
        	}
       
        	this.path = this.path.replaceAll("'", "");
        	
        	//escape %20
        	this.path = this.path.replaceAll("%20", " ");
        	
        	//Query goes : Name, Artist, Album, PlayCount, FCCFlag, Recommended, ItunesID, ReleaseDate, EndDate
        	String query = "Call " + DBINFO.DATABASE + "." + DBINFO.ADDTRACK + "('" + this.name + "','" +
        			this.artist + "','" + this.album + "'," + this.playCount + "," + this.FCC + "," + 
        			this.recommended + "," + 
        			iTunesID + ",null, null," + (this.primaryGenre != null ? "'" + this.primaryGenre + "'" : "null") + "," + (this.secondaryGenre != null ? "'" + this.secondaryGenre + "'" : "null") + ",'" + this.path + "');"; 
        	return query;
        	
        }

		/*public void setLocation(String tempVal) 
		{
			path = tempVal;
			
		}*/

		public void setTrackNumber(Integer value) 
		{
			trackNum = value;
			
		}
		
		public int getTrackNumber()
		{
			return trackNum;
		}

		public void setITL(Integer value) 
		{
			iTunesID = value;	
		}
		
		public void setPath(String value)
		{
			path = value;
		}
		
		public String getPath()
		{
			return path;
		}

		public void setTotalTime(Integer value) 
		{
			totalTime = value;	
		}
		
		public void setPrimaryGenre(String pGenre)
		{
			primaryGenre = pGenre;
		}
		
		public String getPrimaryGenre()
		{
			return primaryGenre;
		}
		
		public void setSecondaryGenre(String sGenre)
		{
			secondaryGenre = sGenre;
		}
		
		public String getSecondaryGenre()
		{
			return secondaryGenre;
		}

		public void setSampleRate(Integer value) 
		{
			sampleRate = value;
		}
		
		public long getSampleRate()
		{
			return sampleRate;
		}
		
		public int getITunesID()
		{
			return iTunesID;
		}
		
		public boolean equalsITunesID(Track other)
		{
			return other.getITunesID() == this.iTunesID;
		}
		
		@Override
		public boolean equals(Object obj)
		{
			if(!(obj instanceof Track))
			{
				return false;
			}
			
			Track other = (Track) obj;
			return other.getID() == this.ID;
		}
		
		private void stripTag(String tag)
		{
			name = name.toUpperCase().replace(tag, "").trim();
		}
}
