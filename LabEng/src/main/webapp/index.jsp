<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href= "./css/style.css">
<title>Crud Aluno</title>
</head>
<body>  
     <div class="menu">
       <jsp:include page="menu.jsp"></jsp:include>
    </div>
     <div class=title align="center">
     <H1><b >CRUD Sistema de Estoque Adega </b></H1>
     <h2>Laboratorio de Engenharia</h2>
     </div>
     <section class= "imagens">
        <img src="imagens/fundo.webp" alt="Fundo">
        <div class="circulo"> </div>

    </section>
</body>
<style>
@import url('https://fonts.googleapis.com/css2?family=Arbutus+Slab&family=Armata&family=Teko&family=Bebas+Neue&family=Raleway:ital,wght@0,100..900;1,100..900&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap');

.menu {
background-color: #f0f0f0;
padding:20px;

}

b {
font-family: "Poppins";
font-size: 20px;
text-transform: uppercase;
font-weight: 600;

}

.title {
   margin-top: 130px;
   margin-left: 50px;
    text-align: left;
   
 }

body {
background-color: #f0f0f0;
}

section.imagens {
    display: flex;
    align-items: center;

}

section.imagens img {
    height: 500px;
    width: 500px;
    margin-top: -220px;
    margin-left: 750px;
}

section.imagens .circulo {
    position: absolute;
    height: 100%;
    width: 100%;
    top: 0;
    left: 0;
    background: linear-gradient(45deg, rgb(157, 205, 236), rgb(48, 103, 105));
    clip-path: circle(40% at right 90%);
    z-index: -1; /*deixa atras a posia��o */


}


</style>
</html>