<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Articles</title>
<!-- header -->
<jsp:include page="shared/header.html" />
</head>
<body>
	<header>
		<!-- menu -->
		<jsp:include page="shared/main_menu.jsp" />
	</header>

	<div role="main" class="container" style="margin-top: 100px;">
	
	
		<div class="alert alert-success">
			action : ${action}
		</div>
		
		<c:if test="${action=='edit'}">
			Edit : ${item}
			<a href="<%=request.getContextPath()%>/main?page=articles">Liste Articles</a>
			<!-- Form Edit / Article -->
		</c:if>
		<c:if test="${action=='add'}">
			Add : ${item}
			<!-- Form Add / Article -->
		</c:if>
		<c:if test="${action=='delete'}">
			<%-- Delete : ${item} --%>
			<!-- Form Delete / Article -->
			<div class="alert alert-warning">
				Etes-vous sûr de vouloir supprimer l'article : ${item}?
				
				<form class="form-inline mt-2 mt-md-0" method="POST" action="./main?page=articles&action=delete&id=${item.id}">
					<button class="form-control btn btn-outline-danger my-2 my-sm-0" type="submit">Delete!</button>
					<a href="<%=request.getContextPath()%>/main?page=articles" class="form-control btn btn-outline-success my-2 my-sm-0">Cancel</a>
				</form>
			</div>
		</c:if>
		<c:if test="${action==null}">
			<div class="table-title">
				<div class="row">
					<div class="col-sm-6">
						<h2>Articles</h2>
					</div>
					<div class="col-sm-6">
						<c:if test="${user!=null}">
							<a href="#addEmployeeModal" class="btn btn-success"
								data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add</span></a>
	<!-- 						<a href="#deleteEmployeeModal" class="btn btn-danger"
								data-toggle="modal"><i class="material-icons">&#xE15C;</i> <span>Delete</span></a> -->
						</c:if>
					</div>
				</div>
			</div>
			<table class="table">
				<thead class="thead-dark">
					<tr>
						<th scope="col">#</th>
						<th scope="col">Nom</th>
						<th scope="col">Prix</th>
						<th scope="col">
							<!-- <a class="add" title="Add" data-toggle="tooltip"><i class="material-icons">&#xE03B;</i></a> -->
						</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${items}" var="item">
						<tr>
							<th scope="row">${item.id}</th>
							<td>${item.nom}</td>
							<td>${item.prix}€</td>
							<td>
								<c:if test="${user!=null}">
									<a href="<%=request.getContextPath() %>/main?page=articles&action=edit&id=${item.id}" 
									class="edit" title="Edit" data-toggle="tooltip"><i class="material-icons">&#xE254;</i></a> 
									<a href="<%=request.getContextPath() %>/main?page=articles&action=delete&id=${item.id}"  
									class="delete" title="Delete" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a>
								</c:if>								
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>

	</div>

	<!-- footer -->
	<jsp:include page="shared/footer.html" />
</body>
</html>