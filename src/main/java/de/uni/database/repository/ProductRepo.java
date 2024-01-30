package de.uni.database.repository;

import de.uni.Cart;
import de.uni.constants.AppConstants;
import de.uni.database.entity.ProductEntity;

import java.sql.*;
import java.util.*;

public class ProductRepo {
    public void insertProduct(ProductEntity productEntity) {
        Connection connection = null;
        try {
            Class.forName("org.sqlite.JDBC");
            connection = DriverManager.getConnection("jdbc:sqlite:" + AppConstants.APP_COMMERCE_DB);
            Statement statement = connection.createStatement();
            statement.setQueryTimeout(30);  // set timeout to 30 sec.
            statement.executeUpdate("insert into product (name, preis, image, owner_name) values ('" + productEntity.getName() + "','" + productEntity.getPreis() + "','" + productEntity.getImage() + "','" + productEntity.getOwner_name() + "')");
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

    public List<ProductEntity> getAllProducts() {
        ArrayList<ProductEntity> products = new ArrayList<>();
        Connection connection = null;
        try {
            Class.forName("org.sqlite.JDBC");
            connection = DriverManager.getConnection("jdbc:sqlite:" + AppConstants.APP_COMMERCE_DB);
            Statement statement = connection.createStatement();
            statement.setQueryTimeout(30);  // set timeout to 30 sec.
            ResultSet rs = statement.executeQuery("select * from product");
            while (rs.next()) {
                products.add(new ProductEntity(rs.getInt("pk"), rs.getString("name"), rs.getDouble("preis"), rs.getString("image"), rs.getString("owner_name")));
            }
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
        return products;
    }

    public Map<ProductEntity, Integer> getCartProducts(ArrayList<Cart> cart) {
        Map<ProductEntity, Integer> products = new HashMap<>();
//        Collections.sort(cart);
        for (Cart c : cart) {
            products.put(getProductByPk(c.getProductPk()), c.getAnzahl());
        }
        return products;
    }

    private ProductEntity getProductByPk(Integer productPk) {
        Connection connection = null;
        try {
            Class.forName("org.sqlite.JDBC");
            connection = DriverManager.getConnection("jdbc:sqlite:" + AppConstants.APP_COMMERCE_DB);
            Statement statement = connection.createStatement();
            statement.setQueryTimeout(30);  // set timeout to 30 sec.
            ResultSet rs = statement.executeQuery("select * from product where pk = '" + productPk + "'");
            rs.next();
            return new ProductEntity(
                    rs.getInt("pk"),
                    rs.getString("name"),
                    rs.getDouble("preis"),
                    rs.getString("image"),
                    rs.getString("owner_name")
            );
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
        return null;
    }

    public void deleteProductByPk(Integer pk) {
        Connection connection = null;
        try {
            Class.forName("org.sqlite.JDBC");
            connection = DriverManager.getConnection("jdbc:sqlite:" + AppConstants.APP_COMMERCE_DB);
            Statement statement = connection.createStatement();
            statement.setQueryTimeout(30);  // set timeout to 30 sec.
            int rs = statement.executeUpdate("delete from product where pk = '" + pk + "'");
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
