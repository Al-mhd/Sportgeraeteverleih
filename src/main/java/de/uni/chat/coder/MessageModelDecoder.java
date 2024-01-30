package de.uni.chat.coder;

import com.google.gson.Gson;
import de.uni.chat.model.MessageModel;
import jakarta.websocket.DecodeException;
import jakarta.websocket.Decoder;

public class MessageModelDecoder implements Decoder.Text<MessageModel>{
    Gson gson = new Gson();

    @Override
    public MessageModel decode(String s) throws DecodeException {
        return gson.fromJson(s, MessageModel.class);
    }

    /**
     * this method will invoke before decode(..) to check if s is valid
     * @param s message in json format
     * @return true if message is valid json, otherwise false
     */
    @Override
    public boolean willDecode(String s) {
        return s != null;
    }
}
