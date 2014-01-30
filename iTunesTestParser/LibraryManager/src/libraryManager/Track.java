package libraryManager;

import sqlConnect.DBINFO;


public class Track
{

        private String name;
        private String artist;
        private String album;
        private int ID;
        private String path;
        private int trackNum;
        private int iTunesID;
        private long totalTime;
        private long sampleRate;
        private boolean FCC;
        private int playCount;
        private boolean recommended;

        public String getName() {
            return name;
        }

        public Track()
        {
        	FCC = false;
        	recommended = false;
        }
        
        public void setName(String name) {
            this.name = name;
            if(name.contains("EXPLICIT"))
            {
            	setFCC(true);
            }
            if(name.toUpperCase().contains("RECO"))
            {
            	setRecommended(true);
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

        public String getArtist() {
            return artist;
        }

        public void setArtist(String artistName) {
            this.artist = artistName;
        }

        public String getAlbum() {
            return album;
        }

        public void setAlbum(String albumName) {
            this.album = albumName;
        }

        public int getPlayCount() {
            return playCount;
        }

        public void setPlayCount(int playCount) {
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
        
        public String dbQuery()
        {
        	
        	//Query goes : Name, Artist, Album, PlayCount, FCCFlag, Recommended, ItunesID, ReleaseDate, EndDate
        	String query = "Call " + DBINFO.DATABASE + "." + DBINFO.ADDTRACK + "('" + this.name + "','" +
        			this.artist + "','" + this.album + "'," + this.playCount + "," + this.FCC + "," + 
        			this.recommended + "," + 
        			iTunesID + ",null, null, '" + this.path + "');"; 
        	return query;
        	
        }

		public void setLocation(String tempVal) {
			path = tempVal;
			
		}

		public void setTrackNumber(Integer value) {
			trackNum = value;
			
		}

		public void setITL(Integer value) {
			iTunesID = value;
			
		}
		
		public void setPath(String value)
		{
			path = value;
		}

		public void setTotalTime(Integer value) {
			totalTime = value;
			
		}

		public void setSampleRate(Integer value) {
			sampleRate = value;
			
		}

	
	
}
