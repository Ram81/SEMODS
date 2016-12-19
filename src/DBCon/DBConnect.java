package DBCon;
import com.mongodb.*;
import java.net.*;

public class DBConnect 
{
	public static DBConnect instance;
	public MongoClient conn=null;
	public DB db=null;
	
	public DBConnect()throws UnknownHostException
	{
		this.conn=new MongoClient("localhost",27017);
		this.db=conn.getDB("CloudDB");
	}
	
	public static DBConnect getInstance()throws UnknownHostException
	{
		if(DBConnect.instance==null)
			DBConnect.instance=new DBConnect();
		return DBConnect.instance;
	}
	public DBCollection getCollection(String colName)
	{
		return this.db.getCollection(colName);
	}
}
