package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import model.Pedido;
import model.Produto;


public class PedidoDao implements IPedidoDao {

    private GenericDao gDao;

    public PedidoDao(GenericDao gDao) {
        this.gDao = gDao;
    }

    @Override
    public List<Pedido> listar() throws SQLException, ClassNotFoundException {
        List<Pedido> pedidos = new ArrayList<>();
        Connection c = gDao.getConnection();
        String sql = "SELECT * FROM fnPedidos()"; 
        try (PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
            	 Pedido pe = new Pedido();
                 Produto p = new Produto();
                 p.setCodigo(rs.getInt("produto"));
                 p.setNome(rs.getString("nome"));
                 p.setMarca(rs.getString("marca"));
                 pe.setProduto(p);
                 pedidos.add(pe);
            }
        }
        return pedidos;
    }
    
    @Override
    public List<Pedido> listarPedido() throws SQLException, ClassNotFoundException {
        List<Pedido> pedidosI = new ArrayList<>();
        Connection c = gDao.getConnection();
        String sql = "SELECT * FROM fnPedidosI()"; 

        try (PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Pedido pe = new Pedido();
                Produto p = new Produto();

                pe.setCodigo(rs.getInt("codigo"));
                p.setCodigo(rs.getInt("produto"));
                p.setNome(rs.getString("nomeProduto"));
                p.setMarca(rs.getString("marcaProduto"));
                p.setValorUnit(rs.getDouble("valorProduto"));
                pe.setQuantidade(rs.getInt("quantidade"));
                pe.setStatu_p(rs.getString("status_p"));
                pe.setProduto(p);

                pedidosI.add(pe);
            }
        }

        c.close();
        return pedidosI;
    }

    @Override
    public String iudPedido(String op, Pedido p) throws SQLException, ClassNotFoundException {
        Connection c = gDao.getConnection();
        String sql = "CALL GerenciarPedido(?,?,?,?,?)";
        CallableStatement cs = c.prepareCall(sql);
        cs.setString(1, op);
        cs.setInt(2, p.getCodigo());
        cs.setInt(3, p.getProduto().getCodigo());
        cs.setInt(4, p.getQuantidade());
        cs.registerOutParameter(5, Types.VARCHAR);
        cs.execute();
        String saida = cs.getString(5);
        System.out.println(p.getProduto().getCodigo());
        cs.close();
        c.close();
        return saida;
    }
    
    
}

	
