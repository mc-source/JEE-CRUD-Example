<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Articles</title>
<!-- header -->
<jsp:include page="shared/header.html" />
<style>
.amber-text {
    color: #ffc107 !important;
}
.text-muted {
    color: #6c757d !important;
}
a:hover{
	text-decoration: none;
}
.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}

#img-upload{
    width: 100%;
}
.img-preview{
	width:160px;
}
.img-preview-sm{
	width:60px;
}
.card-img-top {
    width:160px;
}

table.table tr th:first-child {
    max-width: 200px; 
}
table.table td {
   padding: 20px;
}
</style>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script>
$(document).ready( function() {
	$(document).on('change', '.btn-file :file', function() {
		var input = $(this),
		label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
		input.trigger('fileselect', [label]);
	});

	$('.btn-file :file').on('fileselect', function(event, label) {	    
	    var input = $(this).parents('.input-group').find(':text'),
	    log = label;
	    
	    if( input.length ) {
	        input.val(log);
	    } else {
	        //if( log ) alert(log);
	        console.log(log);
	    }
    
	});
	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();	        
	        reader.onload = function (e) {
	            $('#img-upload').attr('src', e.target.result);
	        }	        
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
	function loadImage(){
		$('#article-img-preview').attr('src', 'assets/photos/'+$('#image-url').val()); 
	}

	$("#imgInp").change(function(){
	    readURL(this);
	}); 	
	
	loadImage();
});
function save_value(id, title,value ){
	$('#'+id).attr('name', title+':'+value);
}
</script>
</head>
<body>
	<header>
		<!-- menu -->
		<jsp:include page="shared/main_menu.jsp" />
	</header>

	<div role="main" class="container" style="margin-top: 100px;">

		
		<!-- Tests -->
