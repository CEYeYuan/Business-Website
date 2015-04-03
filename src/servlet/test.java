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
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;


public class test extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
	
		DatastoreService ds=DatastoreServiceFactory.getDatastoreService();
		UserService userService = UserServiceFactory.getUserService();
		String name = null;
		if(req.getUserPrincipal() != null)
    		name = req.getUserPrincipal().getName();  
		resp.getWriter().println(name);	
		Query q1=new Query("cart").addFilter("user", FilterOperator.EQUAL, name).addFilter("user", FilterOperator.EQUAL, name);
        PreparedQuery pq1=ds.prepare(q1);

		for (Entity u1:pq1.asIterable()){
			resp.getWriter().println("has order 1");	
			String goodid = u1.getProperty("good").toString();
			Key goodkey = KeyFactory.stringToKey(goodid);
			Entity good = null;
			try {
				good = ds.get(goodkey);
			} catch (EntityNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String goodname = good.getProperty("name").toString();
			String price = good.getProperty("price").toString();
				String intro = good.getProperty("intro").toString();
			String img = good.getProperty("img").toString();
			System.out.print("<div class='clearfix'><div class='row-fluid'><div class='cart_img'>");
			System.out.print("<img src='" + img + "' width='97px'></div>");
			System.out.print("<div class='cart_information'><p class='text-info bigger-125'>"+ goodname +"</p>");
			System.out.print("<p class='grey smaller-90'>$"+ price +"</p><p>Ships immediately</p>");
			System.out.print("<div class='cart_num'><input type='text' class='input-mini' id='spinner"+ goodid +"' onChange='upperMe1()'/>");
		}
		 
	}
}
