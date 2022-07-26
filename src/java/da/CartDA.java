/*
    Document : da/CartDA
    Author   : rexko
*/

package da;

import java.sql.*;
import javax.swing.*;

public class CartDA {

    private String host = "jdbc:derby://localhost:1527/pet";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Cart";
    private Connection conn;
    private PreparedStatement stmt;

    public CartDA() {
        createConnection();
    }

    // Add record
    public void addRecord(String username, int id, int quantity) {
        String insertStr = "INSERT INTO " + tableName + "(username, id, quantity) VALUES"
                + "(?, ?, ?)";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, username);
            stmt.setInt(2, id);
            stmt.setInt(3, quantity);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    // Find duplicate
    public int findDuplicate(String username, int id) {
        String insertStr = "SELECT * FROM " + tableName + " WHERE USERNAME = ? AND ID = ?";
        int found = 0;
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, username);
            stmt.setInt(2, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                found = 1;
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        
        return found;
    }

    // Increment by 1
    public void increaseBy1(String username, int id) {
        String insertStr = "UPDATE " + tableName + " SET QUANTITY = QUANTITY + 1 WHERE USERNAME = ? AND ID = ?";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, username);
            stmt.setInt(2, id);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    // Decrement by 1
    public void decreaseBy1(String username, int id) {
        String insertStr = "UPDATE " + tableName + " SET QUANTITY = QUANTITY - 1 WHERE USERNAME = ? AND ID = ?";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, username);
            stmt.setInt(2, id);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    // Delete one item
    public void deleteOne(String username, int id) {
        String delStr = "DELETE FROM " + tableName + " WHERE USERNAME = ? AND ID = ?";
        try {
            stmt = conn.prepareStatement(delStr);
            stmt.setString(1, username);
            stmt.setInt(2, id);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    // Get quantity
    public int getQuantity(String username, int id) {
        String retrieveStr = "SELECT * FROM  " + tableName + " WHERE USERNAME = ? AND ID = ?";
        int quantity = 1;
        try {
            stmt = conn.prepareStatement(retrieveStr);
            stmt.setString(1, username);
            stmt.setInt(2, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                quantity = rs.getInt("quantity");
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return quantity;
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
        CartDA da = new CartDA();
    }
}
