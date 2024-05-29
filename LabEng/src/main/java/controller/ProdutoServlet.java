package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Produto;
import persistence.GenericDao;
import persistence.ProdutoDao;

@WebServlet("/produto")
public class ProdutoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public ProdutoServlet() {
        super();
        
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("produto.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getParameter("botao");
        String codigo = request.getParameter("codigo");
        String nome = request.getParameter("nome");
        String marca = request.getParameter("marca");
        String validade = request.getParameter("validade");
        String descricao = request.getParameter("descricao");
        String valorUnit = request.getParameter("valorUnit");
        String teorAlcoolico = request.getParameter("teorAlcoolico");
        String quantidade= request.getParameter("quantidade");
        

        String saida="";
        String erro="";
        Produto p = new Produto();
        List<Produto> produtos = new ArrayList<>();

        if(!cmd.contains("Listar")) {
            p.setCodigo(Integer.parseInt(codigo));
        }

        if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
            p.setNome(nome);
            p.setCodigo(Integer.parseInt(codigo));
            p.setValidade(validade);
            p.setDescricao(descricao);
            p.setMarca(marca);
            // Parse the double values
            p.setValorUnit(Double.parseDouble(valorUnit));
            p.setTeorAlcoolico(Double.parseDouble(teorAlcoolico));
            p.setQuantidade(Integer.parseInt(quantidade));
        }

        try {
            if (cmd.contains("Cadastrar")) {
                saida = cadastrarProduto(p);
                p = null;
            }
            if (cmd.contains("Alterar")) {
                saida = alterarProduto(p);
                p = null;
            }
            if (cmd.contains("Buscar")) {
                p = buscarProduto(p);
            }
            if (cmd.contains("Listar")) {
                produtos = listarProduto();
            }
        } catch(SQLException | ClassNotFoundException e) {
            erro = e.getMessage();
        } finally {
            request.setAttribute("saida", saida);
            request.setAttribute("erro", erro);
            request.setAttribute("produto", p);
            request.setAttribute("produtos", produtos);
            RequestDispatcher rd = request.getRequestDispatcher("produto.jsp");
            rd.forward(request, response);
        }
    }


	private String cadastrarProduto(Produto p)throws SQLException, ClassNotFoundException {
		 GenericDao gDao = new GenericDao();
	        ProdutoDao pDao = new ProdutoDao(gDao);
	        return pDao.iudProduto("I", p);
	}


	private String alterarProduto(Produto p)throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		 ProdutoDao pDao = new ProdutoDao(gDao);
		String saida = pDao.iudProduto("U", p);
		return saida;
	}


	private Produto buscarProduto(Produto p)throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		 ProdutoDao pDao = new ProdutoDao(gDao);
	    p = pDao.consultar(p);
		return p;
	}


	private List<Produto> listarProduto() throws SQLException, ClassNotFoundException{
		GenericDao gDao = new GenericDao();
		 ProdutoDao pDao = new ProdutoDao(gDao);
	    List<Produto> produtos = pDao.listar();
	    
		 return produtos;
		 
	}

}