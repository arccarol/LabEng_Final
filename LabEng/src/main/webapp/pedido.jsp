<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
<head>
<meta charset="UTF-8">
<title>Pedido</title>
<script>
	function validarPedido() {
		var camposQuantidade = document
				.querySelectorAll('input[name^="quantidade"]');

		camposQuantidade.forEach(function(campo) {
			if (campo.value === '') {
				campo.value = '0';
			}
		});

		return true;
	}
</script>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Arbutus+Slab&family=Armata&family=Teko&family=Bebas+Neue&family=Raleway:ital,wght@0,100..900;1,100..900&display=swap')
	;

@import
	url('https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap')
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

body {
	background-color: #F5F5F5;
}

input[type=submit] {
	color: black;
	background-color: #808080;
	border-radius: 70px;
	font-size: 15px;
	width: 115px;
	height: 35px;
	font-weight: 400;
}

input[type=submit]:hover {
	background-color: #808080;
}

.calculado, .cadastro {
	background-color: #F5F5DC;
	border-radius: 20px;
	outline: none;
	padding: 0 0.5rem;
	width: 200px;
	height: 30px;
	border: 1px solid #C0C0C0;
}

.title {
	margin-top: 2px;
}

.cadastrar {
	text-align: center;
	margin-top: 10px;
	font-family: "Armata";
	text-transform: uppercase;
	font-weight: 600;
	margin-left: 10px;
	padding: 20px;
}

.pedido {
	margin-top: 10px;
	margin-left: 30px;
	background-color: #dcdcdc;
	width: 600px;
	height: 350px;
	padding: 10px;
	border-radius: 30px;
}

.aluno {
	display: flex;
	gap: 25px;
	padding: 12px;
	margin-left: 70px;
}

.botoes2 {
	display: flex;
	gap: 15px;
	margin-left: 20px;
	padding: 30px;
	margin-top: 5px;
}

.botoes3 {
	display: flex;
	gap: 15px;
	margin-left: 80px;
	padding: 30px;
	margin-top: -40px;
}

.aviso {
	padding: 10px;
	font-weight: 600;
}

.menu {
	background-color: #f0f0f0;
	padding: 20px;
}

.mensagem {
	background-color: #f0f0f0;
	font-size: 20px;
}

