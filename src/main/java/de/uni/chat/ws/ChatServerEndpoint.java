package de.uni.chat.ws;

import de.uni.chat.coder.MessageModelDecoder;
import de.uni.chat.coder.MessageModelEncoder;
import de.uni.chat.model.MessageModel;
import de.uni.database.entity.MessageEntity;
import de.uni.database.repository.MessageRepo;
import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;

import java.util.HashSet;
import java.util.Set;

/**
 * JSR is the Java API for WebSocket <br/>
 * the WebSocket container ensures the availability of the class as a WebSocket server listening to a specific URI space. <br/>
 * decoder and encoder are using to be able to send java object (in json format) instead of string
 */
@ServerEndpoint(value = "/chat", decoders = MessageModelDecoder.class, encoders = MessageModelEncoder.class)
public class ChatServerEndpoint {

    private Set<Session> sessions = new HashSet<>();

    /**
     * when new socket connection initiated, this method will invoke
     *
     * @param session is user session
     */
    @OnOpen
    public void onOpen(Session session) {
        System.out.println("onOpen: message = " + session.getId());
        sessions.add(session);
    }

    /**
     * when messageModel is sent to the endpoint '/chat', this method will invoke to handle new messageModel
     *
     * @param session      is user session
     * @param messageModel is messageModel from user
     * @return
     */
    @OnMessage
    public String onMessage(Session session, MessageModel messageModel) {
        try {
            System.out.println("--------------------------------------------------------------------");
            System.out.println("onMessage: messageModel = " + messageModel);
            String sender = messageModel.getSender_name();
            System.out.println("sender = " + sender);
            String receiver = messageModel.getReceiver_name();
            System.out.println("receiver = " + receiver);
            String msg = messageModel.getMsg();
            System.out.println("msg = " + msg);
            MessageEntity messageEntity = new MessageEntity(sender, receiver, msg);
            MessageRepo messageRepo = new MessageRepo();
            messageRepo.insertMessage(messageEntity);
            System.out.println("messageModel inserted id db. msg = '" + msg + "'");
            for (Session s : sessions) {
                if (session.getId().equals(s.getId())) {
                    s.getBasicRemote().sendObject(messageModel);
                }
            }
        } catch (Exception e) {
            return e.getMessage();
        }
        return "success";
    }
    //    @OnMessage
//    public String onMessage(Session session, String message) throws IOException {
//        System.out.println("onMessage: message = " + message);
//        String[] arr = message.split(",");
//        String sender = arr[0];
//        System.out.println("sender = " + sender);
//        String receiver = arr[1];
//        System.out.println("receiver = " + receiver);
//        String msg = arr[2];
//        System.out.println("msg = " + msg);
//        MessageEntity messageEntity = new MessageEntity(sender, receiver, msg);
//        MessageRepo messageRepo = new MessageRepo();
//        messageRepo.insertMessage(messageEntity);
//        System.out.println("message inserted id db. msg = '" + msg + "'");
//        for (Session s:sessions) {
//            s.getBasicRemote().sendText(msg);
////            s.getBasicRemote().sendObject(messageModel);
//        }
//        return "SERVER: " + session.getId() + " (received message: " + message + ")";
//    }

    /**
     * when a socket connection closed, this method will invoke
     *
     * @param session is user session
     */
    @OnClose
    public void onClose(Session session) {
        System.out.println("onClose: message = " + session.getId());
        sessions.remove(session);
    }

    /**
     * when there is problem with the communication, this method will invoke to error handling
     *
     * @param session is user session
     */
    @OnError
    public void onError(Session session, Throwable t) {
        System.out.println("ERROR: " + t.getMessage());
    }
}
