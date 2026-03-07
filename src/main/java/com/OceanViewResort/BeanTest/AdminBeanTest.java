package com.OceanViewResort.BeanTest;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import com.OceanViewResort.Model.AdminBean;

class AdminBeanTest {

    @Test
    void testAdminBeanConstructor() {
        AdminBean admin = new AdminBean("admin", "1234");

        assertEquals("admin", admin.getUsername());
        assertEquals("1234", admin.getPassword());
    }

    @Test
    void testSettersAndGetters() {
        AdminBean admin = new AdminBean();

        admin.setAdminId(1);
        admin.setUsername("adminUser");
        admin.setPassword("pass123");

        assertEquals(1, admin.getAdminId());
        assertEquals("adminUser", admin.getUsername());
        assertEquals("pass123", admin.getPassword());
    }
}



