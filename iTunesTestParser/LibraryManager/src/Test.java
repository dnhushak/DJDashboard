import libraryManager.Library;


public class Test {

	public static void main(String[] args) {
		
		
		Library lib = new Library();
		lib.createFromITunesDB("C:\\Users\\rclabough\\Dropbox\\iTunes Library.xml");
	
    	lib.addAllToDB();

	}

}
