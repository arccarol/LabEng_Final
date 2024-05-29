package model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Venda {
	
	Reserva reserva;
	Pedido pedido;
	Produto produto;
	String data_v;
	int quantidade;
	double valorTotal;
	
	
	@Override
	public String toString() {
		return "Venda [pedido=" + pedido + ", produto=" + produto + ", data_v=" + data_v + ", quantidade=" + quantidade
				+ ", valorTotal=" + valorTotal + "]";
	}
	
	
	
	
	

}
