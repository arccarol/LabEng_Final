<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/itens.css">
<title>Itens</title>
</head>
<body style="background-image: url('imagens/fundot.png')" class="tela_aluno">
	<div class="menu">
		<jsp:include page="menu.jsp"></jsp:include>
	</div>
	<br />
	<div align="center" class="container">
		<form action="itens" method="post" class="itens">
			<p class="title"></p>
			<p class="cadastrar">Adicionar os Produtos</p>
			<table>
				<tr>
					<td class="aluno" colspan="4">
						<p class="title">Produto:</p> <select class="cadastro" id="codigo"
						name="codigo">
							<option value="">Selecione um produto</option>
							<c:forEach var="produto" items="${produtos}">
								<option value="${produto.codigo}">${produto.nome}</option>
							</c:forEach>
					</select>
					</td>
				</tr>
				<tr>
					<td class="aluno" colspan="4">
						<p class="title">Marca:</p> <select class="cadastro" id="marca"
						name="marca">
							<option value="">Selecione a Marca</option>
							<c:forEach var="produto" items="${produtos}">
								<option value="${produto.marca}">${produto.marca}</option>
							</c:forEach>
					</select>
					</td>
				</tr>
				<tr class="botoes">
					<td><input type="submit" id="botaoListar" name="botao"
						value="Listar"></td>
				</tr>
			</table>
		</form>
	</div>
	<br />
	<div align="center">
		<c:if test="${not empty erro}">
			<h2>
				<b><c:out value="${erro}" /></b>
			</h2>
		</c:if>
	</div>
	<div class="mensagem" align="center">
		<c:if test="${not empty saida}">
			<h3>
				<b><c:out value="${saida}" /></b>
			</h3>
		</c:if>
	</div>
	<br />
	<c:if test="${not empty itens}">
		<table class="table_round">
			<thead>
				<tr>
					<th>Código</th>
					<th>Nome</th>
					<th>Marca</th>
					<th>Valor Unitário</th>
					<th>Inserir</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" items="${itens}">
					<tr>
						<td><c:out value="${i.produto.codigo}" /></td>
						<td><c:out value="${i.produto.nome}" /></td>
						<td><c:out value="${i.produto.marca}" /></td>
						<td><c:out value="${i.produto.valorUnit}" /></td>
						<td style="text-align: center;">
							<form action="itens" method="post">
								<input type="hidden" name="botao" value="Inserir"> <input
									type="hidden" name="codigo" value="${i.produto.codigo}">
								<button type="submit" class="btn-inserir">Inserir</button>
							</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>
</body>
</html>

