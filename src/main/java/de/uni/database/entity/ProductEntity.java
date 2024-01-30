package de.uni.database.entity;

public class ProductEntity {
	private Integer pk;
	private String name;
	private double preis;
	private String image;

	private String owner_name;

	public String getOwner_name() {
		return owner_name;
	}

	public ProductEntity() {
	}

	public ProductEntity(String name, double preis, String image, String owner_name) {
		this.name = name;
		this.preis = preis;
		this.image = image;
		this.owner_name = owner_name;
	}

	public ProductEntity(Integer pk, String name, double preis, String image, String owner_name) {
		this.pk = pk;
		this.name = name;
		this.preis = preis;
		this.image = image;
		this.owner_name = owner_name;
	}

	public ProductEntity(Integer pk, String name, double preis, String image) {
		this.pk = pk;
		this.name = name;
		this.preis = preis;
		this.image = image;
	}

	public ProductEntity(String name, double preis, String image) {
		this.name = name;
		this.preis = preis;
		this.image = image;
	}

	public Integer getPk() {
		return pk;
	}

	public void setPk(Integer pk) {
		this.pk = pk;
	}

	public String getName() {
		return name;
	}

	public double getPreis() {
		return preis;
	}

	public String getImage() {
		return image;
	}
}
