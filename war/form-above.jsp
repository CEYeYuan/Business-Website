      	<%@ page import="java.io.*,java.util.*" %>
      	<%@ page import="com.google.appengine.api.users.UserService" %>
      	<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
      	

        <%
			String name = null;
        	UserService userService = UserServiceFactory.getUserService();
        	String thisURL = request.getRequestURI();
        	String Mname = getServletContext().getInitParameter("support");
        	String Sname = getServletContext().getInitParameter("manager");
        	int authority = 0;
        	if(request.getUserPrincipal() != null){
        		name = request.getUserPrincipal().getName();
        		if(Mname.equals(name))
        			authority = 1;
        		else if (Sname.equals(name))
        			authority = 2;
        		else
        			authority = 3;
        	}	
		%>
        
        <meta name="description" content="and Validation" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />

		<!--basic styles-->

		<link href="assets/css/bootstrap.min.css" rel="stylesheet" />
		<link href="assets/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="assets/css/font-awesome.min.css" />
		<link rel="stylesheet" href="css/intro.css" />
		<link rel="stylesheet" href="css/use.css" />
		<link rel="stylesheet" href="css/store.css" />
		<link rel="stylesheet" href="css/cart.css" />
		<link rel="stylesheet" href="css/checkout.css" />
		<link rel="stylesheet" href="css/checkorder.css" />
		

		<!--[if IE 7]>
		  <link rel="stylesheet" href="assets/css/font-awesome-ie7.min.css" />
		<![endif]-->

		<!--page specific plugin styles-->

		<link rel="stylesheet" href="assets/css/chosen.css" />

		<!--fonts-->

		<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300" />

		<!--ace styles-->

		<link rel="stylesheet" href="assets/css/ace.min.css" />
		<link rel="stylesheet" href="assets/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="assets/css/ace-skins.min.css" />
		<!--[if lte IE 8]>
		  <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
		<![endif]-->
        
		<!--inline styles if any-->
	</head>

	<body>
    <div class="divcss5">
		<div class="navbar navbar-inverse">
			<div class="navbar-inner">
				<div class="container-fluid">
					<a href="homepage.jsp" class="brand">
						<small>
							<i class="icon-leaf"></i>
							Cars Accessories
						</small>
					</a><!--/.brand-->

					<ul class="nav ace-nav pull-right">
						<li class="light-blue user-profile">
							<a data-toggle="dropdown" href="#" class="user-menu">
								<span >
									<small>Welcome,</small>
									<%
										if( name == null )
											out.print("visitor");
										else if (authority == 1)
											out.print("Manager");
										else if (authority == 2)
											out.print("Supportor");
										else
											out.print(name);
									%>
								</span>

								<i class="icon-caret-down"></i>
							</a>

							<ul class="pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-closer" id="user_menu">                       
								<% if (request.getUserPrincipal() == null) 
										out.print("<li><a href='" + userService.createLoginURL(thisURL) +"'><i class='icon-off'></i>Login</a></li>");
									else{
										out.print("<li><a href='checkorder.jsp'><i class='icon-check'></i>Check Order</a></li>");
										out.print("<li><a href='" + userService.createLogoutURL(thisURL) +"'><i class='icon-off'></i>Logout</a></li>");
									}
								%>
							</ul>
						</li>
					</ul><!--/.ace-nav-->
				</div><!--/.container-fluid-->
			</div><!--/.navbar-inner-->
		</div> <!--标题栏-->
        
                <div id="breadcrumbs">
                        <ul class="breadcrumb  pull-right">
                             <div class="btn-group">        
                                   <button class="btn" onClick="window.location.href='homepage.jsp'">HOME</button>
                                   <button class="btn" onClick="window.location.href='intro.jsp'">INTRO</button>
                                   <button class="btn" onClick="window.location.href='store.jsp'">STORE</button>
                                   <button class="btn" onClick="window.location.href='cart.jsp'"> CART</button>
                              </div>		
                        </ul><!--.breadcrumb-->
                    </div><!---->