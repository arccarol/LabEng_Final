package persistence;

import java.sql.SQLException;
import java.util.List;

import model.Item;


public interface IItensDao {
	
	public String iudItens(String acao, Item i) throws SQLException, ClassNotFoundException;

	List<Item> listar(String nome, String marca) throws SQLException, ClassNotFoundException;

}