<%-- 		<div class="alert alert-success">
			page : ${page}  <br/>
			action : ${action}  <br/>
			item: ${item}
		</div> --%>

		<!-- Gestion Panier  -->
		<c:if test="${action=='cart'}">
			<div class="table-title">
				<div class="row">
					<div class="col-sm-6">
						<h2>Panier (${cart.size()})</h2>
					</div>
					<div class="col-sm-6">
						<c:if test="${user!=null}">
							<a href="#" class="btn btn-danger"><i class="material-icons">&#xE15C;</i> <span>Vider Panier</span></a>
						</c:if>
					</div>
				</div>
			</div>
			<table class="table">
				<thead class="thead-dark">
					<tr>
						<th scope="col">#</th>
						<th scope="col">Nom</th>
						<th scope="col">Quantité</th>
						<th scope="col">Prix</th>
						<th scope="col">
						</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<th colspan="5" style="text-align:right;"  class="alert alert-success">
							<c:if test="${cart.size()==0}">
							 	<c:set var="total" value="0" />
							</c:if>
							<c:forEach items="${cart}" var="item">    	  
					            <c:set var="total" value="${total + item.quantity*item.price}" />
				          	 </c:forEach>	
							<div style="overflow: hidden;">
								Total panier : <fmt:formatNumber type="number" maxFractionDigits="2" value="${total}"/>€.
							</div>
						</th>
					</tr>
				</tfoot>
				<tbody>
					<c:forEach items="${cart}" var="item">
						<tr>
							<th scope="row">${item.id}</th>
							<td><a href="#">${item.name}</a></td>
							<td>${item.quantity}</td>
							<td>${item.price}€</td>
							<td>
								<c:if test="${user!=null}">
									<button 
										class="btn btn-xs btn-danger pull-right"
	                    				onclick="javascript:document.getElementById('cart-delete').submit()">
	                    				<i class="material-icons">&#xE15C;</i> 
	                    			</button>
	                    		    <form class="form-inline mt-2 mt-md-0" id="cart-delete"
					              		method="POST"
										action="<%=request.getContextPath() %>/main?page=articles&action=cart-delete">
										<input type="hidden" value="${item.id}" name="id" />				
				                   </form>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
		
		<!-- Form Add / Edit Article -->
		<c:if test="${action=='add' || action=='edit'}">				
			<form
				action="<%=request.getContextPath()%>/main?page=articles&action=${action}"
				method="post">
				<div class="form-group">
					<input type="hidden" class="form-control" name="id" value="${item.id}">
				</div>
				<div class="form-group">
					<input type="text" class="form-control" placeholder="Nom" value="${item.nom}" name="nom" required="required"
							onchange="save_value('temp-name','name',this.value)" >
				</div>
				<div class="form-group">
					<textarea class="form-control" placeholder="Descriptif" value="${item.descriptif}" name="descriptif"></textarea>
				</div>
				<div class="form-group">
					<input type="number" step="any" class="form-control" placeholder="Prix" value="${item.prix}" name="prix" required="required"
						onchange="save_value('temp-price','price',this.value)">
				</div>
				
				<div class="form-group">
					<input type="text" class="form-control" placeholder="Photo" value="${item.photo}" id="image-url" name="photo" readonly>
					<span class="input-group-btn">
		           		<span class="btn btn-default btn-file" style="left: 180px;top: -45px; overflow: hidden">
		                    <a href="#uploadModal" class="nav-item nav-link " data-toggle="modal"><i class="fa fa-upload"></i></a>		                    
		                </span>
		            </span>
				</div>
				<div class="form-group" style="text-align: center; margin-top:-60px;">
					<img id='article-img-preview' class="img-preview" src="" />
				</div>
				<div class="form-group">
					<input type="submit" class="btn btn-primary btn-block btn-lg"
						value="${action=='add' ? 'Ajouter' : 'Modifier'}">
				</div>
			</form>
		</c:if>
		
		<!-- Form Delete Article (Confirmation) -->
		<c:if test="${action=='delete'}">
			<%-- Delete : ${item} --%>
			<!-- Form Delete / Article -->
			<div class="alert alert-warning">
				Etes-vous sûr de vouloir supprimer l'article : ${item}?

				<form class="form-inline mt-2 mt-md-0" method="POST"
					action="./main?page=articles&action=delete&id=${item.id}">
					<button class="form-control btn btn-outline-danger my-2 my-sm-0"
						type="submit">Delete!</button>
					&nbsp;&nbsp; <a
						href="<%=request.getContextPath()%>/main?page=articles"
						class="form-control btn btn-outline-success my-2 my-sm-0">Cancel</a>
				</form>
			</div>
		</c:if>
		
		<!-- Fiche Article -->
		<c:if test="${action=='detail'}">
			<!-- Card -->
			<div class="alert alert-secondary" style="max-width:75%; margin:auto">
			  
			  <div style="float:left; padding:5px;">
			    <img class="card-img-top" src="<%=request.getContextPath() %>/assets/photos/${item.photo}" />
			    <a href="#!">
			      <span class="mask rgba-white-slight"></span>
			    </a>
			  </div>
			  <div>
			  	
			  	<h4 class="card-title font-weight-bold"><a href="#">${item.nom}</a></h4>
			    
			    <ul class="list-unstyled list-inline rating mb-0">
			      <li class="list-inline-item mr-0"><i class="fa fa-star amber-text"></i></li>
			      <li class="list-inline-item mr-0"><i class="fa fa-star amber-text"></i></li>
			      <li class="list-inline-item mr-0"><i class="fa fa-star amber-text"></i></li>
			      <li class="list-inline-item mr-0"><i class="fa fa-star amber-text"></i></li>
			      <li class="list-inline-item"><i class="fa fa-star-half-o amber-text"></i></li>
			      <li class="list-inline-item"><p class="text-muted">4.5 (413)</p></li>
			    </ul>
			    <p class="mb-2">$ • American, Restaurant</p>

			    <p class="card-text">
				    ${item.descriptif}
			    </p>
			    <hr class="my-4">
			    <!-- <p class="lead"><strong>Tonight's availability</strong></p>
			    <ul class="list-unstyled list-inline d-flex justify-content-between mb-0">
			      <li class="list-inline-item mr-0">
			        <div class="chip mr-0">5:30PM</div>
			      </li>
			      <li class="list-inline-item mr-0">
			        <div class="chip deep-purple white-text mr-0">7:30PM</div>
			      </li>
			      <li class="list-inline-item mr-0">
			        <div class="chip mr-0">8:00PM</div>
			      </li>
			      <li class="list-inline-item mr-0">
			        <div class="chip mr-0">9:00PM</div>
			      </li>
			    </ul> -->
			  </div>

			 
			
			</div>
			<!-- Card -->		
		</c:if>
		
		
		<!-- 
		LISTE ARTICLES
		 -->
		<c:if test="${action==null}">
			<div class="table-title">
				<div class="row">
					<div class="col-sm-6">
						<h2>Articles</h2>
					</div>
					<div class="col-sm-6">
						<c:if test="${user!=null}">
							<a
								href="<%=request.getContextPath()%>/main?page=articles&action=add"
								class="btn btn-success"><i class="material-icons">&#xE147;</i>
								<span>Add</span> </a>
						</c:if>
						<!-- <a href="#" class="btn btn-danger"><i class="material-icons">&#xE15C;</i> <span>Delete</span></a> -->
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
				<tfoot>
					<tr>
						<th colspan="4">

							<div class="alert alert-success" style="overflow: hidden;">
								<nav aria-label="Page navigation example">
									<ul class="pagination">
										<li class="page-item disabled" style="margin:5px 10px;">
											<div>${items_count} Articles. </div>
										</li>
										<li class="page-item disabled">
											<a class="page-link" href="#" aria-label="Previous"> 
												<span aria-hidden="true">&laquo;</span>
												<span class="sr-only">Previous</span>
											</a>
										</li>

										<c:forEach begin="1" end="${pages_count}" var="num">
											<li
												class="page-item <c:out value="${num==current_page?'active':''}" />">
												<a class="page-link" href="<%=request.getContextPath()%>/main?page=articles&n=${num}">${num}
												</a>
											</li>
										</c:forEach>


										<li class="page-item disabled"><a class="page-link" href="#"
											aria-label="Next"> <span aria-hidden="true">&raquo;</span>
												<span class="sr-only">Next</span>
										</a></li>
									</ul>
								</nav>
							</div>
						</th>
					</tr>

				</tfoot>
				<tbody>
					<c:forEach items="${items}" var="item">
						<tr>
							<th scope="row">
								${item.id}
								
								<c:set var="photo" scope="request" value="${empty item.photo ? 'jee.png' : item.photo}" />
								<img class="img-preview-sm" src="<%=request.getContextPath() %>/assets/images/${photo}" />
							</th>
							<td>
								<a href="<%=request.getContextPath() %>/main?page=articles&action=detail&id=${item.id}">${item.nom}</a>
							</td>
							<td>${item.prix}€</td>
							<td><c:if test="${user!=null}">
									<a
										href="<%=request.getContextPath() %>/main?page=articles&action=edit&id=${item.id}"
										class="edit" title="Edit" data-toggle="tooltip"><i
										class="material-icons">&#xE254;</i>
									</a>
									<a
										href="<%=request.getContextPath() %>/main?page=articles&action=delete&id=${item.id}"
										class="delete" title="Delete" data-toggle="tooltip"><i
										class="material-icons">&#xE872;</i>
									</a>
									
									<form class="form-inline mt-2 mt-md-0" method="POST"
										action="<%=request.getContextPath() %>/main?page=articles&action=cart&id=${item.id}">

										<button class="form-control btn cart-button" title="Add Cart"
											data-toggle="tooltip" type="submit">
											<i class="fa fa-shopping-cart pl-0"></i>
										</button>
									</form>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
	
	
	<div id="uploadModal" class="modal fade">
		<div class="modal-dialog modal-login">
			<div class="modal-content">
<!-- 				<div class="modal-header">
	 				<div class="avatar">
						<img src="./assets/images/avatar.png" alt="Avatar">
					</div>	 
					<h4 class="modal-title">Upload</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div> -->
				<div class="modal-body">				
					<form 	method="post" 
							action="<%=request.getContextPath()%>/upload?x=add" 
							enctype="multipart/form-data">
						
						<div class="form-group">
							<span class="btn btn-default btn-file" style="min-width: 100%;">
			                    <i class="fa fa-upload" style="margin-left: 45%;"></i>
			                    <input type="file" id="imgInp" name="photo" accept="image/*" />
			                </span>
			                <img id='img-upload' style="margin-top: 20px;" src=""/>
						</div>
						
						<input type="hidden"  name="action:${action}" value="" />
						<input type="hidden"  id="temp-id" name="id:${item.id}" />
						<input type="hidden"  id="temp-name" name="name:${item.nom}" />
						<input type="hidden"  id="temp-price" name="price:${item.prix}" />
						
						<div class="form-group">
							<input type="submit" class="btn btn-primary btn-block btn-md" value="Upload">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- footer -->
	<jsp:include page="shared/footer.html" />
</body>
</html>