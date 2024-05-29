package model;

import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class Reserva {

	 private int codigo;
	 private Date data_reserva;
	 private Date data_limite;
	 private Produto produto;
	 private String status;
	 private int quantidade;
	 private List<Pedido> pedidos;
	 
	 public void setPedidos(List<Pedido> pedidos) {
		    this.pedidos = pedidos;
		} 
	 
	@Override
	public String toString() {
		return "Reserva [codigo=" + codigo + ", data_reserva=" + data_reserva + ", data_limite=" + data_limite
				+ ", produto=" + produto + ", status=" + status + ", quantidade=" + quantidade + ", pedido=" + pedidos
				+ "]";
	}


}