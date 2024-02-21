package de.uni.chat;

import de.uni.chat.coder.MessageModelDecoder;
import de.uni.chat.coder.MessageModelEncoder;
import de.uni.chat.model.MessageModel;
import de.uni.database.dao.MessageDao;
import de.uni.database.entity.MessageEntity;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.color.ColorSpace;
import java.awt.image.*;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

@ServerEndpoint(value = "/chat2", decoders = MessageModelDecoder.class, encoders = MessageModelEncoder.class)
public class ChatServlet {
    // < sender name, sesseion >
    private static Map<String, Session> sessions = new HashMap<>();

    @OnOpen
    public void onOpen(Session curSession) {

    }

    @OnClose
    public void onClose(Session userSession) {
        for (Map.Entry<String, Session> ses : sessions.entrySet()) {
            if (ses.getValue().getId().equals(userSession.getId())) {
                sessions.remove(ses.getKey());
            }
        }
    }

    @OnMessage
    public void onMessage(byte[] data, boolean last, Session session) throws IOException {
        System.out.println("================");
        System.out.println("ChatServlet: onMessage: image -> data = " + data);
        System.out.println("ChatServlet: onMessage: image -> data.length = " + data.length);
//        DataBufferByte buffer = new DataBufferByte(data, data.length);
//        ColorModel cm = new ComponentColorModel(ColorSpace.getInstance(ColorSpace.CS_sRGB), new int[]{8, 8, 8}, false, false, Transparency.OPAQUE, DataBuffer.TYPE_BYTE);
//        int w = 250;
//        int h = 250;
//        BufferedImage bf = new BufferedImage(cm, Raster.createInterleavedRaster(buffer, w, h, w * 3, 3, new int[]{0, 1, 2}, null), false, null);
//        ImageIO.write(bf, "jpg", Files.newOutputStream(Paths.get("output.jpg")));
        if (data != null) {
                BufferedImage bfimg = ImageIO.read(new ByteArrayInputStream(data));
                System.out.println(bfimg == null ? "null" : "not null");
                ImageIO.write(bfimg, "*", new File("output.jpg"));
            System.out.println("================");
        }
    }

    @OnMessage
    public void onMessage(Session userSession, MessageModel messageModel) {
        System.out.println("----------------");
        System.out.println("ChatServlet: onMessage: message");
        if (!sessions.containsKey(messageModel.getSender_name())) {
            sessions.put(messageModel.getSender_name(), userSession);
        }
        MessageEntity messageEntity = new MessageEntity(messageModel.getSender_name(), messageModel.getReceiver_name(), messageModel.getMsg());
        MessageDao messageDao = new MessageDao();
        messageDao.insertMessage(messageEntity);
        System.out.println("ChatServlet: onMessage: messageModel = " + messageModel);
        userSession.getAsyncRemote().sendText(messageModel.getMsg());
        for (Map.Entry<String, Session> ses : sessions.entrySet()) {
            if (ses.getKey().equals(messageModel.getReceiver_name())) {
                ses.getValue().getAsyncRemote().sendText(messageModel.getSender_name() + ": " + messageModel.getMsg());
            }
        }
        System.out.println("----------------");
    }
}
