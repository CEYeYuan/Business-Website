<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cart</title>
</head>
<body onload="upperMe1()">

	<%@ page import="com.google.appengine.api.datastore.*" %>
	<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator" %>
	<%@ include file= "form-above.jsp" %>
                
        <div class="content1">	
           	<div class="cart_total">
              	<div class="cart_head">
					<h3 class="blue">
						The details of the order is as following:
					</h3>
					<h5 class="grey">
                      	Order id: #
                      	<%
                      		String orderid = request.getParameter("orderid");
							String ordername = null, phone = null, mail = null, email = null, address = null, status = null;
                      		out.print(orderid);
                      		DatastoreService ds=DatastoreServiceFactory.getDatastoreService();
                      		Query q1=new Query("order").addFilter("orderid", FilterOperator.EQUAL, orderid);
                      		PreparedQuery pq1=ds.prepare(q1);
                      		for (Entity u1:pq1.asIterable()){
                      			ordername = u1.getProperty("name").toString();
                      			phone = u1.getProperty("phone").toString();
                      			mail = u1.getProperty("mail").toString();
                      			email = u1.getProperty("email").toString();
                      			address = u1.getProperty("address").toString();
                      			status = u1.getProperty("status").toString();
                      		}
                      	%>
                      </h5>
                </div>
                
                <hr />
                <div class="order_info">
	                <p>Name: <% out.print(ordername); %></p>
	                <p>Phone: <% out.print(phone); %></p>
	                <p>Post Code: <% out.print(mail); %></p>
                </div>
                <div  class="order_info">
	                <p>Email: <% out.print(email); %></p>
	                <p>Address: <% out.print(address); %></p>
	                <p>Status: <% out.print(status); %></p>
                </div>
                
                

                <div class="cart_body" style="clear:left">
                <hr />
	                <%
	                	Query q2=new Query("order_items").addFilter("orderid", FilterOperator.EQUAL, orderid);
		                PreparedQuery pq2=ds.prepare(q2);
		                int sum = 0;
		
		        		for (Entity u2:pq2.asIterable()){
		        			String goodid = u2.getProperty("good").toString();
		        			int num = Integer.parseInt(u2.getProperty("num").toString());
		        			Key goodkey = KeyFactory.stringToKey(goodid);
		        			Entity good = ds.get(goodkey);
		        			String goodname = good.getProperty("name").toString();
		        			int price =Integer.parseInt(good.getProperty("price").toString());
		     				//String intro = good.getProperty("intro").toString();
		        			String img = good.getProperty("img").toString();
		        			out.print("<div class='clearfix'><div class='row-fluid'><div class='cart_img'>");
		        			out.print("<img src='" + img + ".jpg' width='97px'></div>");
		        			out.print("<div class='cart_information'><p class='text-info bigger-125'>"+ goodname +"</p>");
		        			out.print("<p class='grey smaller-90'>$"+ price +"</p><p>Ships immediately</p></div>");
		        			out.print("<div class='cart_num'><p class='bigger-150'> ×" + num + "</p></div>");
		        			out.print("<div class='order_value'><p class='text-info bigger-150'> $" + num * price + "</p></div></div></div>");
		        			sum = sum + num * price;
		        		}
	                %>
               		<div class="cart_hr"><hr /></div>
                       
                    <div class="cart_sum">
                        	<p class="text-info bigger-150" id="sum">$<% out.print(sum); %></p>
                    </div>
                       
				</div>
             </div>  
          
    
	 <%@ include file= "form-under.jsp" %>
    
	
	
	</body>
</html>
