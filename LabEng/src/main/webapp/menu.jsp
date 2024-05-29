<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
</head>
<body>
	<nav id="menu">
		<ul>
			<div class="logo">
		   <img alt="Logo" src="imagens/logoAdega.webp">
			</div>
			<li><a href="index.jsp">Home</a></li>
			<li><a href="${pageContext.request.contextPath}/produto">Produto</a></li>
			<li><a href="${pageContext.request.contextPath}/itens">Itens</a></li>
		    <li><a href="${pageContext.request.contextPath}/pedido">Pedido</a></li>
		    <li><a href="${pageContext.request.contextPath}/venda">Venda</a></li>
		</ul>
	</nav>
</body>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Arbutus+Slab&family=Armata&family=Teko&family=Bebas+Neue&family=Raleway:ital,wght@0,100..900;1,100..900&display=swap')
	;

@import
	url('https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap')
	;

* {
	margin: 0;
	padding: 0;
	border: 0;
	box-sizing: border-box;
	font-family: "Poppins";
	text-decoration: none;
	color: black;
}

ul {
	list-style: none;
}

#menu {
	display: flex;
	flex-direction: row;
	gap: 2rem;
	cursor: pointer;
	margin-left: 0px;
	font-weight: 600;
	font-size: 20px;
}

#menu ul {
	display: flex;
	margin-top: 20px;
	gap: 5rem;
	margin-left: 130px;
}

#menu ul li a {
	color: #5F9EA0;
	margin-top: 30px;
}

#menu ul li a:hover {
	color: #191970;
}


.logo {
		margin-top: -10px;
		margin-right: 60px
	
}

img {
	
	width: 60px; 
	height: 50px;
}
</style>
</html>