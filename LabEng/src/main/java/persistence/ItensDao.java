package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import model.Item;
import model.Produto;


public class ItensDao implements IItensDao {

    private GenericDao gDao;

    public ItensDao(GenericDao gDao) {
        this.gDao = gDao;
    }

    @Override
    public List<Item> listar(String codigo, String marca) throws SQLException, ClassNotFoundException {
        List<Item> itens = new ArrayList<>();
        Connection c = gDao.getConnection();
        String sql = "SELECT * FROM fnItens(?, ?)"; 
        PreparedStatement ps = c.prepareStatement(sql);
        ps.setString(1, codigo);
        ps.setString(2, marca);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Item item = new Item(); 
            Produto p = new Produto();
            p.setCodigo(rs.getInt("codigo"));
            p.setNome(rs.getString("nome"));
            p.setMarca(rs.getString("marca"));
            p.setValorUnit(rs.getDouble("valorUnit"));
            item.setProduto(p); 
            itens.add(item);
        }
        
        rs.close();
        ps.close();
        c.close();

        return itens;
    }




    @Override
    public String iudItens(String op, Item i) throws SQLException, ClassNotFoundException {
        Connection c = gDao.getConnection();
        String sql = "CALL GerenciarItens(?,?,?)";
        CallableStatement cs = c.prepareCall(sql);
        cs.setString(1, op);
        cs.setInt(2, i.getProduto().getCodigo());
        cs.registerOutParameter(3, Types.VARCHAR);
        cs.execute();
        System.out.println(i.getProduto().getCodigo());
        String saida = cs.getString(3);
        cs.close();
        c.close();
        return saida;
    }

}
