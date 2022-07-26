/*
    Document : da/TransactionDA
    Author   : rexko
*/

package da;

import java.sql.*;
import javax.swing.*;

public class TransactionsDA {

    private String host = "jdbc:derby://localhost:1527/pet";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Transactions";
    private Connection conn;
    private PreparedStatement stmt;
    private PreparedStatement rstmt;
    private PreparedStatement dstmt;
    private PreparedStatement ustmt;
    private PreparedStatement pstmt;
    
    public TransactionsDA() {
        createConnection();
    }

    // Add record
    public void addRecord(String username, String recipient, String contact, String address1, String address2, String state, String city, String zipcode, String cardNumber, String cardExpYear, String cardExpMonth, String cardCVV, String trackingID) {
        String insertStr = "INSERT INTO " + tableName + "(username, productid, quantity, datepurchased, status, recipientname, contact,addressline1, addressline2, state, city, zip ,cardnumber, cardexpyear, cardexpmonth, cardcvv, trackingID, subtotal) VALUES"
                + "(?, ?, ?, CURRENT_DATE, 'PACKAGING', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String retrieveStr = "SELECT * FROM CART WHERE USERNAME = ?";
        String deleteStr = "DELETE FROM CART WHERE USERNAME = ? AND ID = ?";
        String updateStr = "UPDATE PRODUCT SET QUANTITY = QUANTITY - ? WHERE ID = ?";
        String priceStr = "SELECT PRICE FROM PRODUCT WHERE ID = ?";
        double price = 0;
        try {
            rstmt = conn.prepareStatement(retrieveStr);
            rstmt.setString(1, username);
            ResultSet rs = rstmt.executeQuery();
            while (rs.next()) {
                
                pstmt = conn.prepareStatement(priceStr);
                pstmt.setInt(1, rs.getInt("id"));
                ResultSet rss = pstmt.executeQuery();
                while (rss.next()) {
                    price = rss.getDouble("PRICE");
                }
                
                stmt = conn.prepareStatement(insertStr);
                stmt.setString(1, username);
                stmt.setInt(2, rs.getInt("id"));
                stmt.setInt(3, rs.getInt("quantity"));
                stmt.setString(4, recipient);
                stmt.setString(5, contact);
                stmt.setString(6, address1);
                stmt.setString(7, address2);
                stmt.setString(8, state);
                stmt.setString(9, city);
                stmt.setString(10, zipcode);
                stmt.setString(11, cardNumber);
                stmt.setString(12, cardExpYear);
                stmt.setString(13, cardExpMonth);
                stmt.setString(14, cardCVV);
                stmt.setString(15, trackingID);
                stmt.setDouble(16, price * rs.getInt("quantity"));
                stmt.executeUpdate();

                dstmt = conn.prepareStatement(deleteStr);
                dstmt.setString(1, username);
                dstmt.setInt(2, rs.getInt("id"));
                dstmt.executeUpdate();

                ustmt = conn.prepareStatement(updateStr);
                ustmt.setInt(1, rs.getInt("quantity"));
                ustmt.setInt(2, rs.getInt("id"));
                ustmt.executeUpdate();
            }

        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    public void updateRating(double rating, int id) {
        String updateStr = "UPDATE " + tableName + " SET RATING = ? WHERE ID = ?";
        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setDouble(1, rating);
            stmt.setInt(2, id);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void updateComment(double rating, String comment, int id) {
        String updateStr = "UPDATE " + tableName + " SET RATING = ?, COMMENT = ? WHERE ID = ?";
        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setDouble(1, rating);
            stmt.setString(2, comment);
            stmt.setInt(3, id);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void updateShipping(String id) {
        String updateStr = "UPDATE " + tableName + " SET STATUS = 'SHIPPING' WHERE TRACKINGID = ?";
        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, id);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void updateDelivered(String id) {
        String updateStr = "UPDATE " + tableName + " SET STATUS = 'DELIVERED' WHERE TRACKINGID = ?";
        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, id);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void updateReplyComment(int id, String replyComment) {
        String updateStr = "UPDATE " + tableName + " SET REPLYCOMMENT = ? WHERE ID = ?";
        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, replyComment);
            stmt.setInt(2, id);
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
        TransactionsDA da = new TransactionsDA();
    }
}
