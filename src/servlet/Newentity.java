package servlet;

import java.io.IOException;

import javax.servlet.http.*;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.FilterOperator;


public class Newentity extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		
	//code begin this line
		DatastoreService ds=DatastoreServiceFactory.getDatastoreService();
		
		Query q=new Query("goods").addFilter("name", FilterOperator.EQUAL, "good1");
		 
		PreparedQuery pq=ds.prepare(q);

		for (Entity u1:pq.asIterable()){
			ds.delete(u1.getKey());
		}

		
		//create an entity
		Entity e1=new Entity("goods");
		e1.setProperty("name", "Form 1+ Complete Package");
		e1.setUnindexedProperty("img", "img/good_1");
		e1.setUnindexedProperty("price", "3299");
		e1.setUnindexedProperty("intro", "Includes Form 1+ printer, Resin Tank, Build Platform, Finish Kit, free PreForm Software, and 1 liter of the Resin of your choice. The Form 1+ comes with a one-year warranty. Color may vary from image.");

		ds.put(e1);
	//code end	
		Entity e2=new Entity("goods");
		e2.setProperty("name", "Clear Resin 1L");
		e2.setUnindexedProperty("img", "img/good_2");
		e2.setUnindexedProperty("price", "149");
		e2.setUnindexedProperty("intro", "A spare build platform can help speed your printing work flow, whether you want to change resin formulas or start a print while you remove the most recent part.");

		ds.put(e2);
		
		Entity e3=new Entity("goods");
		e3.setProperty("name", "Resin Tank");
		e3.setUnindexedProperty("img", "img/good_3");
		e3.setUnindexedProperty("price", "59");
		e3.setUnindexedProperty("intro", "Our all-new resin tank is injection-molded from light-blocking orange acrylic and comes with a reusable lid that allows you to stack tanks and store resin outside of the machine whenever necessary. As always, avoid direct sunlight..");

		ds.put(e3);
		
		Entity e4=new Entity("goods");
		e4.setProperty("name", "Build Platform");
		e4.setUnindexedProperty("img", "img/good_4");
		e4.setUnindexedProperty("price", "99");
		e4.setUnindexedProperty("intro", "Our all-new resin tank is injection-molded from light-blocking orange acrylic and comes with a reusable lid that allows you to stack tanks and store resin outside of the machine whenever necessary. As always, avoid direct sunlight..");

		ds.put(e4);
		
		resp.setContentType("text/plain");
		resp.getWriter().println("Hello, welecome to datastore");
		resp.getWriter().println("Create Entity successfully");
	}
}
