package com.OceanViewResort.DaoTests;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.OceanViewResort.Dao.RoomDAO;
import com.OceanViewResort.Model.RoomBean;

class RoomDAOTest {

    private RoomDAO roomDAO;

    @BeforeEach
    void setUp() {
        roomDAO = new RoomDAO();
    }

    // 1. Test adding a new room
    @Test
    void testAddRoom() {
        String roomNumber = "101A";
        int roomTypeId = 1; // Make sure this type exists in DB

        boolean added = roomDAO.addRoom(roomNumber, roomTypeId);
        assertTrue(added, "Room should be added successfully");
    }

    // 2. Test fetching rooms by type
    @Test
    void testGetRoomsByType() {
        int roomTypeId = 1; // Make sure this type exists in DB

        List<RoomBean> rooms = roomDAO.getRoomsByType(roomTypeId);
        assertNotNull(rooms, "Rooms list should not be null");
        assertTrue(rooms.size() > 0, "There should be at least one room for this type");
    }

    // 3. Test fetching available rooms
    @Test
    void testGetAvailableRooms() {
        int roomTypeId = 1; 
        String checkIn = "2026-03-10"; 
        String checkOut = "2026-03-12";

        List<RoomBean> availableRooms = roomDAO.getAvailableRooms(roomTypeId, checkIn, checkOut);
        assertNotNull(availableRooms, "Available rooms list should not be null");
        assertTrue(availableRooms.size() >= 0, "Available rooms size should be >= 0");
    }
}


