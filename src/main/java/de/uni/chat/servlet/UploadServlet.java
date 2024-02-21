package de.uni.chat.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;

import static de.uni.constants.AppConstants.IMAGES_PATH;

@WebServlet("/UploadServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 10,    // 10 MB
        maxFileSize = 1024 * 1024 * 50,        // 50 MB
        maxRequestSize = 1024 * 1024 * 100)    // 100 MB
public class UploadServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("name");
        String dir_path = IMAGES_PATH + "/" + username;
        File directory = new File(dir_path);
        if (!directory.exists()) {
            directory.mkdir();
        }

        Part filePart = request.getPart("file");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
//        System.out.println("filePart = " + filePart);
//        System.out.println("filename = " + fileName);
//        System.out.println("file path = " + Paths.get(filePart.getSubmittedFileName()).toString());
        InputStream fileContent = filePart.getInputStream();
        byte[] bytes = new byte[fileContent.available()];
        fileContent.read();
//        FileOutputStream fos = new FileOutputStream( IMAGES_PATH + "/" + fileName);
        FileOutputStream fos = new FileOutputStream(dir_path + "/" + fileName);
        fos.write(bytes);
        fos.flush();
        fos.close();
        request.getSession().setAttribute("uploaded", fileName);
        response.sendRedirect("addOffer.jsp");
    }

}
