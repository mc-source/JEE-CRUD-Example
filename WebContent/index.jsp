<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//Scriplet (bloc code Java)
	String title = "Index(jsp)";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title><%=title %></title>

	<!-- header -->
	<jsp:include page="views/shared/header.html" />
</head>
<body>

	<header>
		<!-- menu -->
		<jsp:include page="views/shared/main_menu.jsp" />
	</header>
	
	<div role="main" class="container" style="margin-top:100px;">
		<h1>Index..</h1>
		
		<div class="alert alert-success">
			page : ${page}  <br/>
			action : ${action}  <br/>
			item: ${item}
		</div>
		
		<!-- <form class="mt-2 mt-md-0" method="POST" action="./main">
			<input  name="nom" class="form-control mr-sm-2" type="text" placeholder="nom.." aria-label="Search">
			<button class="form-control btn btn-outline-success my-2 my-sm-0" type="submit">Envoi à la Servlet!</button>
		</form>
		 -->
		 
		<hr />
		<div class="alert alert-secondary">
		    <%= request.getContextPath() %>
		    <br />	
		    	     
		    <%--  <a href="<%=request.getContextPath() %>/login?action=logout">logout</a>		    
		    <br /> --%>
		    
			Lorem ipsum dolor sit amet, consectetur adipisicing elit. 
			Reprehenderit asperiores blanditiis a nobis voluptatibus suscipit porro inventore saepe quod assumenda 
			molestias quasi consequuntur laboriosam velit repudiandae? Ex fugiat eligendi error.
		</div>
	</div>
	
	<!-- footer -->
	<jsp:include page="views/shared/footer.html" />
</body>
</html>