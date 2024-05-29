package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Pedido;
import model.Produto;
import model.Reserva;
import persistence.GenericDao;
import persistence.PedidoDao;
import persistence.ReservaDao;

@WebServlet("/pedido")
public class PedidoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public PedidoServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("pedido.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cmd = request.getParameter("botao");
        String codigo = request.getParameter("codigo");

        String saida = "";  
        String erro = "";
        Pedido pe = new Pedido();
        List<Pedido> pedidos = new ArrayList<>();
        List<Pedido> pedidosI = new ArrayList<>();
        List<Reserva> reservas = new ArrayList<>(); 

        try {
            if (cmd != null && cmd.equals("Cadastrar")) {
                Map<String, String[]> allRequestParam = request.getParameterMap();
                for (Map.Entry<String, String[]> entry : allRequestParam.entrySet()) {
                    String key = entry.getKey();
                    String[] values = entry.getValue();

                    if (key.startsWith("quantidade")) {
                        String quantIndex = key.substring(10);

                        for (String value : values) {
                            Pedido novoPedido = new Pedido();
                            novoPedido.setCodigo(Integer.parseInt(codigo));

                            String produtoKey = "produto" + quantIndex;
                            String[] produtoValues = allRequestParam.get(produtoKey);
                            if (produtoValues != null && produtoValues.length > 0) {
                                String produtoCodigo1 = produtoValues[0];
                                Produto p = new Produto();
                                p.setCodigo(Integer.parseInt(produtoCodigo1));
                                novoPedido.setProduto(p);
                            }

                            novoPedido.setQuantidade(Integer.parseInt(value));

                            try {
                                String resultadoCadastro = cadastrarPedido(novoPedido);
                                saida = resultadoCadastro;  
                            } catch (SQLException | ClassNotFoundException e) {
                                saida = "Erro ao cadastrar pedido: " + e.getMessage() + "<br>";
                            }
                        }
                    }
                }
            } else if (cmd != null && cmd.equals("Excluir")) {
                String[] produtosExclusao = request.getParameterValues("produtoCodigo");

                if (produtosExclusao != null && produtosExclusao.length > 0) {
                    for (String produtoCodigoExclusao : produtosExclusao) {
                        Produto produtoParaExcluir = new Produto();
                        produtoParaExcluir.setCodigo(Integer.parseInt(produtoCodigoExclusao));

                        Pedido pedidoParaExcluir = new Pedido();
                        pedidoParaExcluir.setProduto(produtoParaExcluir);

                        try {
                            String resultadoExclusao = excluirPedido(pedidoParaExcluir);
                            saida += resultadoExclusao;  
                        } catch (SQLException | ClassNotFoundException e) {
                            erro = "Erro ao excluir pedido: " + e.getMessage();
                        }
                    }
                }
            } else if (cmd != null && cmd.equals("Listar Itens")) {
                pedidos = listarPedidos();
            } else if (cmd != null && cmd.equals("Listar")) {
                pedidosI = listarPedidosI();
            
            } else if (cmd != null && cmd.equals("Reservar")) {
           
                String codigoReservaParam = request.getParameter("codigoReserva");
                
                try {
                    if (codigoReservaParam != null && !codigoReservaParam.isEmpty()) {
                        int codigoReserva = Integer.parseInt(codigoReservaParam);

                        Map<String, String[]> allRequestParam = request.getParameterMap();
                        for (Map.Entry<String, String[]> entry : allRequestParam.entrySet()) {
                            String key = entry.getKey();
                            String[] values = entry.getValue();

                            if (key.startsWith("quantidade")) {
                                String quantIndex = key.substring(10);

                                for (String value : values) {
                                    Reserva novaReserva = new Reserva();
                                    novaReserva.setCodigo(codigoReserva);

                                    String produtoKey = "produto" + quantIndex;
                                    String[] produtoValues = allRequestParam.get(produtoKey);
                                    if (produtoValues != null && produtoValues.length > 0) {
                                        String produtoCodigo1 = produtoValues[0];
                                        Produto p = new Produto();
                                        p.setCodigo(Integer.parseInt(produtoCodigo1));
                                        novaReserva.setProduto(p);
                                    }

                                    novaReserva.setQuantidade(Integer.parseInt(value));

                                    try {
                                        String resultado = inserirReserva(novaReserva);
                                        saida = resultado;  
                                    } catch (SQLException | ClassNotFoundException e) {
                                        saida = "Erro ao inserir reserva: " + e.getMessage() + "<br>";
                                    }
                                }
                            }
                        }
                    } else {
                        saida = "Erro: O código de reserva não foi especificado.";
                    }
                } catch (NumberFormatException e) {
                    saida = "Erro: O código de reserva fornecido é inválido.";
                }
            
            } else if (cmd != null && cmd.equals("Listar Reservas")) {
                reservas = listarReservas("L");
            }
        } catch (SQLException | ClassNotFoundException e) {
            erro = "Erro no servlet: " + e.getMessage();
        } finally {
            request.setAttribute("saida", saida);
            request.setAttribute("erro", erro);
            request.setAttribute("pedido", pe);
            request.setAttribute("pedidos", pedidos);
            request.setAttribute("pedidosI", pedidosI);
            request.setAttribute("reservas", reservas);
            
            RequestDispatcher rd = request.getRequestDispatcher("pedido.jsp");
            rd.forward(request, response);
        }
    }

    private String inserirReserva(Reserva novaReserva)throws SQLException, ClassNotFoundException {
    	GenericDao gDao = new GenericDao();
    	ReservaDao rDao = new ReservaDao(gDao);
        return rDao.inserirReserva(novaReserva) ;
	}

	private String cadastrarPedido(Pedido pe) throws SQLException, ClassNotFoundException {
        GenericDao gDao = new GenericDao();
        PedidoDao pDao = new PedidoDao(gDao);
        return pDao.iudPedido("I", pe);
    }

    private String excluirPedido(Pedido pe) throws SQLException, ClassNotFoundException {
        try {
            GenericDao gDao = new GenericDao();
            PedidoDao pDao = new PedidoDao(gDao);
            return pDao.iudPedido("D", pe);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            throw e;
        }
    }

    private List<Pedido> listarPedidos() throws SQLException, ClassNotFoundException {
        GenericDao gDao = new GenericDao();
        PedidoDao pDao = new PedidoDao(gDao);
        return pDao.listar();
    }

    private List<Pedido> listarPedidosI() throws SQLException, ClassNotFoundException {
        GenericDao gDao = new GenericDao();
        PedidoDao pDao = new PedidoDao(gDao);
        return pDao.listarPedido();
    }  

    private List<Reserva> listarReservas(String opcao) throws SQLException, ClassNotFoundException {
        try {
            GenericDao gDao = new GenericDao();
            ReservaDao reservaDao = new ReservaDao(gDao);
            return reservaDao.listarReservas(opcao);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            throw e;
        }
  
    }
}