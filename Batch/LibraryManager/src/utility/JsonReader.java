package utility;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * Utility class to read json text from a url
 * credit for static methods to help read json from a url: http://stackoverflow.com/questions/4308554/simplest-way-to-read-json-from-a-url-in-java
 */
public class JsonReader 
{
	/**
	 * Reads through a character stream and creates a string.
	 * @param rd
	 * The reader to read through the stream.
	 * @return
	 * A string of all the characters read by the reader.
	 * @throws IOException
	 * If an error is encountered while reading the stream.
	 */
	private static String readAll(Reader rd) throws IOException 
	{
		StringBuilder sb = new StringBuilder();
		int cp;
		while ((cp = rd.read()) != -1) 
		{
			sb.append((char) cp);
		}
		return sb.toString();
	}

	/**
	 * Converts json text from a url into a JSONObject
	 * @param url
	 * The url to read json text from
	 * @return
	 * A representation of the url json text as a JSONObject
	 * @throws IOException
	 * If the reader encounters an error while reading
	 * @throws JSONException
	 * If the if the url does not contain valid json text
	 */
	public static JSONObject readJsonFromUrl(String url) throws IOException, JSONException 
	{
		InputStream is = new URL(url).openStream();
		try 
		{
			BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
			String jsonText = readAll(rd);
			JSONObject json = new JSONObject(jsonText);
			return json;
		} 
		finally 
		{
			is.close();
		}
	}
}
