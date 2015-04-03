<!DOCTYPE html>
<html lang="en">
	<head>
    	
		<meta charset="utf-8" />
		<title>Store</title>
		
		<%@ page import="com.google.appengine.api.datastore.*" %>
		<%@ include file= "form-above.jsp" %>
        
             <div class="content1">
             	
	             <%
	             	int count = 0;
	             	DatastoreService ds=DatastoreServiceFactory.getDatastoreService();
	             	Query q=new Query("goods");
	     			PreparedQuery pq=ds.prepare(q);
	     			for (Entity u1:pq.asIterable()){
	     				String goodname=u1.getProperty("name").toString();
	     				String img=u1.getProperty("img").toString();
	     				String price=u1.getProperty("price").toString();
	     				String intro=u1.getProperty("intro").toString();
	     				Key id = u1.getKey();
	     				String goodid = KeyFactory.keyToString(id);
	     				if( count % 3 == 1 )
	     					out.print("<div class='total_div_first'>");
	     				else
	     					out.print("<div class='total_div'>");
	     				out.print("<img src='" + img + ".jpg ' class='240'>");
	     				out.print("<div class='text_div'>");
	     				out.print("<p class='text-success bigger-110'>" + goodname + "</p>");
	     				out.print("<p>$" + price + "</p>");
	     				out.print("<p class='muted text_div'>" + intro + "</p>");
	     				out.print("<button class='btn btn-small' onClick=\"window.location.href='cart?num=1&id=" + goodid + "'\">");
	     				out.print("<i class='icon-shopping-cart bigger-110'> Add to Cart</i>");
	     				out.print("</button></div></div>");
	     			}
			
				%>	   
             	
             </div>   
             
    <!--basic scripts-->
    	
        <%@ include file= "form-under.jsp" %>
              
	</body>
</html>
