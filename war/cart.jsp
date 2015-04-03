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
					<h1 class="blue">
						Shopping cart
					</h1>
                </div>
                <div class="cart_head">
                      <h5 class="grey">
                      	Please review the items in your cart, then proceed to checkout.
                      </h5>
                      <p></p>
                </div>
               
                <hr />

                <div class="cart_body">
                
                <%
               		DatastoreService ds=DatastoreServiceFactory.getDatastoreService();
                	Query q1=new Query("cart").addFilter("user", FilterOperator.EQUAL, name);
	                PreparedQuery pq1=ds.prepare(q1);
	
	        		for (Entity u1:pq1.asIterable()){
	        			Key id = u1.getKey();
	     				String cartid = KeyFactory.keyToString(id);
	        			String goodid = u1.getProperty("good").toString();
	        			Key goodkey = KeyFactory.stringToKey(goodid);
	        			Entity good = ds.get(goodkey);
	        			String goodname = good.getProperty("name").toString();
	        			String price = good.getProperty("price").toString();
	     				//String intro = good.getProperty("intro").toString();
	        			String img = good.getProperty("img").toString();
	        			out.print("<div class='clearfix'><div class='row-fluid'><div class='cart_img'>");
	        			out.print("<img src='" + img + ".jpg' width='97px'></div>");
	        			out.print("<div class='cart_information'><p class='text-info bigger-125'>"+ goodname +"</p>");
	        			out.print("<p class='grey smaller-90'>$"+ price +"</p><p>Ships immediately</p></div>");
	        			out.print("<div class='cart_num'><input type='text' class='input-mini' id='spinner"+ cartid +"' onChange='upperMe1()'/></div>");
	        			out.print("<div class='cart_value'><p class='text-info bigger-150' id='output" + cartid + "'></p></div></div></div>");
	        			
	        		}
                %>
               <div class="cart_hr"><hr /></div>
                       
                        <div class="cart_sum">
                            	<p class="text-info bigger-150" id="sum"></p>
                        </div>
                        
                       	<div class="cart_button">
                        		<button class="btn btn-small" onClick="window.location.href='store.jsp'">
										<i class="icon-arrow-left"></i>
										Continue Shopping
								</button>
                                
                                <button class="btn btn-small btn-info" onClick="window.location.href='checkout.jsp'">
										Proceed to Checkout
                                        <i class="icon-arrow-right icon-on-right"></i>
								</button>
                        </div>
                    </div>
				</div>
          
    
	 <%@ include file= "form-under.jsp" %>
    
    <script type="text/javascript">
			
	$(function() {
		<%
	        PreparedQuery pq2=ds.prepare(q1);
			
			for (Entity u2:pq2.asIterable()){
				Key id = u2.getKey();
				String cartid = KeyFactory.keyToString(id);
				String num = u2.getProperty("num").toString();
				out.print("$('#spinner" + cartid + "').ace_spinner({value:" + num + ",min:0,max:999,step:1, btn_up_class:'btn-info' , btn_down_class:'btn-info'});");
			}
		%>
	});
	
	function upperMe1(){
		i=0;
		sum=0;
		<%
			PreparedQuery pq3=ds.prepare(q1);
		
			for (Entity u3:pq3.asIterable()){
				String goodid = u3.getProperty("good").toString();
    			Key goodkey = KeyFactory.stringToKey(goodid);
    			Key id = u3.getKey();
				String cartid = KeyFactory.keyToString(id);
				
    			Entity good = ds.get(goodkey);
    			int price = Integer.parseInt(good.getProperty("price").toString());
    			
				out.print("i = document.getElementById('spinner"+ cartid +"').value;");
				out.print("sum = sum + i * " + price + ";");
				
				out.print("document.getElementById('output" + cartid + "').innerHTML = '$' + i *" + price + ";");
				
				out.print("var xmlhttp;");
				out.print("if (window.XMLHttpRequest) xmlhttp=new XMLHttpRequest();");
				out.print("else xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');");
				
				out.print("xmlhttp.open('GET','cart?change_num='+i+'&id=" + goodid + "',true);");
				out.print("xmlhttp.send();");
			}
		%>
		document.getElementById("sum").innerHTML = "$"+ sum;
	}

	</script>
	
	
	</body>
</html>
