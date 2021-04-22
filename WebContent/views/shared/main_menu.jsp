<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="mc.afip.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
.user-title{
	display: inline-block;
    margin-top: 5px;
    margin-right: 10px;
    font-size: 120%;
    color: greenyellow;
}
.badge {
    color: #fff !important;
 /*    border-radius: .125rem;
    -webkit-box-shadow: 0 2px 5px 0 rgba(0,0,0,0.16), 0 2px 10px 0 rgba(0,0,0,0.12); */
    box-shadow: 0 2px 5px 0 rgba(0,0,0,0.16), 0 2px 10px 0 rgba(0,0,0,0.12);
}
.red {
/*     background-color: #f44336 !important;*/
    font-size: 105%; 
}
.fa, .fas {
    font-weight: 900;
    font-size: 120%;
}


 ul.dropdown-cart{
    min-width:250px;
}
ul.dropdown-cart li .item{
    display:block;
    padding:3px 10px;
    margin: 3px 0;
}
ul.dropdown-cart li .item:hover{
    background-color:#f3f3f3;
}
ul.dropdown-cart li .item:after{
    visibility: hidden;
    display: block;
    font-size: 0;
    content: " ";
    clear: both;
    height: 0;
}

ul.dropdown-cart li .item-left{
    float:left;
}
ul.dropdown-cart li .item-left img,
ul.dropdown-cart li .item-left span.item-info{
    float:left;
}
ul.dropdown-cart li .item-left span.item-info{
    margin-left:10px;   
}
ul.dropdown-cart li .item-left span.item-info span{
    display:block;
}
ul.dropdown-cart li .item-right{
    float:right;
}
ul.dropdown-cart li .item-right button{
    margin-top:5px;
}

ul.dropdown-cart 
{
	margin: .5rem -14rem 0;
}
.text-center {
    text-align: center !important;
}
.item-info{
	margin-right:5px !important;
}
</style>
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
	<a class="navbar-brand" href="#"> 
		<img src="./assets/images/javaee_logo.png" alt="logo" class="logo" /> WebSite!
	</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarCollapse" aria-controls="navbarCollapse"
		aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarCollapse">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link" href="./">Accueil</a>
			</li>
			<li class="nav-item"><a class="nav-link"
				href="./main?page=about">About</a></li>
			<li class="nav-item"><a class="nav-link"
				href="./main?page=contact">Contact</a></li>
			<li>|</li>
			<li class="nav-item"><a class="nav-link"
				href="./main?page=articles">Articles</a></li>
		</ul>
	</div>
	
	<!--  Bloc Login/Logout -->
	<div class="navbar-nav ml-auto">
		<div class="nav-item dropdown login-dropdown">	
			
			<c:if test="${user==null}">
				<a href="#loginModal" class="nav-item nav-link " data-toggle="modal"><i class="fa fa-user-o"></i> Login</a>
			</c:if>
			<c:if test="${user!=null}">
				<span class="user-title">${user}</span>
				<a href="<%=request.getContextPath() %>/login?action=logout" class="nav-item nav-link" style="float:right">
					<i class="fa fa-user-o"></i> Logout!
				</a>
			</c:if>		
		</div>
	</div>
	<ul class="nav navbar-nav navbar-right">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"> 
          	 <i class="fa fa-shopping-cart pl-0"></i>
	         <span class="badge badge-pill red">(${cart.size()})</span>
          </a>
          <ul class="dropdown-menu dropdown-cart" role="menu">
          	  <c:set var="total" value="0" />
          	  <c:forEach items="${cart}" var="item">    	  
	          	  <li>
	                  <span class="item">
	                    <span class="item-left">
	                        <img src="http://lorempixel.com/50/50/" alt="" />
	                        <span class="item-info">
	                            <span>${item.name}</span>
	                            <span>${item.quantity} | ${item.price}€</span>
	                        </span>
	                    </span>
	                    <span class="item-right">
	                    	<button class="btn btn-xs btn-danger pull-right"
	                    	onclick="javascript:document.getElementById('cart-delete').submit()">x</button>
	                    </span>
	                </span>
	              </li>
	              
	              <form class="form-inline mt-2 mt-md-0" id="cart-delete"
	              		method="POST"
						action="<%=request.getContextPath() %>/main?page=articles&action=cart-delete">
						<input type="hidden" value="${item.id}" name="id" />				
                  </form>
	              
	              <c:set var="total" value="${total + item.quantity*item.price}" />
          	  </c:forEach>	
              
              <li class="divider"></li>
              
              <li class="text-center"><fmt:formatNumber type="number" maxFractionDigits="2" value="${total}"/>€</li>
              <li class="text-center"><a  href="<%=request.getContextPath() %>/main?page=articles&action=cart">Afficher Panier</a></li>
          </ul>
        </li>
      </ul>
	
