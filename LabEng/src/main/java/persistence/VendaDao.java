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
import model.Reserva;
import model.Venda;

public class VendaDao implements IVendaDao {

    private GenericDao gDao;

    public VendaDao(GenericDao gDao) {
        this.gDao = gDao;
    }

    @Override
    public List<Venda> listar() throws SQLException, ClassNotFoundException {
        List<Venda> vendas = new ArrayList<>();
        Connection c = gDao.getConnection();
        String sql = "SELECT * FROM fnVendaP()"; 
        try (PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Pedido pe = new Pedido();
                Produto produto = new Produto();
                Venda v = new Venda();

                pe.setCodigo(rs.getInt("codigoPedido"));
                produto.setCodigo(rs.getInt("codigoProduto"));
                produto.setNome(rs.getString("nomeProduto"));
                produto.setMarca(rs.getString("marcaProduto"));
                produto.setValorUnit(rs.getDouble("valorProduto"));
                produto.setQuantidade(rs.getInt("quantidadeProduto"));
                pe.setProduto(produto);
                v.setValorTotal(rs.getDouble("valorTotal"));
                v.setPedido(pe);
                
                vendas.add(v);
            }
        }
        c.close();
        return vendas;
    }
    
    @Override
    public List<Venda> listarR() throws SQLException, ClassNotFoundException {
        List<Venda> vendas = new ArrayList<>();
        Connection c = gDao.getConnection();
        String sql = "SELECT * FROM fnVendaR()"; 
        try (PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
            	Reserva r = new Reserva();
                Produto produto = new Produto();
                Venda v = new Venda();

                r.setCodigo(rs.getInt("codigoReserva"));
                produto.setCodigo(rs.getInt("codigoProduto"));
                produto.setNome(rs.getString("nomeProduto"));
                produto.setMarca(rs.getString("marcaProduto"));
                produto.setValorUnit(rs.getDouble("valorProduto"));
                produto.setQuantidade(rs.getInt("quantidadeProduto"));
                r.setProduto(produto);
                v.setValorTotal(rs.getDouble("valorTotal"));
                v.setReserva(r);
                
                vendas.add(v);
            }
        }
        c.close();
        return vendas;
    }

    @Override
    public List<Venda> listarVenda() throws SQLException, ClassNotFoundException {
        List<Venda> vendas = new ArrayList<>();
        Connection c = gDao.getConnection();
        String sql = "SELECT * FROM fnVendasI()"; 

        try (PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Venda v = new Venda();
                Pedido pe = new Pedido();

                pe.setCodigo(rs.getInt("pedido"));
                v.setPedido(pe);
                v.setQuantidade(rs.getInt("quantidadeTotal"));
                v.setValorTotal(rs.getDouble("valorTotal"));
                v.setData_v(rs.getString("data_v"));
                
                vendas.add(v);
            }
        }
        c.close();
        return vendas;
    }

    @Override
    public List<Venda> listarVendaR() throws SQLException, ClassNotFoundException {
        List<Venda> vendas = new ArrayList<>();
        Connection c = gDao.getConnection();
        String sql = "SELECT * FROM fnVendasIR()"; 

        try (PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Venda v = new Venda();
                Reserva r = new Reserva();

                r.setCodigo(rs.getInt("reserva"));
                v.setReserva(r);
                v.setQuantidade(rs.getInt("quantidadeTotalr"));
                v.setValorTotal(rs.getDouble("valorTotalr"));
                v.setData_v(rs.getString("data_vr"));
                
                vendas.add(v);
            }
        }
        c.close();
        return vendas;
    }
    
    @Override
    public String iudVenda(String op, Venda v) throws SQLException, ClassNotFoundException {
        Connection c = gDao.getConnection();
        String sql = "CALL GerenciarVenda(?,?,?)";
        CallableStatement cs = c.prepareCall(sql);
        cs.setString(1, op);
        cs.setInt(2, v.getPedido().getCodigo());
        cs.registerOutParameter(3, Types.VARCHAR);
        cs.execute();
        String saida = cs.getString(3);
        cs.close();
        c.close();
        return saida;
    }



@Override
public String iudVendaR(String op, Venda v) throws SQLException, ClassNotFoundException {
    Connection c = gDao.getConnection();
    String sql = "CALL GerenciarVendaR(?,?,?)";
    CallableStatement cs = c.prepareCall(sql);
    cs.setString(1, op);
    cs.setInt(2, v.getReserva().getCodigo());
    cs.registerOutParameter(3, Types.VARCHAR);
    cs.execute();
    String saida = cs.getString(3);
    cs.close();
    c.close();
    return saida;
}

}
