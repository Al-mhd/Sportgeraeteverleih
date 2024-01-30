package de.uni;

public class Cart implements Comparable<Cart>{
//	public Map<ProductEntity, Integer> content;
	private Integer productPk;
	private Integer anzahl;

	public Integer getProductPk() {
		return productPk;
	}

	public void setProductPk(Integer productPk) {
		this.productPk = productPk;
	}

	public Integer getAnzahl() {
		return anzahl;
	}

	public void setAnzahl(Integer anzahl) {
		this.anzahl = anzahl;
	}

	@Override
	public int compareTo(Cart other) {
		return (int) this.productPk - other.getProductPk();
	}
}
