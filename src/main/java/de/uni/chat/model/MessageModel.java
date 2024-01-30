package de.uni.chat.model;

public class MessageModel {
    String msg;
    String sender_name;
    String receiver_name;

    @Override
    public String toString() {
        return "{" +
                "msg : '" + msg + '\'' +
                ", sender_name : '" + sender_name + '\'' +
                ", receiver_name : '" + receiver_name + '\'' +
                '}';
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getSender_name() {
        return sender_name;
    }

    public void setSender_name(String sender_name) {
        this.sender_name = sender_name;
    }

    public String getReceiver_name() {
        return receiver_name;
    }

    public void setReceiver_name(String receiver_name) {
        this.receiver_name = receiver_name;
    }
}
