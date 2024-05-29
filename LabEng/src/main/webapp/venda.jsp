<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
<meta charset="UTF-8">
<title>Venda</title>
</head>
<body style="background-image: url('imagens/fundot.png')" class="tela_aluno">
	<div class="menu">
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<div align="center" class="container">
		<form action="venda" method="post" class="pedido">
			<p class="title">
			<p class="cadastrar">Realize a Venda</p>
			</p>
			<table>
				<tr class="botoes2">
					<!-- Botões com diferentes valores para cmd -->
					<td><input type="submit" name="cmd" value="Listar Pedidos"></td>
					<td><input type="submit" name="cmd" value="Listar Vendas Pedidos"></td>
				</tr>
				<tr class="botoes3">
					<!-- Botões com diferentes valores para cmd -->
					<td><input type="submit" name="cmd" value="Listar Reservas"></td>
					<td><input type="submit" name="cmd" value="Listar Vendas Reservas"></td>
				</tr>
			</table>

			<c:if test="${not empty vendas}">
				<!-- Tabela de vendas -->
				<table class="table_round2">
					<thead>
						<tr>
							<th>Código Pedido</th>
							<th>Código Produto</th>
							<th>Nome Produto</th>
							<th>Marca Produto</th>
							<th>Valor Unitário</th>
							<th>Quantidade</th>
							<th>Valor Total Produto</th>
							<th>Cadastro</th>
							<th>Desistir</th>

						</tr>
					</thead>
					<tbody>
						<!-- Iteração sobre as vendas -->
						<c:forEach var="v" items="${vendas}" varStatus="status">
							<tr>
								<td><c:out value="${v.pedido.codigo}" /></td>
								<td><c:out value="${v.pedido.produto.codigo}" /></td>
								<td><c:out value="${v.pedido.produto.nome}" /></td>
								<td><c:out value="${v.pedido.produto.marca}" /></td>
								<td><c:out value="${v.pedido.produto.valorUnit}" /></td>
								<td><c:out value="${v.pedido.produto.quantidade}" /></td>
								<td><c:out value="${v.valorTotal}" /></td>
								<td>
									<!-- Formulário para cadastrar -->
									<form action="venda" method="post">
										<input type="hidden" name="cmd" value="Cadastrar"> <input
											type="hidden" name="codigo" value="${v.pedido.codigo}">
										<input type="hidden" name="quantidadeTotal"
											value="${v.pedido.produto.quantidade}"> <input
											type="submit" class="btn-cadastrar" value="Cadastrar">
									</form>
								</td>
								<td>
									<form action="venda" method="post">
										<input type="hidden" name="cmd" value="Desistir"> <input
											type="hidden" name="codigo" value="${v.pedido.codigo}">
										<input type="submit" value="Desistir">
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			
			<c:if test="${not empty vendasr}">
				<!-- Tabela de vendas -->
				<table class="table_round2">
					<thead>
						<tr>
							<th>Código Reserva</th>
							<th>Código Produto</th>
							<th>Nome Produto</th>
							<th>Marca Produto</th>
							<th>Valor Unitário</th>
							<th>Quantidade</th>
							<th>Valor Total Produto</th>
							<th>Cadastro</th>
							<th>Desistir</th>

						</tr>
					</thead>
					<tbody>
						<!-- Iteração sobre as vendas -->
						<c:forEach var="vr" items="${vendasr}" varStatus="status">
							<tr>
								<td><c:out value="${vr.reserva.codigo}" /></td>
								<td><c:out value="${vr.reserva.produto.codigo}" /></td>
								<td><c:out value="${vr.reserva.produto.nome}" /></td>
								<td><c:out value="${vr.reserva.produto.marca}" /></td>
								<td><c:out value="${vr.reserva.produto.valorUnit}" /></td>
								<td><c:out value="${vr.reserva.produto.quantidade}" /></td>
								<td><c:out value="${vr.valorTotal}" /></td>
								<td>
									<!-- Formulário para cadastrar -->
									<form action="venda" method="post">
										<input type="hidden" name="cmd" value="Cadastrar Reserva"> <input
											type="hidden" name="codigor" value="${vr.reserva.codigo}">
										<input type="hidden" name="quantidadeTotalr"
											value="${vr.reserva.produto.quantidade}"> <input
											type="submit" class="btn-cadastrar" value="Cadastrar Reserva">
									</form>
								</td>
								<td>
									<form action="venda" method="post">
										<input type="hidden" name="cmd" value="Desistir Reserva"> <input
											type="hidden" name="codigor" value="${vr.reserva.codigo}">
										<input type="submit" value="Desistir Reserva">
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>

			<c:if test="${not empty vendasI}">
				<!-- Tabela de vendas realizadas -->
				<table class="table_round">
					<thead>
						<tr>
							<th>Código Pedido</th>
							<th>Quantidade Total</th>
							<th>Valor Total</th>
							<th>Data Venda</th>
						</tr>
					</thead>
					<tbody>
						<!-- Iteração sobre as vendas realizadas -->
						<c:forEach var="vi" items="${vendasI}">
							<tr>
								<td><c:out value="${vi.pedido.codigo}" /></td>
								<td><c:out value="${vi.quantidade}" /></td>
								<td><c:out value="${vi.valorTotal}" /></td>
								<td><c:out value="${vi.data_v}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			
			<c:if test="${not empty vendasIR}">
				<!-- Tabela de vendas realizadas -->
				<table class="table_round">
					<thead>
						<tr>
							<th>Código Reserva</th>
							<th>Quantidade Total</th>
							<th>Valor Total</th>
							<th>Data Venda</th>
						</tr>
					</thead>
					<tbody>
						<!-- Iteração sobre as vendas realizadas -->
						<c:forEach var="vir" items="${vendasIR}">
							<tr>
								<td><c:out value="${vir.reserva.codigo}" /></td>
								<td><c:out value="${vir.quantidade}" /></td>
								<td><c:out value="${vir.valorTotal}" /></td>
								<td><c:out value="${vir.data_v}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			

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
		</form>
	</div>
</body>
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
	width: 180px;
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
	height: 270px;
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
	padding: 20px;
	margin-top: 15px;
}

.botoes3 {
	display: flex;
	gap: 15px;
	margin-left: 20px;
	padding: 20px;
	margin-top: -15px;
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

.table_round2 {
	margin-top: 50px;
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	background-color: #fff;
	font-size: 14px;
	border-radius: 10px;
	overflow: hidden;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	margin-left: -90px;
	text-align: center;
}

.table_round2 th, .table_round2 td {
	border: 1px solid #dddddd;
	padding: 10px;
	text-align: center;
}

.table_round2 th {
	background-color: #f2f2f2;
	color: #333;
	font-weight: bold;
}

.table_round2 tr:nth-child(even) {
	background-color: #f9f9f9;
}

.table_round2 tr:hover {
	background-color: #f1f1f1;
}

.table_round2 input[type="text"], .table_round2 input[type="number"] {
	width: 80px;
	padding: 5px;
	box-sizing: border-box;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.table_round2 form {
	display: inline;
}

.table_round2 input[type="submit"] {
	color: #fff;
	background-color: #d9534f;
	border-radius: 4px;
	font-size: 12px;
	width: auto;
	height: 30px;
	font-weight: 400;
	padding: 0 10px;
}

.table_round2 input[type="submit"]:hover {
	background-color: #c9302c;
}


 
</style>
</html>