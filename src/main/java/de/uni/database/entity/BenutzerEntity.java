package de.uni.database.entity;

public class BenutzerEntity {
	private Integer pk;
	private String username;
	private String password;

	public BenutzerEntity() {
	}

	public BenutzerEntity(String username, String password) {
		this.username = username;
		this.password = password;
	}

	public Integer getPk() {
		return pk;
	}

	public void setPk(Integer pk) {
		this.pk = pk;
	}

	public String getUsername() {
		return username;
	}

	public String getPassword() {
		return password;
	}

}
