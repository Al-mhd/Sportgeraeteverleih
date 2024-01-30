package de.uni.database.repository;

import de.uni.constants.AppConstants;
import de.uni.database.entity.BenutzerEntity;

import java.sql.*;

/**
 * @implNote CREATE TABLE IF NOT EXISTS product (
 * pk INTEGER PRIMARY KEY AUTOINCREMENT,
 * name TEXT,
 * preis REAL,
 * image TEXT
 * )
 * <br/>
 */
public class BenutzerRepo {
    public BenutzerRepo() {
//		Connection connection = null;
//		try {
//			// create a database connection
//			connection = DriverManager.getConnection("jdbc:sqlite:"+ AppConstants.APP_DB);
//			Statement statement = connection.createStatement();
////			statement.setQueryTimeout(30);  // set timeout to 30 sec.
//
//			ResultSet rs = statement.executeQuery("select * from person");
//			while(rs.next())
//			{
//				// read the result set
//				System.out.println("name = " + rs.getString("name"));
//				System.out.println("id = " + rs.getInt("id"));
//			}
//		} catch (SQLException e) {
//			// if the error message is "out of memory",
//			// it probably means no database file is found
//			System.err.println(e.getMessage());
//		} finally {
//			try {
//				if (connection != null)
//					connection.close();
//			} catch (SQLException e) {
//				// connection close failed.
//				System.err.println(e.getMessage());
//			}
//		}
    }

    public boolean checkIfBenutzerExists(BenutzerEntity benutzerEntity) {
        Connection conn = null;
        try {
            Class.forName("org.sqlite.JDBC");
            conn = DriverManager.getConnection("jdbc:sqlite:" + AppConstants.APP_DB);
            String query = "SELECT (count(*) > 0) as found FROM benutzer WHERE username LIKE ? AND password LIKE ?";
            PreparedStatement preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, benutzerEntity.getUsername());
            preparedStatement.setString(2, benutzerEntity.getPassword());
            try (ResultSet rs = preparedStatement.executeQuery()) {
                // Only expecting a single result
                if (rs.next()) {
                    boolean found = rs.getBoolean(1); // "found" column
                    return found;
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
        return false;
    }

    public void insertBenutzer(BenutzerEntity benutzerEntity) {
        Connection connection = null;
        try {
            Class.forName("org.sqlite.JDBC");
            connection = DriverManager.getConnection("jdbc:sqlite:" + AppConstants.APP_DB);
            Statement statement = connection.createStatement();
            statement.setQueryTimeout(30);  // set timeout to 30 sec.
            statement.executeUpdate("insert into benutzer (username, password) values ('" + benutzerEntity.getUsername() + "','" + benutzerEntity.getPassword() + "')");
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
            statement.executeUpdate("create table if not exists benutzer (pk integer primary key autoincrement, username text, password text)");
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
