package encp;
import java.sql.DriverManager;
import java.sql.*;


public class jjj {
	public static void main(String args[])throws Exception
	{
		
		try
		{
			Class.forName("com.jdbc.mysql.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/temp","root","");
			
			String zone="abc";	//assign zone from textbox to zone variable
			String category="Open"; //assign Category from input textbox to zone variable
			int cutoff=120; //assign total marks from input textbox
			
			String qry="";
			
			if(category.equals("Open"))
				qry="Select * from science where Zone='"+zone+"' AND Cutoff_Open<="+(cutoff+10)+" AND ";
			else if(category.equals("SC"))
			{
				qry="Select * from science where Zone='"+zone+"' AND Cutoff_SC<="+cutoff+" ";
				//based on category change attribute 				----cutoff_<category>
				//cutoff +10 includes your 1 or more additional colleges above your total marks
				//you can extend qry by adding condition in qry string or deleting any of condition
				//feel free to change the code
			}
			
			Statement stmnt=con.createStatement();
			
			ResultSet output=stmnt.executeQuery(qry);
			//ResultSet object contains resultant output of the executed select query
			
			
			//You can access your resultant records using output.get<Data_Type_of_column>("Column name")
			//if more than one records are retrieved then iterate through ResultSet using 
			while(output.next())
			{
				System.out.println(output.getInt("College Code"));
			}
		}
		catch(Exception e)
		{
			System.out.println("Exception "+e);
		}
	}
}
