package thrillio.project.util;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;

public class HttpConnect {

	
	public static String download(String sourceUrl) throws MalformedURLException, URISyntaxException {
		URL url = new URI(sourceUrl).toURL();		
		
		try {
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			int responseCode = con.getResponseCode();	
			
			if(responseCode >= 200 && responseCode < 300) { // ok
				return IOUtil.read(con.getInputStream());		        
			}
			System.out.println("Downloading: " + sourceUrl);
		} catch (IOException e) {

			e.printStackTrace();
		}	
		
		return null;

	}
}
