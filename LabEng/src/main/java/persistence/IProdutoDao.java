package persistence;

import java.sql.SQLException;
import java.util.List;

import model.Produto;

public interface IProdutoDao {
	
	public String iudProduto(String acao, Produto p) throws SQLException, ClassNotFoundException;

	Produto consultar(Produto p) throws SQLException, ClassNotFoundException;

	List<Produto> listar() throws SQLException, ClassNotFoundException;

}