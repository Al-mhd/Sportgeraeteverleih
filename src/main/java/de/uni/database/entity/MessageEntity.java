package de.uni.database.entity;

public class MessageEntity {
    int pk_msg;
    String msg;
    String msg_date;
    String sender_name;
    String receiver_name;

    public MessageEntity() {
    }

    public MessageEntity(int pk_msg, String msg, String msg_date, String sender_name, String receiver_name) {
        this.pk_msg = pk_msg;
        this.msg = msg;
        this.msg_date = msg_date;
        this.sender_name = sender_name;
        this.receiver_name = receiver_name;
    }

    public MessageEntity(String sender, String receiver, String msg) {
        this.msg = msg;
        this.sender_name = sender;
        this.receiver_name = receiver;
    }

    public int getPk_msg() {
        return pk_msg;
    }

    public void setPk_msg(int pk_msg) {
        this.pk_msg = pk_msg;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getMsg_date() {
        return msg_date;
    }

    public void setMsg_date(String msg_date) {
        this.msg_date = msg_date;
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

    @Override
    public String toString() {
        return "Msg{" +
                "pk_msg=" + pk_msg +
                ", msg='" + msg + '\'' +
                ", msg_date='" + msg_date + '\'' +
                ", sender_name='" + sender_name + '\'' +
                ", receiver_name='" + receiver_name + '\'' +
                '}';
    }
}
