/*
    Document : da/ItemDA
    Author   : rexko
*/

package da;

import domain.Account;
import java.sql.*;
import javax.swing.*;

public class ItemDA {

    private String host = "jdbc:derby://localhost:1527/pet";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "product";
    private Connection conn;
    private PreparedStatement stmt;

    public ItemDA() {
        createConnection();
    }

    // Add record
    public void addRecord(String itemName, String itemDescription, double itemPrice, int itemQuantity, String itemCategory, String itemImage) {
        String insertStr = "INSERT INTO " + tableName + "(NAME, DESCRIPTION, PRICE, QUANTITY, CATEGORY, STATUS, IMAGE) VALUES"
                + "(?, ?, ?, ?, ?, '1', ?)";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, itemName);
            stmt.setString(2, itemDescription);
            stmt.setDouble(3, itemPrice);
            stmt.setInt(4, itemQuantity);
            stmt.setString(5, itemCategory);
            stmt.setString(6, itemImage);

            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    // Update item image
    public void updateItemImage(String image, int id) {
        
        String updateStr = "UPDATE " + tableName + " set IMAGE = ? WHERE id = ?";
        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, image);
            stmt.setInt(2, id);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    // Update item Detail
    public void updateItemDetails(String itemName, String itemCategory, double itemPrice, int itemQuantity, String itemDescription, int id) {
        
        String updateStr = "UPDATE " + tableName + " set NAME = ?, CATEGORY = ?, PRICE = ?, QUANTITY = ?, DESCRIPTION = ? WHERE ID = ?";
        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, itemName);
            stmt.setString(2, itemCategory);
            stmt.setDouble(3, itemPrice);
            stmt.setInt(4, itemQuantity);
            stmt.setString(5, itemDescription);
            stmt.setInt(6, id);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    // Delete item
    public void deleteItem(int id) {
        
        String updateStr = "UPDATE " + tableName + " set STATUS = '0' WHERE ID = ?";
        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    private void createConnection() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(host, user, password);
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void shutDown() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
            }
        }
    }

    public static void main(String[] args) {
        ItemDA da = new ItemDA();
    }
}
