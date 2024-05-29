package persistence;

import java.sql.SQLException;
import java.util.List;

import model.Venda;

public interface IVendaDao {
	
	public String iudVenda(String acao, Venda v) throws SQLException, ClassNotFoundException;

	List<Venda> listar() throws SQLException, ClassNotFoundException;

	List<Venda> listarVenda() throws SQLException, ClassNotFoundException;

	List<Venda> listarR() throws SQLException, ClassNotFoundException;

	List<Venda> listarVendaR() throws SQLException, ClassNotFoundException;

	String iudVendaR(String op, Venda v) throws SQLException, ClassNotFoundException;

}