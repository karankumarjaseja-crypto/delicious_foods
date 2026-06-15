package com.deliciousfoods.dao;

import com.deliciousfoods.model.User;
import com.deliciousfoods.util.DBConnection;
import com.deliciousfoods.util.PasswordUtil;
import java.sql.*;

public class UserDAO {
    public boolean register(String fullName, String email, String phone, String password) throws Exception {
        String sql = "INSERT INTO users(full_name,email,phone,password_hash,role) VALUES(?,?,?,?, 'USER')";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, PasswordUtil.hashPassword(password));
            return ps.executeUpdate() > 0;
        }
    }

    public User login(String email, String password) throws Exception {
        String sql = "SELECT id, full_name, email, phone, role FROM users WHERE email=? AND password_hash=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, PasswordUtil.hashPassword(password));
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("role")
                    );
                }
            }
        }
        return null;
    }
}
