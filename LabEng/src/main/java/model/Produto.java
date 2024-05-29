package model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Produto {

	public int codigo;
	public String nome;
	public String marca;
	public String validade;
	public String descricao;
	public double valorUnit;
	public double teorAlcoolico;
	public int quantidade;
	
	
	@Override
	public String toString() {
		return nome;

	
}
}