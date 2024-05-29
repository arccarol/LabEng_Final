package model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Pedido {
	
	int codigo;
	Produto produto;
	int quantidade;
	String statu_p;
	
	
	@Override
	public String toString() {
		return "Pedido [codigo=" + codigo + ", produto=" + produto + ", quantidade=" + quantidade + ", statu_p="
				+ statu_p + "]";
	}
	
	
}
