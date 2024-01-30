package de.uni.chat.coder;

import com.google.gson.Gson;
import de.uni.chat.model.MessageModel;
import jakarta.websocket.EncodeException;
import jakarta.websocket.Encoder;

public class MessageModelEncoder implements Encoder.Text<MessageModel> {
    Gson gson = new Gson();

    @Override
    public String encode(MessageModel messageModel) throws EncodeException {
        return gson.toJson(messageModel);
    }
}
