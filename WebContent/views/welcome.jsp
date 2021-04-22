<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- <%@ page import="mc.afip.main.model.User"  %>  --%>

<!--  import package java -->
<%@ page import="java.time.*"  %> 
<%@ page import="java.time.format.*"  %>

<%
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
	String titre = "Welcome";
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	
	<title><%=titre %></title>

	<!-- header -->
	<jsp:include page="shared/header.html" />
</head>
<body>
	<header>
		<!-- menu -->
		<jsp:include page="shared/main_menu.jsp" />
	</header>
	
	<div role="main" class="container" style="margin-top:100px;">
		
		<c:if test="${user==null}">
			<div class="alert alert-danger">
				Vous devez être authentifié pour accèder à cette page!<br/>
				<a href="#loginModal" class="nav-item nav-link " data-toggle="modal"><i class="fa fa-user-o"></i> Login</a>
			</div>
		</c:if>
		
		<c:if test="${user!=null}">
			<h1>Welcome ${user}!</h1> <!-- param 'user' dans Session! -->
			
			<div class="alert alert-success">
				Page dynamique (jsp) générée sur le serveur!<br/>
				Nous sommes le <b><%= LocalDateTime.now().format(formatter) %></b>.
			</div>
			
			<div class="alert alert-warning">
				<%-- welcome 
				<%
				   //objets implicites : request + out
				   out.print(request.getAttribute("nom"));
				%>
				<%= request.getAttribute("nom") %>
				<hr /> --%>
				
				<!-- Utilisation de EL : Expression Language -->
				Welcome ${nom.toLowerCase()}  
			</div>
			
		
			
			<div>
				Lorem ipsum dolor sit amet, consectetur adipisicing elit. 
				Reprehenderit asperiores blanditiis a nobis voluptatibus suscipit porro inventore saepe quod assumenda 
				molestias quasi consequuntur laboriosam velit repudiandae? Ex fugiat eligendi error.
			</div>
		</c:if>
	</div>
	<!-- footer -->
	<jsp:include page="shared/footer.html" />
</body>
</html>