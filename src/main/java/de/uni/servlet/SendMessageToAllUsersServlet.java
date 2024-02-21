package de.uni.servlet;

import de.uni.database.entity.MessageEntity;
import de.uni.database.entity.UserEntity;
import de.uni.database.dao.MessageDao;
import de.uni.database.dao.UserDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import static de.uni.constants.AppConstants.ADMIN_ROLE_NAME;

@WebServlet(name = "messageToAllUsers", value = "/message-to-all-users")
public class SendMessageToAllUsersServlet extends HttpServlet {
    private UserDao userDao;
    private MessageDao messageDao;

    public void init() {
        userDao = new UserDao();
        messageDao = new MessageDao();
    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String msg = req.getParameter("message_to_all");
        List<UserEntity> users = userDao.getAllUser();
        MessageEntity messageEntity;
        for (UserEntity userEntity : users) {
            if (userEntity.getRole().equals(ADMIN_ROLE_NAME)) {
                continue;
            }
            messageEntity = new MessageEntity((String) req.getSession().getAttribute("name"), userEntity.getUsername(), msg);
            messageDao.insertMessage(messageEntity);
        }
        resp.sendRedirect("users.jsp");
    }
}
