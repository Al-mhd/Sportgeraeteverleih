package de.uni.database.dao;

import de.uni.constants.AppConstants;
import de.uni.database.entity.UserEntity;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * @implNote CREATE TABLE IF NOT EXISTS product (
 * pk INTEGER PRIMARY KEY AUTOINCREMENT,
 * name TEXT,
 * preis REAL,
 * image TEXT
 * )
 * <br/>
 */
public class UserDao {
	public UserEntity checkIfBenutzerExists(UserEntity userEntity) {
		Connection conn = null;
		try {
			Class.forName("org.sqlite.JDBC");
//			System.out.println("URL = " + "jdbc:sqlite:" + AppConstants.APP_DB);
			conn = DriverManager.getConnection("jdbc:sqlite:" + AppConstants.APP_DB);
			String query = "SELECT * FROM benutzer WHERE username LIKE ? AND password LIKE ?";
			PreparedStatement preparedStatement = conn.prepareStatement(query);
			preparedStatement.setString(1, userEntity.getUsername());
			preparedStatement.setString(2, userEntity.getPassword());
			try (ResultSet rs = preparedStatement.executeQuery()) {
				if (rs.next()) {
					userEntity = new UserEntity(rs.getInt("pk"), rs.getString("username"), rs.getString("password"), rs.getString("role"));
					return userEntity;
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				System.err.println(e.getMessage());
			}
		}
		return null;
	}

	public void insertBenutzer(UserEntity userEntity) {
		Connection connection = null;
		try {
			Class.forName("org.sqlite.JDBC");
			connection = DriverManager.getConnection("jdbc:sqlite:" + AppConstants.APP_DB);
			Statement statement = connection.createStatement();
			statement.setQueryTimeout(30);  // set timeout to 30 sec.
			statement.executeUpdate("insert into benutzer (username, password) values ('" + userEntity.getUsername() + "','" + userEntity.getPassword() + "')");
		} catch (SQLException | ClassNotFoundException e) {
			System.err.println(e.getMessage());
		} finally {
			try {
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				System.err.println(e.getMessage());
			}
		}
	}

	public void createTableIfNotExists() {
		Connection connection = null;
		try {
			Class.forName("org.sqlite.JDBC");
			connection = DriverManager.getConnection("jdbc:sqlite:" + AppConstants.APP_DB);
			Statement statement = connection.createStatement();
			statement.setQueryTimeout(30);  // set timeout to 30 sec.
			statement.executeUpdate("CREATE TABLE \"benutzer\"\n" +
				"(\n" +
				"    pk       INTEGER primary key autoincrement,\n" +
				"    username TEXT,\n" +
				"    password TEXT,\n" +
				"    role     TEXT default 'user'\n" +
				")");
		} catch (SQLException | ClassNotFoundException e) {
			System.err.println(e.getMessage());
		} finally {
			try {
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				System.err.println(e.getMessage());
			}
		}
	}

	public List<UserEntity> getAllUser() {
		Connection connection = null;
		try {
			connection = DriverManager.getConnection("jdbc:sqlite:" + AppConstants.APP_DB);
			Statement statement = connection.createStatement();
			statement.setQueryTimeout(30);  // set timeout to 30 sec.
			ResultSet rs = statement.executeQuery("select * from benutzer");
			List<UserEntity> benutzerList = new ArrayList<>();
			UserEntity userEntity;
			while (rs.next()) {
				userEntity = new UserEntity(rs.getInt("pk"), rs.getString("username"), rs.getString("password"), rs.getString("role"));
				benutzerList.add(userEntity);
			}
			return benutzerList;
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		} finally {
			try {
				if (connection != null)
					connection.close();
			} catch (SQLException e) {
				System.err.println(e.getMessage());
			}
		}
		return null;
	}

	public UserEntity getUserByName(String userName) {
		Connection connection = null;
		try {
			connection = DriverManager.getConnection("jdbc:sqlite:" + AppConstants.APP_DB);
			Statement statement = connection.createStatement();
			statement.setQueryTimeout(30);  // set timeout to 30 sec.
			ResultSet rs = statement.executeQuery("select * from benutzer where username = '" + userName + "'");
            return new UserEntity(rs.getInt("pk"), rs.getString("username"), rs.getString("password"), rs.getString("role"));
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		} finally {
			try {
				if (connection != null)
					connection.close();
			} catch (SQLException e) {
				System.err.println(e.getMessage());
			}
		}
		return null;
	}

	public void updateUser(UserEntity userEntity){
		Connection connection = null;
		try {
			Class.forName("org.sqlite.JDBC");
			connection = DriverManager.getConnection("jdbc:sqlite:" + AppConstants.APP_DB);
			Statement statement = connection.createStatement();
			statement.setQueryTimeout(30);  // set timeout to 30 sec.
			statement.executeUpdate("update benutzer set username = '" + userEntity.getUsername() + "', password = '" + userEntity.getPassword() + "' where pk = '" + userEntity.getPk() + "'");
		} catch (SQLException | ClassNotFoundException e) {
			System.err.println(e.getMessage());
		} finally {
			try {
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				System.err.println(e.getMessage());
			}
		}
	}

	public void deleteUserByPk(Integer pk) {
		Connection connection = null;
		try {
			Class.forName("org.sqlite.JDBC");
			connection = DriverManager.getConnection("jdbc:sqlite:" + AppConstants.APP_DB);
			Statement statement = connection.createStatement();
			statement.setQueryTimeout(30);  // set timeout to 30 sec.
			int rs = statement.executeUpdate("delete from benutzer where pk = '" + pk + "'");
		} catch (SQLException | ClassNotFoundException e) {
			System.err.println(e.getMessage());
		} finally {
			try {
				if (connection != null) {
					connection.close();
				}
			} catch (SQLException e) {
				System.err.println(e.getMessage());
			}
		}
	}
}
