//package de.uni.chat.ws;
//
//import jakarta.websocket.*;
//
//import java.io.BufferedReader;
//import java.io.IOException;
//import java.io.InputStreamReader;
//
//@ClientEndpoint
//public class ChatClientEndpoint {
//    @OnOpen
//    public void onOpen(Session session) {
//        System.out.println("--- Connected " + session.getId());
//        try {
//            session.getBasicRemote().sendText("start");
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }
//
//    @OnMessage
//    public String onMessage(String message, Session session) {
//        BufferedReader bufferRead = new BufferedReader(new InputStreamReader(System.in));
//        try {
//            System.out.println("--- Received " + message);
//            String userInput = bufferRead.readLine();
//            return userInput;
//        } catch (IOException e) {
//            throw new RuntimeException(e);
//        }
//    }
//
//    @OnClose
//    public void onClose(Session session, CloseReason closeReason) {
//        System.out.println("--- Session: " + session.getId());
//        System.out.println("--- Closing because: " + closeReason);
//    }
//}
