package de.uni.database.repository;

import de.uni.constants.AppConstants;
import de.uni.database.entity.MessageEntity;
import de.uni.database.entity.ProductEntity;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * CREATE TABLE IF NOT EXISTS message (
 * 	pk INTEGER PRIMARY KEY AUTOINCREMENT,
 * 	msg TEXT,
 * 	msg_date TEXT,
 * 	sender_name TEXT,
 * 	receiver_name TEXT
 * 	)
 */
public class MessageRepo {
    public void insertMessage(MessageEntity messageEntity) {
        String msg_date = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss").format(new Date());
        messageEntity.setMsg_date(msg_date);
        String msg = messageEntity.getMsg().trim().replace("'", " ");
        messageEntity.setMsg(msg);
        Connection connection = null;
        try {
            Class.forName("org.sqlite.JDBC");
            connection = DriverManager.getConnection("jdbc:sqlite:" + AppConstants.APP_MESSAGES_DB);
            Statement statement = connection.createStatement();
            statement.setQueryTimeout(30);  // set timeout to 30 sec.
            statement.executeUpdate("insert into message (msg, msg_date, sender_name, receiver_name) values ('" + messageEntity.getMsg() + "','" + messageEntity.getMsg_date() + "','" + messageEntity.getSender_name() + "','" + messageEntity.getReceiver_name() + "')");
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

    public List<MessageEntity> getAllMessages(String senderName, String receiverName) {
        ArrayList<MessageEntity> messages = new ArrayList<>();
        Connection connection = null;
        try {
            Class.forName("org.sqlite.JDBC");
            connection = DriverManager.getConnection("jdbc:sqlite:" + AppConstants.APP_MESSAGES_DB);
            Statement statement = connection.createStatement();
            statement.setQueryTimeout(30);  // set timeout to 30 sec.
            ResultSet rs = statement.executeQuery("select * from message WHERE (sender_name = '" + senderName + "' AND receiver_name = '" + receiverName + "') OR (sender_name = '" + receiverName + "' AND receiver_name = '" + senderName + "');");
            while (rs.next()) {
                messages.add(
                        new MessageEntity(
                                rs.getInt("pk"),
                                rs.getString("msg"),
                                rs.getString("msg_date"),
                                rs.getString("sender_name"),
                                rs.getString("receiver_name")
                        ));
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
        return messages;
    }
}
