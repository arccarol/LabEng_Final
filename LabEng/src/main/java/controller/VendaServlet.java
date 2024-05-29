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

import model.Pedido;
import model.Reserva;
import model.Venda;
import persistence.GenericDao;
import persistence.VendaDao;

@WebServlet("/venda")
public class VendaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final GenericDao gDao;
    private final VendaDao pDao;

    public VendaServlet() {
        super();
        gDao = new GenericDao();
        pDao = new VendaDao(gDao);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("venda.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cmd = request.getParameter("cmd");

        String saida = "";
        String erro = "";
        Venda v = new Venda();
        Pedido pe = new Pedido();
        Reserva r = new Reserva();
        List<Venda> vendas = new ArrayList<>();
        List<Venda> vendasr = new ArrayList<>();
        List<Venda> vendasI = new ArrayList<>();
        List<Venda> vendasIR = new ArrayList<>();

        try {
            if (cmd != null) {
                if (cmd.equals("Cadastrar")) {
                    String codigo = request.getParameter("codigo");
                    String quantidadeTotal = request.getParameter("quantidadeTotal");

                    if (codigo != null && !codigo.isEmpty() && quantidadeTotal != null && !quantidadeTotal.isEmpty()) {
                        pe.setCodigo(Integer.parseInt(codigo));
                        v.setPedido(pe);
                        v.setQuantidade(Integer.parseInt(quantidadeTotal));

                        saida = cadastrarVenda(v);
                    } else {
                        erro = "Parâmetros inválidos para cadastro de venda.";
                    }
                } else if (cmd.equals("Cadastrar Reserva")) {
                    String codigor = request.getParameter("codigor");
                    String quantidadeTotalr = request.getParameter("quantidadeTotalr");

                    if (codigor != null && !codigor.isEmpty() && quantidadeTotalr != null && !quantidadeTotalr.isEmpty()) {
                        r.setCodigo(Integer.parseInt(codigor));
                        v.setReserva(r);
                        v.setQuantidade(Integer.parseInt(quantidadeTotalr));

                        saida = cadastrarVendaR(v);
                    } else {
                        erro = "Parâmetros inválidos para cadastro de venda.";
                    }
                } else if (cmd.equals("Desistir")) {
                    String codigo = request.getParameter("codigo");

                    if (codigo != null && !codigo.isEmpty()) {
                        pe.setCodigo(Integer.parseInt(codigo));
                        v.setPedido(pe);

                        saida = desistirVenda(v);
                    } else {
                        erro = "Código do pedido não especificado para desistência de venda.";
                    }
                } else if (cmd.equals("Desistir Reserva")) {
                    String codigor = request.getParameter("codigor");

                    if (codigor != null && !codigor.isEmpty()) {
                        r.setCodigo(Integer.parseInt(codigor));
                        v.setReserva(r);

                        saida = desistirVendaR(v);
                    } else {
                        erro = "Código do pedido não especificado para desistência de venda.";
                    }
                } else if (cmd.equals("Listar Pedidos")) {
                    vendas = listarVendas();
                } else if (cmd.equals("Listar Reservas")) {
                    vendasr = listarVendasR();
                } else if (cmd.equals("Listar Vendas Pedidos")) {
                    vendasI = listarVendasI();
                } else if (cmd.equals("Listar Vendas Reservas")) {
                    vendasIR = listarVendasIR();
                } else {
                    erro = "Comando desconhecido: " + cmd;
                }
            } else {
                erro = "Comando não especificado.";
            }
        } catch (NumberFormatException | SQLException | ClassNotFoundException e) {
            erro = "Erro no servlet: " + e.getMessage();
        } finally {
            request.setAttribute("saida", saida);
            request.setAttribute("erro", erro);
            request.setAttribute("venda", v);
            request.setAttribute("vendas", vendas);
            request.setAttribute("vendasr", vendasr);
            request.setAttribute("vendasI", vendasI);
            request.setAttribute("vendasIR", vendasIR);
            RequestDispatcher rd = request.getRequestDispatcher("venda.jsp");
            rd.forward(request, response);
        }
    }

    private String cadastrarVenda(Venda v) throws SQLException, ClassNotFoundException {
        System.out.println("Cadastrando venda: " + v);
        return pDao.iudVenda("I", v);
    }

    private String cadastrarVendaR(Venda v) throws SQLException, ClassNotFoundException {
        System.out.println("Cadastrando venda de reserva: " + v);
        return pDao.iudVendaR("I", v);
    }

    private String desistirVenda(Venda v) throws SQLException, ClassNotFoundException {
        System.out.println("Desistindo venda: " + v);
        return pDao.iudVenda("D", v);
    }

    private String desistirVendaR(Venda v) throws SQLException, ClassNotFoundException {
        System.out.println("Desistindo venda de reserva: " + v);
        return pDao.iudVendaR("D", v);
    }

    private List<Venda> listarVendas() throws SQLException, ClassNotFoundException {
        System.out.println("Listando vendas");
        return pDao.listar();
    }

    private List<Venda> listarVendasR() throws SQLException, ClassNotFoundException {
        System.out.println("Listando reservas");
        return pDao.listarR();
    }

    private List<Venda> listarVendasI() throws SQLException, ClassNotFoundException {
        System.out.println("Listando vendas com fnVendasI");
        return pDao.listarVenda();
    }

    private List<Venda> listarVendasIR() throws SQLException, ClassNotFoundException {
        System.out.println("Listando vendas de reservas com fnVendasIR");
        return pDao.listarVendaR();
    }
}
