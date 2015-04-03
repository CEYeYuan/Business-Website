package servlet;

import java.io.IOException;
import java.math.BigInteger;

import javax.servlet.http.*;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.EntityNotFoundException;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.FilterOperator;


public class Insert extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
	
		DatastoreService ds=DatastoreServiceFactory.getDatastoreService();
		Key employeeKey = null;
		/*long id = 4785074604081152L;
		Key employeeKey = KeyFactory.createKey("goods", id);*/
		Query q=new Query("goods");
		PreparedQuery pq=ds.prepare(q);
		for (Entity u1:pq.asIterable()){
			Key id = u1.getKey();
			String goodid = KeyFactory.keyToString(id);
			System.out.print(goodid);
			employeeKey = KeyFactory.stringToKey(goodid);
		}
		
		Entity employee = null;
		try {
			employee = ds.get(employeeKey);
			System.out.print("2");
			System.out.print(employee.getProperty("price"));
		} catch (EntityNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
	}
}
