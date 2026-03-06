package com.OceanViewResort.Tests;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.OceanViewResort.Dao.AdminDAO;
import com.OceanViewResort.Model.AdminBean;

class AdminDAOTest {

    private AdminDAO adminDAO;

    @BeforeEach
    void setUp() {
        adminDAO = new AdminDAO();
    }

    // 1. Test valid login
    @Test
    void testValidateAdmin_ValidCredentials() {
        AdminBean admin = new AdminBean();
        admin.setUsername("admin");   
        admin.setPassword("admin123"); 
        boolean isValid = adminDAO.validateAdmin(admin);
        assertTrue(isValid, "Admin should be validated successfully");
        assertTrue(admin.getAdminId() > 0, "Admin ID should be set after login");
    }

    // 2. Test invalid login
    @Test
    void testValidateAdmin_InvalidCredentials() {
        AdminBean admin = new AdminBean();
        admin.setUsername("admin");
        admin.setPassword("wrongpassword");

        boolean isValid = adminDAO.validateAdmin(admin);
        assertFalse(isValid, "Admin login should fail for wrong credentials");
    }

    // 3. Test get admin by username (existing admin)
    @Test
    void testGetAdminByUsername_Existing() {
        String username = "admin"; 
        AdminBean admin = adminDAO.getAdminByUsername(username);
        assertNotNull(admin, "AdminBean should not be null");
        assertEquals(username, admin.getUsername(), "Username should match");
        assertTrue(admin.getAdminId() > 0, "Admin ID should be valid");
    }
}
