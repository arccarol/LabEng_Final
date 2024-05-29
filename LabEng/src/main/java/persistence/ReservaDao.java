package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import model.Produto;
import model.Reserva;

public class ReservaDao implements IReservaDao {

	private GenericDao gDao;

	public ReservaDao(GenericDao gDao) {
		this.gDao = gDao;
	}

    @Override
	public String inserirReserva(Reserva reservaProduto) throws SQLException, ClassNotFoundException {
    	 Connection c = gDao.getConnection();
         String sql = "CALL InserirReserva(?,?,?,?,?)";
         CallableStatement cs = c.prepareCall(sql);
         cs.setString(1, "I");
         cs.setInt(2, reservaProduto.getCodigo());
         cs.setInt(3, reservaProduto.getProduto().getCodigo());
         cs.setInt(4, reservaProduto.getQuantidade());
         cs.registerOutParameter(5, Types.VARCHAR);
         cs.execute();
         String saida = cs.getString(5);
       
         cs.close();
         c.close();
         return saida;
     
    }
    public List<Reserva> listarReservas(String opcao) throws SQLException, ClassNotFoundException {
    	 Connection con = gDao.getConnection();
         CallableStatement cs = null;
         ResultSet rs = null;
         List<Reserva> reservas = new ArrayList<>();

         try {
             cs = con.prepareCall("{call ListarReservas(?)}");
             cs.setString(1, opcao);
             rs = cs.executeQuery();

             while (rs.next()) {
                 Reserva reserva = new Reserva();
                 reserva.setCodigo(rs.getInt("codigo_reserva"));
                 reserva.setData_reserva(rs.getDate("data_reserva"));
                 reserva.setData_limite(rs.getDate("data_limite"));
                 reserva.setStatus(rs.getString("status_reserva"));
                 reserva.setQuantidade(rs.getInt("quantidade"));

                 Produto produto = new Produto();
                 produto.setNome(rs.getString("nome_produto"));
                 reserva.setProduto(produto);

                 reservas.add(reserva);
             }
         } catch (SQLException e) {
             e.printStackTrace();
             throw e;
         } finally {
             if (rs != null)
                 rs.close();
             if (cs != null)
                 cs.close();
             if (con != null)
                 con.close();
         }

         return reservas;
	}
}