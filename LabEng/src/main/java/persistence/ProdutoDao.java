package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import model.Produto;


public class ProdutoDao implements IProdutoDao {

    private GenericDao gDao;

    public ProdutoDao(GenericDao gDao) {
        this.gDao = gDao;
    }


    @Override
    public Produto consultar(Produto p) throws SQLException, ClassNotFoundException {
        Connection c = gDao.getConnection();
        String sql = "SELECT codigo, nome, marca, validade, descricao, valorUnit, teorAlcoolico, quantidade " +
                     "FROM Produto " +
                     "WHERE codigo = ?";
        PreparedStatement ps = c.prepareStatement(sql);
        ps.setInt(1, p.getCodigo());
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            p.setCodigo(rs.getInt("codigo"));
            p.setNome(rs.getString("nome"));
            p.setMarca(rs.getString("marca"));
            p.setValidade(rs.getString("validade"));
            p.setDescricao(rs.getString("descricao"));
            p.setValorUnit(rs.getDouble("valorUnit"));
            p.setTeorAlcoolico(rs.getDouble("teorAlcoolico"));
            p.setQuantidade(rs.getInt("quantidade"));
        } else {
            p = null;
        }
        rs.close();
        ps.close();
        c.close();
        return p;
    }

    @Override
    public List<Produto> listar() throws SQLException, ClassNotFoundException {
        List<Produto> produtos = new ArrayList<>();
        Connection c = gDao.getConnection();
        String sql = "SELECT * FROM fnProdutos()"; 
        try (PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Produto p = new Produto();
                p.setCodigo(rs.getInt("codigo"));
                p.setNome(rs.getString("nome"));
                p.setMarca(rs.getString("marca"));;
                p.setValidade(rs.getString("validade"));
                p.setDescricao(rs.getString("descricao"));
                p.setValorUnit(rs.getDouble("valorUnit"));
                p.setTeorAlcoolico(rs.getDouble("teorAlcoolico"));
                p.setQuantidade(rs.getInt("quantidade"));
                produtos.add(p);
            }
        }
        return produtos;
    }


    @Override
    public String iudProduto(String op, Produto p) throws SQLException, ClassNotFoundException {
        Connection c = gDao.getConnection();
        String sql = "CALL GerenciarProduto(?,?,?,?,?,?,?,?,?,?)";
        CallableStatement cs = c.prepareCall(sql);
        cs.setString(1, op);
        cs.setInt(2, p.getCodigo());
        cs.setString(3, p.getNome());
        cs.setString(4, p.getMarca());
        cs.setString(5, p.getValidade());
        cs.setString(6, p.getDescricao());
        cs.setDouble(7, p.getValorUnit());
        cs.setDouble(8, p.getTeorAlcoolico());
        cs.setInt(9, p.getQuantidade());
        cs.registerOutParameter(10, Types.VARCHAR);
        cs.execute();
        String saida = cs.getString(10);
        cs.close();
        c.close();
        return saida;
    }

}

	