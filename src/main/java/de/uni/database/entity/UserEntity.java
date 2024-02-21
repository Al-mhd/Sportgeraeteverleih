package de.uni.database.entity;

public class UserEntity {
	private Integer pk;
	private String username;
	private String password;
	private String role;

	public UserEntity() {
	}

	public UserEntity(String username, String password) {
		this.username = username;
		this.password = password;
	}

	public UserEntity(int pk, String username, String password, String role) {
		this.pk = pk;
		this.username = username;
		this.password = password;
		this.role = role;
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

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
}
