import java.io.IOException;
import java.util.Scanner;


public class Setup {

	public static void main(String[] args) {

		DatabaseObject data = new DatabaseObject();
		System.out.println("This is a simple setup program for the database.");
		System.out.println("Setup created by Robert Clabough");
		System.out.println("DJ Dashboard created by Caleb Van Dyke, Robert Clabough, Darren Hushak, and Alex Cole");
		System.out.println();
		System.out.println("Press enter to begin");
		Scanner keyboard = new Scanner(System.in);
		keyboard.nextLine();
		data.setupConnection(keyboard);
		System.out.println("\nInputs completed.\n\nCreate config XML file? (Y/N)");
		if(keyboard.nextLine().equalsIgnoreCase("Y")){
			data.buildXML("config.xml");
		}
		System.out.println("\n\nDeploy to Database (DANGEROUS - Will delete any existing Schema!)");
		if(keyboard.nextLine().equalsIgnoreCase("Y")){
			try {
				data.deploy("master.sql");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				System.out.println("Error Opening or saving files!");
				e.printStackTrace();
			}
		}
		
		keyboard.close();
		
		System.out.println("Database setup complete.  Please note the output files in the output directory.");
	}

}
