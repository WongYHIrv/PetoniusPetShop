/*
    Document : da/AccountDA
    Author   : rexko
*/

package da;

import domain.Account;
import java.sql.*;
import javax.swing.*;

public class AccountDA {

    private String host = "jdbc:derby://localhost:1527/pet";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Account";
    private Connection conn;
    private PreparedStatement stmt;

    public AccountDA() {
        createConnection();
    }

    // Add record
    public void addRecord(Account account) {
        String insertStr = "INSERT INTO " + tableName + "(FIRSTNAME, LASTNAME, USERNAME, EMAIL, PHONENUMBER, DOB, PASSWORD, POSITION, STATUS, IMAGE) VALUES"
                + "(?, ?, ?, ?, ?, ?, ?, 'C', '1', 'unknown.jpg')";
        java.sql.Date birthDate = new java.sql.Date(account.getDateOfBirth().getTime());
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, account.getFirstName());
            stmt.setString(2, account.getLastName());
            stmt.setString(3, account.getUsername());
            stmt.setString(4, account.getEmail());
            stmt.setString(5, account.getPhoneNumber());
            stmt.setDate(6, birthDate);
            stmt.setString(7, account.getPassword());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    // Username finder to prevent duplicate
    public int retrieveUsername(Account account) {
        String retrieveStr = "SELECT * FROM " + tableName + " WHERE USERNAME = ?";
        int found = 0;
        try {
            stmt = conn.prepareStatement(retrieveStr);
            stmt.setString(1, account.getUsername());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                found = 1;
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return found;
    }

    // Email finder to prevent duplicate
    public int retrieveEmail(Account account) {
        String retrieveStr = "SELECT * FROM " + tableName + " WHERE EMAIL = ?";
        int found = 0;
        try {
            stmt = conn.prepareStatement(retrieveStr);
            stmt.setString(1, account.getEmail());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                found = 1;
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return found;
    }

    // To verify the email belongs to the user
    public int retrieveEmailUser(Account account) {
        String retrieveStr = "SELECT * FROM " + tableName + " WHERE EMAIL = ? AND USERNAME = ?";
        int found = 0;
        try {
            stmt = conn.prepareStatement(retrieveStr);
            stmt.setString(1, account.getEmail());
            stmt.setString(2, account.getUsername());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                found = 1;
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return found;
    }
    
    // Validate login
    public int login(Account account) {
        String retrieveStr = "SELECT * FROM " + tableName + " WHERE username = ? AND password = ?";
        int found = 0;
        try {
            stmt = conn.prepareStatement(retrieveStr);
            stmt.setString(1, account.getUsername());
            stmt.setString(2, account.getPassword());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                found = 1;
                account.setFirstName(rs.getString("FIRSTNAME"));
                account.setLastName(rs.getString("LASTNAME"));
                account.setEmail(rs.getString("EMAIL"));
                account.setPhoneNumber(rs.getString("PHONENUMBER"));
                account.setStringDate(rs.getString("DOB"));
                account.setImage(rs.getString("IMAGE"));
                account.setStatus(rs.getString("STATUS"));
                account.setPosition(rs.getString("POSITION"));
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
        return found;
    }

    // Update profile
    public void updateProfile(Account account) {
        
        String updateStr = "UPDATE " + tableName + " set FIRSTNAME = ?, LASTNAME = ?, EMAIL = ?, PHONENUMBER = ? WHERE username = ?";
        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, account.getFirstName());
            stmt.setString(2, account.getLastName());
            stmt.setString(3, account.getEmail());
            stmt.setString(4, account.getPhoneNumber());
            stmt.setString(5, account.getUsername());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    public void updateProfileImage(String image, String username) {
        
        String updateStr = "UPDATE " + tableName + " set IMAGE = ? WHERE username = ?";
        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, image);
            stmt.setString(2, username);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    // Get role
    public String getRole(String username) {
        String getStr = "SELECT * FROM " + tableName + " WHERE USERNAME = ?";
        String role = "";
        try {
            stmt = conn.prepareStatement(getStr);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                role = rs.getString("POSITION");
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }    
        return role;
    }
    
    // Update user role
    public void updateRole(String username, String role) {
        String updateStr = "UPDATE " + tableName + " SET POSITION = ? WHERE USERNAME = ?";
        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, role);
            stmt.setString(2, username);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }

    // Ban user
    public void banUser(String username) {
        String updateStr = "UPDATE " + tableName + " SET STATUS = '0' WHERE USERNAME = ?";
        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, username);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    // Unban user
    public void unbanUser(String username) {
        String updateStr = "UPDATE " + tableName + " SET STATUS = '1' WHERE USERNAME = ?";
        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, username);
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
        AccountDA da = new AccountDA();
    }
}
