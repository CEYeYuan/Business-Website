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

public class delete extends HttpServlet{
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		PrintWriter out = resp.getWriter();
		String orderid=req.getParameter("orderid");
		String url="support.jsp";
		

		DatastoreService ds=DatastoreServiceFactory.getDatastoreService();
	
		
		
		Query q=new Query("order").addFilter("orderid", FilterOperator.EQUAL, orderid);
		PreparedQuery pq=ds.prepare(q);
		
		for(Entity u1:pq.asIterable()){
			
			Key id = u1.getKey();
			ds.delete(id);
			
		}
		
		out.print("<script>alert('Update successfully!');</script>");
    	out.print("<script>window.location.href='"+url+"'</script>");
	}
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		doPost(req,resp);
	}
}