package libraryManager;

import java.util.Map;
import java.text.Normalizer;
import java.util.regex.Pattern;

import utility.Pair;

public class ITunesTrack extends Track
{
	private String album;
    	private String artist;
    	private String primaryGenre;
    	private String secondaryGenre;
    	private boolean FCC;
    	private boolean recommended;
	private int subsonicID;

    	public ITunesTrack() {}
    
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

     	public void setArtist(String artist) 
	{
		this.artist = artist;
     	}

     	public String getAlbum() 
     	{
    	 	return album;
     	}

     	public void setAlbum(String album) 
     	{
    	 	this.album = album;
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
	 
	public boolean getFCC()
	{
		return FCC;
	}
		
	public boolean getRecommended()
	{
		return recommended;
	}
	 
	public int getSubsonicID()
	{
		return subsonicID;
	}
	 	
	@Override
	public boolean equals(Object obj)
	{
		if(obj == null) { return false; }
		if(!(obj instanceof ITunesTrack)) { return false; }
			
		ITunesTrack other = (ITunesTrack) obj;
		return this.id == other.id;
	}
	 
	public void sanitize()
	{
		if(name == null) { name = "Unknown Name"; }
		if(artist == null) { artist = "Unknown Artist"; }
		if(album == null) { album = "Unknown Album"; }
		 
		if(name.toUpperCase().contains(EXPLICIT_TAG))
	     	{
			FCC = true;
			stripTagFromTrackName(EXPLICIT_TAG);
	     	}
	     	if(name.toUpperCase().contains(RECO_TAG))
	     	{
	    		recommended = true;
	    	 	stripTagFromTrackName(RECO_TAG);
	     	}
	     	name = sanitizeString(name);
	     	artist = sanitizeString(artist);
	     	album = sanitizeString(album);
	     	primaryGenre = sanitizeString(primaryGenre);
	     	secondaryGenre = sanitizeString(secondaryGenre);
	}
		
	/**
	 * Removes given tag from the track name
	 * @param tag
	 * the tag to be removed
	 */
	private void stripTagFromTrackName(String tag)
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
			
			word = temp.substring(lBracket, rBracket + 1); //any word in the for of [word]
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
		if(str == null) return null;
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
		for(String s : ARTICLES)
		{
			if(str.equalsIgnoreCase(s))
			{
				return true;
			}
		}
		return false;
	}
	 
	public static final String EXPLICIT_TAG = "[EXPLICIT]";
	public static final String RECO_TAG = "[RECO]";
	public static final String[] ARTICLES = { "THE", "LA", "LOS", "LAS", "LE", "LES" };
}