</nav>
<style>
.modal-login {
	color: #636363;
	width: 350px;
}

.modal-login .modal-content {
	padding: 20px;
	border-radius: 5px;
	border: none;
}

.modal-login .modal-header {
	border-bottom: none;
	position: relative;
	justify-content: center;
}

.modal-login h4 {
	text-align: center;
	font-size: 26px;
}

.modal-login  .form-group {
	position: relative;
}

.modal-login i {
	position: absolute;
	left: 13px;
	top: 11px;
	font-size: 18px;
}

.modal-login .form-control {
	padding-left: 40px;
}

.modal-login .form-control:focus {
	border-color: #00ce81;
}

.modal-login .form-control, .modal-login .btn {
	min-height: 40px;
	border-radius: 3px;
}

.modal-login .hint-text {
	text-align: center;
	padding-top: 10px;
}

.modal-login .close {
	position: absolute;
	top: -5px;
	right: -5px;
}

.modal-login .btn, .modal-login .btn:active {
	border: none;
	background: #00ce81 !important;
	line-height: normal;
}

.modal-login .btn:hover, .modal-login .btn:focus {
	background: #00bf78 !important;
}

.modal-login .modal-footer {
	background: #ecf0f1;
	border-color: #dee4e7;
	text-align: center;
	margin: 0 -20px -20px;
	border-radius: 5px;
	font-size: 13px;
	justify-content: center;
}

.modal-login .modal-footer a {
	color: #999;
}

.trigger-btn {
	display: inline-block;
	margin: 100px auto;
}

.modal form {
	max-width: 90% !important;
}

.modal-login .avatar {
    position: absolute;
    margin: 0 auto;
    left: 0;
    right: 0;
    top: -60px;
    width: 70px;
    height: 70px;
    border-radius: 50%;
    z-index: 9;
    background: #60c7c1;
    padding: 15px;
    box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.1);
}
.avatar img {
    width: 100%;
}
img {
    vertical-align: middle;
    border-style: none;
}
</style>

<div id="loginModal" class="modal fade">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">
 				<div class="avatar">
					<img src="./assets/images/avatar.png" alt="Avatar">
				</div>	 
				<h4 class="modal-title">Login</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form action="./login?action=login" method="post">
					<div class="form-group">
						<i class="fa fa-user"></i> <input type="text" class="form-control"
							placeholder="Login" name="login" required="required">
					</div>
					<div class="form-group">
						<i class="fa fa-lock"></i> <input type="password"
							class="form-control" placeholder="Password" name="password" required="required">
					</div>
					<div class="form-group">
						<input type="submit" class="btn btn-primary btn-block btn-lg"
							value="Login">
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<a href="#createModal" class="nav-item nav-link" data-dismiss="modal" data-toggle="modal" ><i class="fa fa-user"></i>Inscription</a>
			</div>
		</div>
	</div>
</div>
<div id="createModal" class="modal fade">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">
			 				<div class="avatar">
					<img src="./assets/images/avatar.png" alt="Avatar">
				</div>	
				<h4 class="modal-title">Create</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form action="./login?action=signup" method="post">
					<div class="form-group">
						<i class="fa fa-user"></i> <input type="text" class="form-control"
							placeholder="Prénom" name="prenom" required="required">
					</div>
					<div class="form-group">
						<i class="fa fa-user"></i> <input type="text"
							class="form-control" placeholder="Nom" name="nom" required="required">
					</div>
					<div class="form-group">
						<i class="fa fa-user"></i> <input type="text" class="form-control"
							placeholder="Login" name="login" required="required">
					</div>
					<div class="form-group">
						<i class="fa fa-lock"></i> <input type="password"
							class="form-control" placeholder="Password" name="password" required="required">
					</div>
					<div class="form-group">
						<i class="fa fa-lock"></i> <input type="password"
							class="form-control" placeholder="Confirmation" name="password2" required="required">
					</div>
					<div class="form-group">
						<input type="submit" class="btn btn-primary btn-block btn-lg" value="Inscription">
					</div>
				</form>
			</div>
<!-- 			<div class="modal-footer">
				<a href="#loginModal" class="nav-item nav-link" data-dismiss="modal" data-toggle="modal" ><i class="fa fa-user"></i>Login</a>
			</div> -->
		</div>
	</div>
</div>