.table_round {
	margin-top: 50px;
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	background-color: #fff;
	font-size: 14px;
	border-radius: 10px;
	overflow: hidden;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.table_round th, .table_round td {
	border: 1px solid #dddddd;
	padding: 10px;
	text-align: center;
}

.table_round th {
	background-color: #f2f2f2;
	color: #333;
	font-weight: bold;
}

.table_round tr:nth-child(even) {
	background-color: #f9f9f9;
}

.table_round tr:hover {
	background-color: #f1f1f1;
}

.table_round input[type="text"], .table_round input[type="number"] {
	width: 80px;
	padding: 5px;
	box-sizing: border-box;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.table_round form {
	display: inline;
}

.table_round input[type="submit"] {
	color: #fff;
	background-color: #d9534f;
	border-radius: 4px;
	font-size: 12px;
	width: auto;
	height: 30px;
	font-weight: 400;
	padding: 0 10px;
}

.table_round input[type="submit"]:hover {
	background-color: #c9302c;
}
</style>
</head>
<body style="background-image: url('imagens/fundot.png')"
	class="tela_aluno">
	<div class="menu">
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<div align="center" class="container">
		<form action="pedido" method="post" class="pedido"
			onsubmit="return validarPedido()">
			<p class="title">
			<p class="cadastrar">Realize o Pedido</p>
			</p>
			<table>
				<tr>
					<td class="aluno" colspan="4">
						<p class="title">Código:</p> <input class="cadastro" type="number"
						id="codigo" name="codigo" placeholder=""
						value='<c:out value="${pedido.codigo }"></c:out>'>
					</td>
				</tr>
				<tr>
					<td class="aluno" colspan="4">
						<p class="title">Código Reserva:</p> <input class="cadastro"
						type="number" id="codigoReserva" name="codigoReserva"
						placeholder="" value='<c:out value="${reserva.codigo }"></c:out>'>
					</td>
				</tr>
				<tr class="botoes2">
					<td colspan="5" style="text-align: center;"><input
						type="submit" id="botaoListarPedidos" name="botao"
						value="Listar Itens"> <input type="submit"
						id="botaoListar" name="botao" value="Listar"> <input
						type="submit" id="botaoCadastrar" name="botao" value="Cadastrar">
					</td>
				</tr>
				<tr class="botoes3">
					<td colspan="5" style="text-align: center;"><input
						type="submit" id="botaoReservar" name="botao" value="Reservar">
						<input type="submit" id="botaoListarReservas" name="botao"
						value="Listar Reservas"></td>
				</tr>
			</table>
			<c:if test="${not empty pedidos}">
				<table class="table_round">
					<thead>
						<tr>
							<th>Código Produto</th>
							<th>Nome Produto</th>
							<th>Marca Produto</th>
							<th>Quantidade</th>
							<th>Excluir</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="p" items="${pedidos}" varStatus="status">
							<tr>
								<td><input type="text" id="produto${status.index}"
									name="produto${status.index}" placeholder=""
									value='<c:out value="${p.produto.codigo }"></c:out>' readonly></td>
								<td><c:out value="${p.produto.nome}" /></td>
								<td><c:out value="${p.produto.marca}" /></td>
								<td><input type="number" id="quantidade${status.index}"
									name="quantidade${status.index}" placeholder=""
									value='<c:out value="${p.quantidade }"></c:out>'></td>
								<td>
									<form action="pedido" method="post"
										onsubmit="return confirm('Tem certeza que deseja excluir este Pedido?');">
										<input type="hidden" name="cmd" value="Excluir"> <input
											type="hidden" name="produtoCodigo"
											value="${p.produto.codigo}"> <input type="submit"
											id="botao" name="botao" value="Excluir">
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			<input type="hidden" id="falta" name="falta"> <input
				type="hidden" id="produto" name="produto">
			<c:if test="${not empty pedidosI}">
				<table class="table_round">
					<thead>
						<tr>
							<th>Código Pedido</th>
							<th>Código Produto</th>
							<th>Nome Produto</th>
							<th>Marca Produto</th>
							<th>Valor Produto</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="pi" items="${pedidosI}">
							<tr>
								<td><c:out value="${pi.codigo}" /></td>
								<td><c:out value="${pi.produto.codigo}" /></td>
								<td><c:out value="${pi.produto.nome}" /></td>
								<td><c:out value="${pi.produto.marca}" /></td>
								<td><c:out value="${pi.produto.valorUnit}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>

			<c:if test="${not empty reservas}">
				<table class="table_round">
					<thead>
						<tr>
							<th>Código Reserva</th>
							<th>Data Reserva</th>
							<th>Data Limite</th>
							<th>Produto</th>
							<th>Quantidade</th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="reserva" items="${reservas}">
							<tr>
								<td><c:out value="${reserva.codigo}" /></td>
								<td><fmt:formatDate value="${reserva.data_reserva}"
										pattern="dd/MM/yyyy" /></td>
								<td><fmt:formatDate value="${reserva.data_limite}"
										pattern="dd/MM/yyyy" /></td>
								<td><c:out value="${reserva.produto.nome}" /></td>
								<td><c:out value="${reserva.quantidade}" /></td>
								<td><c:out value="${reserva.status}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>

		</form>
		<div class="mensagem" align="center">
			<c:if test="${not empty saida}">
				<p>
					<c:out value="${saida}" />
				</p>
			</c:if>
			<c:if test="${not empty erro}">
				<p style="color: red;">
					<c:out value="${erro}" />
				</p>
			</c:if>
		</div>
	</div>
</body>
</html>
