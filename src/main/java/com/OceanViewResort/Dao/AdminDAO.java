	package com.OceanViewResort.Dao;
	
	import java.sql.Connection;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	
	import com.OceanViewResort.Model.AdminBean;
	import util.DBConnection;
	
	public class AdminDAO {
	
	    // LOGIN VALIDATION METHOD
	    public boolean validateAdmin(AdminBean admin) {
	
	        boolean isValid = false;
	
	        String sql = "SELECT admin_id FROM admin WHERE username = ? AND password = ?";
	
	        try (Connection con = DBConnection.getConnection();
	             PreparedStatement ps = con.prepareStatement(sql)) {
	
	            ps.setString(1, admin.getUsername());
	            ps.setString(2, admin.getPassword());
	
	            ResultSet rs = ps.executeQuery();
	
	            if (rs.next()) {
	                isValid = true;
	                admin.setAdminId(rs.getInt("admin_id")); 
	            }
	
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	
	        return isValid;
	    }
	
	
	    // GET ADMIN BY USERNAME (Optional – useful later)
	    public AdminBean getAdminByUsername(String username) {
	
	        AdminBean admin = null;
	
	        String sql = "SELECT * FROM admin WHERE username = ?";
	
	        try (Connection con = DBConnection.getConnection();
	             PreparedStatement ps = con.prepareStatement(sql)) {
	
	            ps.setString(1, username);
	
	            ResultSet rs = ps.executeQuery();
	
	            if (rs.next()) {
	
	                admin = new AdminBean();
	                admin.setAdminId(rs.getInt("admin_id"));
	                admin.setUsername(rs.getString("username"));
	                admin.setPassword(rs.getString("password"));
	            }
	
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	
	        return admin;
	    }
	
	}