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
import model.Item;
import model.Produto;
import persistence.GenericDao;
import persistence.ItensDao;
import persistence.ProdutoDao;

@WebServlet("/itens")
public class ItensServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ItensServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String erro = "";
        List<Produto> produtos = new ArrayList<>();
        GenericDao gDao = new GenericDao();
        ProdutoDao pDao = new ProdutoDao(gDao);

        try {
            produtos = pDao.listar();
        } catch (ClassNotFoundException | SQLException e) {
            erro = e.getMessage();
        } finally {
            request.setAttribute("erro", erro);
            request.setAttribute("produtos", produtos);
            RequestDispatcher rd = request.getRequestDispatcher("itens.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cmd = request.getParameter("botao");
        String codigo = request.getParameter("codigo");
        String marca = request.getParameter("marca");

        String saida = "";
        String erro = "";
        Item i = new Item();
        Produto p = new Produto();
        List<Item> itens = new ArrayList<>();
        List<Produto> produtos = new ArrayList<>();

        try {
            produtos = listarProduto();

            if (cmd != null && cmd.equals("Inserir")) {
                if (codigo != null && !codigo.isEmpty()) {
                    p.setCodigo(Integer.parseInt(codigo));
                    i.setProduto(p);
                    saida = cadastrarItem(i);
                } else {
                    erro = "Por favor, selecione um produto.";
                }
            } else if (cmd != null && cmd.equals("Listar")) {
                itens = listarItem(codigo, marca);
            }
        } catch (SQLException | ClassNotFoundException e) {
            erro = e.getMessage();
        } finally {
            request.setAttribute("saida", saida);
            request.setAttribute("erro", erro);
            request.setAttribute("item", i);
            request.setAttribute("itens", itens);
            request.setAttribute("produtos", produtos);
            RequestDispatcher rd = request.getRequestDispatcher("itens.jsp");
            rd.forward(request, response);
        }
    }

    private String cadastrarItem(Item i) throws SQLException, ClassNotFoundException {
        GenericDao gDao = new GenericDao();
        ItensDao iDao = new ItensDao(gDao);
        return iDao.iudItens("I", i);
    }

    private List<Item> listarItem(String codigo, String marca) throws SQLException, ClassNotFoundException {
        GenericDao gDao = new GenericDao();
        ItensDao iDao = new ItensDao(gDao);
        return iDao.listar(codigo, marca);
    }

    private List<Produto> listarProduto() throws SQLException, ClassNotFoundException {
        GenericDao gDao = new GenericDao();
        ProdutoDao pDao = new ProdutoDao(gDao);
        return pDao.listar();
    }
}


