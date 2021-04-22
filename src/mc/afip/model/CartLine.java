package mc.afip.model;

import java.io.Serializable;


public class CartLine implements Serializable {
	private int id;
	private String name;
	private float quantity;
	private float price;

	public CartLine(int id, String name, float quantity, float f) {
		this.id = id;
		this.name = name;
		this.quantity = quantity;
		this.price = f;
	}
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public float getQuantity() {
		return quantity;
	}


	public void setQuantity(float quantity) {
		this.quantity = quantity;
	}


	public float getPrice() {
		return price;
	}


	public void setPrice(float price) {
		this.price = price;
	}
	
	
	
	
}
