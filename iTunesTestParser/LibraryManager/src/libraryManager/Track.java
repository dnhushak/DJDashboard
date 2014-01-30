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

        private int playCount;

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
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
        			this.artist + "','" + this.album + "'," + this.playCount + ",null,null," + 
        			iTunesID + ",null, null);"; 
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

		public void setTotalTime(Integer value) {
			totalTime = value;
			
		}

		public void setSampleRate(Integer value) {
			sampleRate = value;
			
		}

	
	
}
