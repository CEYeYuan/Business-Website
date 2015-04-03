<!DOCTYPE html>
<html lang="en">
	<head>
    	
		<meta charset="utf-8" />
		<title>Store</title>
		
		<%@ page import="com.google.appengine.api.datastore.*" %>
		<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator" %>
		<%@ include file= "form-above.jsp" %>
        
         <div class="content1">	
             	<div class="checkorder_head">
                	<div class="row-fluid">
                    	<div class="span6">
                            <h3 class="blue">
								 All your orders blew: 
							</h3>
                        </div>
               	</div>
               	
                <div class="checkorder_body">
             		<table id="table_bug_report" class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th class="center" width="50px">Num</th>
                                <th>Order Id</th>
								<th width="100px">Name</th>
								<th width="200px">Address</th>
								<th width="100px">Status</th>
                                <th width="40px" class="center">Edit</th>
							</tr>
						</thead>
                        <tbody>
                        	<%
	                        	DatastoreService ds=DatastoreServiceFactory.getDatastoreService();
	                     		Query q1=new Query("order").addFilter("user", FilterOperator.EQUAL, name);
	        	                PreparedQuery pq1=ds.prepare(q1);
	        	                int count = 0;
	        	                
	        	     			for (Entity u1:pq1.asIterable()){
	        	     				count++;
	        	     				String orderid = u1.getProperty("orderid").toString();
	        	     				String status = u1.getProperty("status").toString();
	        	     				out.print("<tr>");
	        	     				out.print("<td class='center'>"+ count +"</td>");
	        	     				out.print("<td>" + orderid + "</td>");
	        	     				out.print("<td>" + u1.getProperty("name").toString() + "</td>");
	        	     				out.print("<td>" + u1.getProperty("address").toString() + "</td>");
	        	     				out.print("<td>" + status + "</td>");
	        	     				if(("pending").equals(status)){
	        	     		%>
	        	     		
		        	     		<td class='center'>
									<div class='inline position-relative'>
							
										<button class='btn btn-minier btn-primary dropdown-toggle' data-toggle='dropdown' >
											<i class='icon-cog icon-only bigger-110'></i>
										</button>
										
										<ul class='dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close'>
											<li>
												<a href='orderdetails.jsp?orderid=<% out.print(orderid + "'"); %> class='tooltip-info' data-rel='tooltip' title='View' data-placement='left'>
													<span class='blue'>
														<i class=' icon-eye-open'></i>
													</span>
												</a>
											</li>
											
											<li>
												<a href='#' class='tooltip-warning' data-rel='tooltip' title='Edit' data-placement='left'>
												
													<span class='orange'>
														<i class='icon-edit'></i>
													</span>
												</a>
											</li>
	
											<li>
												<a href='#' class='tooltip-error' data-rel='tooltip' title='Cancel' data-placement='left' onClick='delconfirm($info[orderid])'>
													<span class='red'>
														<i class='icon-trash'></i>
													</span>
												</a>
											</li>
										</ul>
									</div>
								</td>
	        	     		</tr>
	        	     		<% 
	        	     			}else{
                        	%>
                        		<td class='center'>
                        			<button class='btn btn-minier btn-primary dropdown-toggle' data-toggle='dropdown' >
										<i class='icon-cog icon-only bigger-110'></i>
									</button>
							<% 
	        	     			}}
                        	%>
                        </tbody>
             		</table>
             	</div>
             </div>  
    <!--basic scripts-->
    	
        <%@ include file= "form-under.jsp" %>
       	
       	<script src="assets/js/jquery.dataTables.min.js"></script>
		<script src="assets/js/jquery.dataTables.bootstrap.js"></script>
       	 
        <script type="text/javascript">
			$(function() {
				var oTable1 = $('#table_report').dataTable( {
				"aoColumns": [
			      { "bSortable": false },
			      null, null,null, null, null,
				  { "bSortable": false }
				] } );
				
				
				$('table th input:checkbox').on('click' , function(){
					var that = this;
					$(this).closest('table').find('tr > td:first-child input:checkbox')
					.each(function(){
						this.checked = that.checked;
						$(this).closest('tr').toggleClass('selected');
					});
						
				});
			
				$('[data-rel=tooltip]').tooltip();
			})
		</script>      
	</body>
</html>
