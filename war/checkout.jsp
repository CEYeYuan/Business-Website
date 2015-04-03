<!DOCTYPE html>
<html lang="en">
	<head>
    	
		<meta charset="utf-8" />
		<title>Checkout</title>
		
		<%@ page import="com.google.appengine.api.datastore.*" %>
		<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator" %>
		<%@ include file= "form-above.jsp" %>
        
             <div class="content1">	
             
             	<div class="checkout_head">
                	<div class="checkout_headcontent">
                		<p>You're purchasing this…</p>
                        <div class="row-fluid">
                        	<div class="clearfix">
             	
	             <%
	             	DatastoreService ds=DatastoreServiceFactory.getDatastoreService();
             		Query q1=new Query("cart").addFilter("user", FilterOperator.EQUAL, name);
	                PreparedQuery pq1=ds.prepare(q1);
	                int count = 0, sum = 0;
	                
	     			for (Entity u1:pq1.asIterable()){
	     				count ++;
	     				Key id = u1.getKey();
	     				String cartid = KeyFactory.keyToString(id);
	        			int num = Integer.parseInt(u1.getProperty("num").toString());
	        			
	        			String goodid = u1.getProperty("good").toString();
	        			Key goodkey = KeyFactory.stringToKey(goodid);
	        			Entity good = ds.get(goodkey);
	        			String goodname = good.getProperty("name").toString();
	        			int price = Integer.parseInt(good.getProperty("price").toString());
	     				//String intro = good.getProperty("intro").toString();
	        			String img = good.getProperty("img").toString();
	        			
	        			sum = num * price + sum;
	        			
	        			if(count % 3 == 1 && count != 1)
	        				out.print("<div class='checkout_img first'>");
	        			else
	        				out.print("<div class='checkout_img'>");
	        			out.print("<img src='" + img +".jpg' width='50px'></div>");
	        			out.print("<div class='checkout_information'>");
	        			out.print("<p class='bigger-110'>"+goodname + count +"</p>");
	        			out.print("<p class='grey smaller-90'>" + num + "x $"+ price + "</p></div>");
	     			}
			
				%>	   
             	</div>
                        </div>
                        <hr class="checkout_color"/>
                        
                        <div class="checkout_sum">
							<p class="bigger-200">total:&nbsp;&nbsp;&nbsp;$<% out.print(sum); %></p>
                        </div>                        
                    </div>
                </div>
             	
                <div class="checkout_body">
                	<h3 class="text-info">Please enter your shipping information:</h3>
                   		 <div class="widget-box">               
                    		<div class="row-fluid">
								<div class="span12">
									<form class="form-horizontal" id="validation-form" method="post" action="/order"> 
                                        
                                        <div class="control-group" style="margin-bottom:10px;">
											<label class="control-label" for="name">name:</label>
												<div class="controls">
													<span class="span6">
														<input class="span8" type="text" id="name" name="name"/>
													</span>
												</div>
										</div>

                                            
                                        <div class="control-group" style="margin-bottom:10px;">
											<label class="control-label" for="phone">Phone number:</label>
												<div class="controls">
													<div class="span6 input-prepend">
														<span class="add-on">
															<i class="icon-phone"></i>
														</span>
														<input class="span4" type="tel" id="phone" name="phone"/>
														</div>
												</div>
										</div>
                                        
                                        <div class="control-group" style="margin-bottom:10px;">
											<label class="control-label" for="mail">Mail Code:</label>
												<div class="controls">
													<div class="span6 input-prepend">
														<span class="add-on">
															<i class="icon-book"></i>
														</span>
														<input class="span4" type="tel" id="mail" name="mail"/>
														</div>
												</div>
										</div>

										<div class="control-group" style="margin-bottom:10px;">
											<label class="control-label" for="email">Email:</label>
												<div class="controls">
													<span class="span10">
														<input class="span8" type="text" id="email" name="email"/>
													</span>
												</div>
										</div>
										
                                        <div class="control-group" style="margin-bottom:10px;">
											<label class="control-label" for="address">Address:</label>
												<div class="controls">
													<span class="span10">
														<input class="span8" type="text" id="address" name="address"/>
													</span>
												</div>
										</div>
                                       
										<div class="hr hr-dotted"></div>
	
										<div class="row-fluid wizard-actions">
											<button class="btn btn-prev" type="reset">
												<i class="icon-refresh"></i>
												Reset
											</button>

											<button class="btn btn-info" type="submit" name="submit">
												<i class="icon-edit"></i>
                                                Submit	
											</button>
										</div>
                                </form>
                            	</div>	
							</div>	<!--PAGE CONTENT ENDS HERE-->
						</div>         
                </div>
                
             </div>  
             </div>   
             
    <!--basic scripts-->
    	
        <%@ include file= "form-under.jsp" %>
         <script type="text/javascript">
			$(function() {
				//documentation : http://docs.jquery.com/Plugins/Validation/validate
			
			
				$.mask.definitions['~']='[+-]';
				$('#phone').mask('999-999-9999');
				$('#mail').mask('***-***');
				
				jQuery.validator.addMethod("phone", function (value, element) {
					return this.optional(element) ;
				}, "Enter a valid phone number.");
			
				$('#validation-form').validate({
					errorElement: 'span',
					errorClass: 'help-inline',
					focusInvalid: false,
					rules: {
						name: {
							required: true
						},
						phone: {
							required: true
						},
						address: {
							required: true
						},
						mail: {
							required: true
						},
						email: {
							required: true,
							email: true
						},
					},
					messages:{
					 	name: "Please specify your name.",
					 	phone: "We need your phone number to contact you.",
					 	address: "We need your address to ship items to you.",
					 	mail: "We need your mail code to ship items to you.",
					    email: {
					      required: "We need your email address to contact you.",
					      email: "Your email address must be in the format of name@domain.com."
					    }
					},
			
					invalidHandler: function (event, validator) { //display error alert on form submit   
						$('.alert-error', $('.login-form')).show();
					},
			
					highlight: function (e) {
						$(e).closest('.control-group').removeClass('info').addClass('error');
					},
			
					success: function (e) {
						$(e).closest('.control-group').removeClass('error').addClass('info');
						$(e).remove();
					},
			
					errorPlacement: function (error, element) {
						if(element.is(':checkbox') || element.is(':radio')) {
							var controls = element.closest('.controls');
							if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
							else error.insertAfter(element.nextAll('.lbl').eq(0));
						} 
						else if(element.is('.chzn-select')) {
							error.insertAfter(element.nextAll('[class*="chzn-container"]').eq(0));
						}
						else error.insertAfter(element);
					},

				});
			
			})
		</script>      
	</body>
</html>
