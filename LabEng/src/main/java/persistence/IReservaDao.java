package persistence;

import java.sql.SQLException;
import java.util.List;

import model.Pedido;
import model.Reserva;

public interface IReservaDao {
	 public String inserirReserva(Reserva reservaProduto) throws SQLException, ClassNotFoundException;
	List<Reserva> listarReservas(String opcao) throws SQLException, ClassNotFoundException;

}
