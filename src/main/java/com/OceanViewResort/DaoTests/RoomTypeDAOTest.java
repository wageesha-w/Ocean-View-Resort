package com.OceanViewResort.DaoTests;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.OceanViewResort.Dao.RoomTypeDAO;
import com.OceanViewResort.Model.RoomTypeBean;

class RoomTypeDAOTest {

    private RoomTypeDAO roomTypeDAO;

    @BeforeEach
    void setUp() {
        roomTypeDAO = new RoomTypeDAO();
    }

    // 1. Test fetching all room types
    @Test
    void testGetAllRoomTypes() {
        List<RoomTypeBean> roomTypes = roomTypeDAO.getAllRoomTypes();
        assertNotNull(roomTypes, "Room types list should not be null");
        assertTrue(roomTypes.size() > 0, "There should be at least one room type");
    }

    // 2. Test updating room price
    @Test
    void testUpdatePrice() {
        int roomTypeId = 1; 
        double newPrice = 1500.0;

        boolean updated = roomTypeDAO.updatePrice(roomTypeId, newPrice);
        assertTrue(updated, "Room price should be updated successfully");

        List<RoomTypeBean> roomTypes = roomTypeDAO.getAllRoomTypes();
        RoomTypeBean updatedType = roomTypes.stream()
                .filter(rt -> rt.getRoomTypeId() == roomTypeId)
                .findFirst()
                .orElse(null);

        assertNotNull(updatedType, "Updated room type should exist");
        assertEquals(newPrice, updatedType.getPricePerNight(), 0.001, "Price should match the updated value");
    }
}






