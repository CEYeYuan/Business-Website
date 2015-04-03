package servlet;

import java.io.IOException;

import javax.servlet.http.*;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.FilterOperator;


public class Editentity {
	DatastoreService ds=DatastoreServiceFactory.getDatastoreService();
	Query q=new Query("select * from goods where id is not null");
	PreparedQuery pq=ds.prepare(q);
	
}
