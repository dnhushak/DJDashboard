package libraryManager;

import java.util.Map;
import java.text.Normalizer;
import java.util.regex.Pattern;
import sqlConnect.DBINFO;

public class Track
{
	public static final String EXPLICIT_TAG = "[EXPLICIT]";
	public static final String RECO_TAG = "[RECO]";
	public static final String[] articles = { "THE", "LA", "LOS", "LAS", "LE", "LES" };
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
	private int subsonicID;

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
		this.name = sanatizeString(this.name);
    }
	 
	public void setSubsonicID(int sID)
    {
    	subsonicID = sID;
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
    	artist = sanatizeString(artistName);
    }

    public String getAlbum() 
    {
    	return album;
    }

    public void setAlbum(String albumName) 
    {
    	album = sanatizeString(albumName);
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
        
    public String dbQuery(Map<String, Pair<Integer, String>> genres)
    {
         //Escape apostrophes
    	if(name != null)
    	{
    		name = name.replaceAll("'","");
    		name = name.length() > 100 ? name.substring(0, 99) : name;
    	}
        if(artist != null)
    	{
        	artist = artist.replaceAll("'","");
            artist = artist.length() > 100 ? artist.substring(0, 99) : artist;
    	}
        if(album != null)
        {
        	album = album.replaceAll("'","");
            album = album.length() > 100 ? album.substring(0, 99) : album;
        }
        if(path != null)
        {
        	path = path.replaceAll("'", "");
        	path = path.replaceAll("%20", " "); //escape %20
        }
        	
        int pGenre = primaryGenre != null ? verifyGenre(genres, primaryGenre) : -1;
        int sGenre = secondaryGenre != null ? verifyGenre(genres, secondaryGenre) : -1;
        		
        StringBuilder query = new StringBuilder();
        query.append("Call " + DBINFO.DATABASE + "." + DBINFO.ADDTRACK + "(");
        query.append((name != null ? "'" + name + "'," : "'Unkown Name',"));         //name
        query.append((artist != null ? "'" + artist + "'," : "'Unkown Artist',"));   //artist
        query.append((album != null ? "'" + album + "'," : "'Unknown Album',"));     //album
        query.append(playCount + ",");                                               //play count
        query.append(FCC + ",");                                                     //FCC
        query.append(recommended + ",");                                             //recommended
        query.append(iTunesID + ",null,null,");                                      //iTunesID, release date, end date
        query.append((pGenre != -1 ? pGenre : "null") + ",");                        //primary genre
        query.append((sGenre != -1 ? sGenre : "null") + ",");                        //secondary genre
        query.append((path != null ? "'" + path + "'," : "null,"));                  //path
        query.append((this.subsonicID != -1 ? this.subsonicID : "null"));            //subsonic id
        query.append(");");
        return query.toString();
    }

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
	
	public long getTotalTime()
	{
		return totalTime;
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
		return other.iTunesID == this.iTunesID;
	}
		
	@Override
	public boolean equals(Object obj)
	{
		if(obj == null || !(obj instanceof Track)) { return false; }
			
		Track other = (Track) obj;
		return other.ID == this.ID;
	}
	
	public void sanitize()
	{
		if(name == null) { name = "Unknown Name"; }
		if(artist == null) { artist = "Unknown Artist"; }
		if(album == null) { album = "Unknown Album"; }
		 
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
	    name = sanitizeString(name);
	    artist = sanitizeString(artist);
	    album = sanitizeString(album);
	}
		
	/**
	* Removes given tag from the track name
	* @param tag
	* the tag to be removed
	*/
	private void stripTag(String tag)
	{
		String temp = name;
		String word = null;
		int lBracket = -1;
		int rBracket = -1;
			
		while(temp.length() != 0)
		{
			lBracket = temp.indexOf("[");
			rBracket = temp.indexOf("]");
			
			if(lBracket == -1 || rBracket == -1) { break; } //no potential tags left, so exit
			
			word = temp.substring(lBracket, rBracket + 1); //any word in the form of [word]
			temp = temp.substring(Math.min(temp.length(), (rBracket + 1))); //only keeps everything to the right of ']'
			if(word.equalsIgnoreCase(tag))
			{
				name = name.replace(word, "");
			}
		}
		name = name.trim();
	}
		
	/**
	* Makes sure that genre for the track is a valid genre in the database
	* @param genres
	* collection of genres in the form of COMPARISON_GENRE_NAME=[Database_Genre_id, Database_Genre_name]
	* @param genre
	* genre of the track
	* @return
	* returns the database id of the genre if the genre is valid and -1 if it is not
	*/	
	public int verifyGenre(Map<String, Pair<Integer, String>> genres, String genre)	
	{
		if(genres == null || genre == null) { return -1; }
			
		Pair<Integer, String> pair = genres.get(genre.toUpperCase());
		if(pair != null) 
		{ 
			return pair.getFirst(); 
		}
		return -1;
	}
	 
	private String sanitizeString(String str)
	{
		str = removeAccent(str);
		str = singleSpacedAndCapitalize(str);
		str = removeArticle(str);
		return str;
	}
	 
	/**
	* converts letters with accents to the same English character without the accent. All credit goes to
	* this source: http://stackoverflow.com/questions/1008802/converting-symbols-accent-letters-to-english-alphabet
	*/
	private String removeAccent(String str) 
	{
		String nfdNormalizedString = Normalizer.normalize(str, Normalizer.Form.NFD); 
		Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
		str = pattern.matcher(nfdNormalizedString).replaceAll("");
		return str;
	}
	 
	private String singleSpacedAndCapitalize(String str)
	{
		StringBuilder sb = new StringBuilder();
		String[] strings = str.split("\\s+|\\t+");
		for(int i = 0; i < strings.length; i++)
		{
			if(strings[i].length() > 1)
			{
				sb.append(strings[i].substring(0, 1).toUpperCase());
				sb.append(strings[i].substring(1, strings[i].length()));
			}
			else
			{
				sb.append(strings[i].toUpperCase());
			}
			 
			if(i != strings.length - 1)
			{
				sb.append(" ");
			}
		}
		return sb.toString();
	}
	 
	private String removeArticle(String str)
	{
		String[] strings = str.split("\\s+|\\t+");
		if(strings.length > 1 && isArticle(strings[0]) && !strings[0].equalsIgnoreCase(strings[1]))
		{
			StringBuilder sb = new StringBuilder();
			for(int i = 1; i < strings.length; i++)
			{
				sb.append(strings[i]);
				if(i != strings.length - 1)
				{
					sb.append(" ");
				}
			}
			return sb.toString();
		}
		return str;
	}
	 
	private boolean isArticle(String str)
	{
		for(String s : articles)
		{
			if(str.equalsIgnoreCase(s))
			{
				return true;
			}
		}
		return false;
	}
}
