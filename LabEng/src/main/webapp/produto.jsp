<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="css/produto.css">
<title>Produto</title>
</head>
<body style="background-image: url('imagens/fundot.png')" class="tela_aluno">
    <div class="menu">
       <jsp:include page="menu.jsp"></jsp:include>
    </div>
    <br />
    <div align="center" class="container">
    <form action="produto" method="post">
       <p class="title">
       </p>
         <p class="cadastrar"> Cadastrar Produto</p>
       <table>
   
          <tr>
              <td class = "aluno" colspan="3">
              <p class = "title">Codigo:</p>
                <input class="cadastro" type="number" 
                id="codigo" name="codigo" placeholder=""
                value='<c:out value="${produto.codigo }"></c:out>'>
                 <input type="submit" id="botao" name="botao" value="Buscar">
                 </td>
         </tr>
         <tr>
             <td class = "aluno" colspan="4">
              <p class = "title">Nome:</p>
                <input class="cadastro" type="text" id="nome" name="nome" placeholder=""
                 value='<c:out value="${produto.nome }"></c:out>'>
                 <input type="submit" id="botao" name="botao" value="Alterar" >
            </td>
         </tr>
          <tr>
             <td class = "aluno" colspan="4">
              <p class = "title">Marca:</p>
                <input class="cadastro" type="text" id="marca" name="marca" placeholder=""
                 value='<c:out value="${produto.marca }"></c:out>'>
            </td>
         </tr>
          <tr>
            <td class = "aluno" colspan="4">
              <p class = "title">Validade:</p>
                <input class="cadastro" type="date" id="validade" name="validade" placeholder=""
               value='<c:out value="${produto.validade }"></c:out>'>
            </td>
         </tr>
         <tr>
            <td class = "aluno" colspan="4">
              <p class = "title">Descricao:</p>
                <input class="cadastro" type="text" id="descricao" name="descricao" 
               value='<c:out value="${produto.descricao }"></c:out>'>
            </td>
         </tr>
         <tr>
            <td class = "aluno" colspan="4">
              <p class = "title">Valor Unitario:</p>
                <input class="cadastro" type="text" id="valorUnit" name="valorUnit" 
               value='<c:out value="${produto.valorUnit }"></c:out>'> 
            </td>
         </tr>
         <tr>
            <td class = "aluno" colspan="4">
              <p class = "title">Teor Alcoolico:</p>
                <input class="cadastro" type="text" id="teorAlcoolico" name="teorAlcoolico" 
               value='<c:out value="${produto.teorAlcoolico }"></c:out>'> 
            </td>
         </tr>
         <tr>
            <td class = "aluno" colspan="4">
              <p class = "title">Quantidade:</p>
                <input class="cadastro" type="number" id="quantidade" name="quantidade" 
               value='<c:out value="${produto.quantidade }"></c:out>'> 
            </td>
         </tr>
         <tr class="botoes">
            <td>
               <input type="submit" id="botao" name="botao" value="Cadastrar">
            </td>
            <td>
               <input type="submit" id="botao" name="botao" value="Listar">
            </td>
           </tr>
        </table>
     </form>
    </div>
    <br />
    <div align="center">
        <c:if test="${not empty erro }">
            <H2><b><c:out value="${erro }"/></b></H2>
    </c:if>
    </div>
    <div class ="mensagem" align="center">
        <c:if test="${not empty saida }">
            <H3><b><c:out value="${saida }"/></b></H3>
    </c:if>
    </div>
    <br />
    <c:if test="${not empty produtos }">
      <table class="table_round">
        <thead>
           <tr>
               <th>Codigo</th>
                <th>Nome</th>
                 <th>Marca</th>
                 <th>Validade</th>
                  <th>Descricao</th>
                  <th>Valor Unitario</th>
                  <th>Teor Alcoolico</th>
                  <th>quantidade</th>
           </tr>
        </thead>
      </tbody>
          <c:forEach var="p" items="${produtos }">
     <tr>
        <td><c:out value ="${p.codigo }"/></td>
         <td><c:out value ="${p.nome }"/></td>
         <td><c:out value ="${p.marca }"/></td>
          <td><c:out value ="${p.validade }"/></td>
           <td><c:out value ="${p.descricao}"/></td>
            <td><c:out value ="${p.valorUnit }"/></td>
            <td><c:out value ="${p.teorAlcoolico }"/></td>
            <td><c:out value ="${p.quantidade }"/></td>
            
     </tr>
    </c:forEach>
    </tbody>
        </c:if>
    </table>
  
</body>