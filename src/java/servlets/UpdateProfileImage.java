/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import da.AccountDA;
import java.nio.file.FileSystems;
import java.util.UUID;
import javax.servlet.http.HttpSession;

/**
 *
 * @author IrvineWYH / AbigailSA
 */

//@WebServlet("/FileUploadServlet") //do not run this code
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)

public class UpdateProfileImage extends HttpServlet {

    private AccountDA accDA;
    private static final String SAVE_DIR = "..\\..\\..\\..\\..\\..\\..\\Documents\\NetBeansProjects\\Assignment\\web\\profileImage";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String savePath = File.separator + SAVE_DIR;
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }
        Part part = request.getPart("file");
        String fileName = extractFileName(part);
        String uuid = UUID.randomUUID().toString().replace("-", "") + ".png";

        part.write(savePath + File.separator + uuid);

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        accDA = new AccountDA();
        accDA.updateProfileImage(uuid, username);

        session.setAttribute("image", uuid);
        
        request.setAttribute("uploadSuccess", "Upload success, profile picture will be loaded soon.");
        request.getRequestDispatcher("userProfileSetting.jsp").forward(request, response);
    }

    // file name of the upload file is included in content-disposition header like this:
    //form-data; name="dataFile"; filename="PHOTO.JPG"
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}
