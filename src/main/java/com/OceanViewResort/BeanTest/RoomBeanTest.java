package com.OceanViewResort.BeanTest;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import com.OceanViewResort.Model.RoomBean;

class RoomBeanTest {

    @Test
    void testSettersAndGetters() {
        RoomBean room = new RoomBean();

        room.setRoomId(10);
        room.setRoomNumber("B205");
        room.setRoomTypeId(3);
        room.setStatus("Available");

        assertEquals(10, room.getRoomId());
        assertEquals("B205", room.getRoomNumber());
        assertEquals(3, room.getRoomTypeId());
        assertEquals("Available", room.getStatus());
    }
}
