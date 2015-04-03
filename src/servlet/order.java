package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.*;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;



public class order extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		PrintWriter out = resp.getWriter();
		
		String name = req.getParameter("name");
		String phone = req.getParameter("phone");
		String mail = req.getParameter("mail");
		String email = req.getParameter("email");
		String address = req.getParameter("address");
		
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		String orderid = df.format(new Date()) + UUID.randomUUID();
		
		DatastoreService ds=DatastoreServiceFactory.getDatastoreService();
		String user = req.getUserPrincipal().getName(); 
		
		Entity e=new Entity("order");
		e.setProperty("name", name);
		e.setProperty("user", user);
		e.setProperty("orderid", orderid);
		e.setProperty("status", "pending");
		e.setUnindexedProperty("phone", phone);
		e.setUnindexedProperty("mail", mail);
		e.setUnindexedProperty("email", email);
		e.setUnindexedProperty("address", address);
		
		ds.put(e);
		
		
		Query q=new Query("cart").addFilter("user", FilterOperator.EQUAL, user);
		PreparedQuery pq=ds.prepare(q);
		
		for(Entity u1:pq.asIterable()){
			String goodid = u1.getProperty("good").toString();
			String num = u1.getProperty("num").toString();
			
			Entity e1=new Entity("order_items");
			e1.setProperty("orderid", orderid);
			e1.setUnindexedProperty("good", goodid);
			e1.setUnindexedProperty("num", num);
			ds.put(e1);
			
			Key id = u1.getKey();
			ds.delete(id);
		}
		
		out.print("<script>alert('Order successfully!');</script>");
    	out.print("<script>window.location.href='checkorder.jsp';</script>");
	}
}
