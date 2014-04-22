import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.SQLException;
import java.util.Scanner;

public class DatabaseObject {
	private String connectionString = "";
	private String username = "";
	private String password = "";
	private String schema = "";
	private String port = "3306";
	private final String REPLACE_SCHEMA = "db30919|DB30919";
	private final String REPLACE_HOST = "mysql.cs.iastate.edu";
	private final String REPLACE_USER = "u30919";

	public void setupConnection(Scanner keyboard) {
		System.out.println("Database setup");
		boolean isCorrect = false;
		System.out.println("First let's set up the connection.");
		boolean isComplete = false;
		while (!isComplete) {
			while (!isCorrect) {
				System.out
						.println("Please enter the connection string. (e.x. mysql.mywebsite.org)");
				connectionString = keyboard.nextLine();
				System.out.println("Is '" + connectionString
						+ "' correct? (Y/N)");
				if (keyboard.nextLine().equalsIgnoreCase("Y")) {
					isCorrect = true;
				}
			}
			isCorrect = false;
			while (!isCorrect) {
				System.out
						.println("Please enter the username string. (e.x. myusername)");
				username = keyboard.nextLine();
				System.out.println("Is '" + username + "' correct? (Y/N)");
				if (keyboard.nextLine().equalsIgnoreCase("Y")) {
					isCorrect = true;
				}
			}
			isCorrect = false;
			while (!isCorrect) {
				System.out
						.println("Please enter the password. (e.x. haXXorZ123)");
				password = keyboard.nextLine();
				System.out.println("Is '" + password + "' correct? (Y/N)");
				if (keyboard.nextLine().equalsIgnoreCase("Y")) {
					isCorrect = true;
				}
			}
			isCorrect = false;
			while (!isCorrect) {
				System.out.println("Please enter the schema. (e.x. kureradio)");
				schema = keyboard.nextLine();
				System.out.println("Is '" + schema + "' correct? (Y/N)");
				if (keyboard.nextLine().equalsIgnoreCase("Y")) {
					isCorrect = true;
				}
			}

			isCorrect = false;
			while (!isCorrect) {
				System.out.println("Please enter the port. (e.x. 3306)");
				port = keyboard.nextLine();
				System.out.println("Is '" + port + "' correct? (Y/N)");
				if (keyboard.nextLine().equalsIgnoreCase("Y")) {
					isCorrect = true;
				}
			}

			System.out.println("Please verify your settings.");
			System.out.println();
			System.out.println("Connection String: " + connectionString);
			System.out.println("Username: " + username);
			System.out.println("Password: " + password);
			System.out.println("Schema: " + schema);
			System.out.println("Port: " + port);
			System.out.println();
			System.out.println("Are all of these correct? (Y/N)");
			if (keyboard.nextLine().equalsIgnoreCase("Y")) {
				isComplete = true;
			}
		}
	}

	public void buildXML(String path) {
		StringBuilder sb = new StringBuilder();
		sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
		sb.append("<configuration>\n");
		sb.append("<database connectionString=\"" + this.connectionString
				+ "\" port=\"" + this.port + "\" password=\"" + this.password
				+ "\" schema=\"" + this.schema + "\" />\n");
		sb.append("</configuration>\n");
		File out = new File(path);
		// Create things as needed
		System.out
				.println("----------------------------XML Output----------------------------");
		System.out.println();
		System.out.println(sb.toString());
		System.out.println();
		System.out
				.println("------------------------------------------------------------------");
		try (FileWriter fw = new FileWriter(out)) {
			fw.write(sb.toString());
		} catch (Exception e) {
			// TODO something more sophisticated
			e.printStackTrace();
		}
	}

	public void deploy(String path) throws IOException {
		// First create master script
		String cmd = createMasterScript(path);
		try {
			DatabaseConnection connection = new DatabaseConnection(this.schema,
					this.connectionString, this.username, this.password,
					this.port);
			System.out.println("Creating Schema.  This can take a while.");
			connection.callProcedure(cmd);
			System.out.println("Schema creation complete.");
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println("ERROR EXECUTING IN DATABASE");
			e.printStackTrace();
			System.out.println(e.getMessage());
			System.out
					.println("\nDo not worry!  You can still create the database by running 'master.sql' on your database.");
		}

	}

	private String createMasterScript(String path) throws IOException {

		StringBuilder masterFile = new StringBuilder();
		String createScript = "CREATE SCHEMA " + this.schema
				+ " CHARACTER SET latin1;\n";
		// masterFile.append(createScript);
		File folder = new File("scripts");
		processScripts(folder, masterFile);
		String output = FindAndReplace(masterFile.toString());

		File out = new File(path);
		FileWriter fw = new FileWriter(out);
		fw.write(output);
		fw.close();
		return output;
	}

	private void processScripts(File folder, StringBuilder appendable)
			throws IOException {
		for (File fileEntry : folder.listFiles()) {
			if (!fileEntry.isDirectory()) {
				System.out.println("\t\tProcessing File: "
						+ fileEntry.getName());
				ReadEntireFile(fileEntry, appendable);
			} else {
				System.out.println("\t\tError processing: "
						+ fileEntry.getName());
			}
		}
	}

	private void ReadEntireFile(File file, StringBuilder appendable)
			throws IOException {
		String line;

		BufferedReader reader = new BufferedReader(new FileReader(file));
		while ((line = reader.readLine()) != null) {
			appendable.append(line);
			appendable.append("\n");
		}
		reader.close();
	}

	private String FindAndReplace(String input) {

		String output = input.replaceAll(REPLACE_SCHEMA, this.schema);
		 output = output.replaceAll(REPLACE_USER, this.username);
		// this.schema + "`" );
		output = output.replaceAll(REPLACE_HOST, this.connectionString);
		return output;
	}
}
