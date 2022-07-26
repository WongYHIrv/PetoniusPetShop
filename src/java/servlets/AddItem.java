/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import da.ItemDA;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)
/**
 *
 * @author Vivian
 */
public class AddItem extends HttpServlet {

    private ItemDA itemDA;
    private static final String SAVE_DIR = "..\\..\\..\\..\\..\\..\\..\\Documents\\NetBeansProjects\\Assignment\\web\\itemImage";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String itemName = request.getParameter("itemName");
        String itemCategory = request.getParameter("itemCategory");
        String itemPrice = request.getParameter("itemPrice");
        String itemQuantity = request.getParameter("itemQuantity");
        String itemDescription = request.getParameter("itemDescription");

        String savePath = File.separator + SAVE_DIR;
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }
        Part part = request.getPart("file");
        String fileName = extractFileName(part);
        String uuid = UUID.randomUUID().toString().replace("-", "") + ".png";

        part.write(savePath + File.separator + uuid);

        itemDA = new ItemDA();
        itemDA.addRecord(itemName, itemDescription, Double.parseDouble(itemPrice), Integer.parseInt(itemQuantity), itemCategory, uuid);

        request.setAttribute("itemAdded", "Item is added.");
        response.sendRedirect("manageItem.jsp?searchResult=&category=&status=itemAdded&name="+itemName);
    }

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
