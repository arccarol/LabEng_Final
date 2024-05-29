package persistence;

import java.sql.SQLException;
import java.util.List;

import model.Pedido;

public interface IPedidoDao {
	
	public String iudPedido(String acao, Pedido pe) throws SQLException, ClassNotFoundException;

	List<Pedido> listar() throws SQLException, ClassNotFoundException;

	List<Pedido> listarPedido() throws SQLException, ClassNotFoundException;

}