package servlet;

import java.io.IOException;
import java.io.PrintWriter;

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

public class cart extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		
		PrintWriter out = resp.getWriter();
		
		String good = req.getParameter("id");
		int num = 0, change_num = 0, change = 0 ;
		if(req.getParameter("num") != null)
			num = Integer.parseInt(req.getParameter("num"));
		if(req.getParameter("change_num") != null)
		{
			change_num = Integer.parseInt(req.getParameter("change_num"));
			if (change_num == 0)
				change = 1;
		}
		
		if(req.getUserPrincipal() == null){
			out.print("<script>alert('Please login first!');</script>");
	    	out.print("<script>window.location.href='store.jsp';</script>");
		}
		else{
			String user = req.getUserPrincipal().getName(); 
			DatastoreService ds=DatastoreServiceFactory.getDatastoreService();
			int flag = 0;
			Query q=new Query("cart").addFilter("user", FilterOperator.EQUAL, user).addFilter("good", FilterOperator.EQUAL, good);
			PreparedQuery pq=ds.prepare(q);
			for(Entity u1:pq.asIterable()){
				if(change_num != 0)
					num = change_num;
				else
					num = Integer.parseInt(u1.getProperty("num").toString()) + num;
				if(change == 1){
					Key id = u1.getKey();
					ds.delete(id);
				}
				else{
					u1.setUnindexedProperty("num", num);
					ds.put(u1);
					flag = 1;
				}
			}
			if (flag == 0 && change != 1){
				Entity e=new Entity("cart");
				e.setProperty("good", good);
				e.setProperty("user", user);
				if(change_num != 0)
					num = change_num;
				else
					num = num;
				e.setUnindexedProperty("num", num);
				ds.put(e);
			}
			
			out.print("<script>alert('Add successfully!');</script>");
	    	out.print("<script>window.location.href='cart.jsp';</script>");
		}
	}
}
