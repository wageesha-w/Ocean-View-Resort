package com.OceanViewResort.BeanTest;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import com.OceanViewResort.Model.RoomTypeBean;

class RoomTypeBeanTest {

    @Test
    void testSettersAndGetters() {
        RoomTypeBean roomType = new RoomTypeBean();

        roomType.setRoomTypeId(1);
        roomType.setTypeName("Deluxe");
        roomType.setPricePerNight(12000.50);

        assertEquals(1, roomType.getRoomTypeId());
        assertEquals("Deluxe", roomType.getTypeName());
        assertEquals(12000.50, roomType.getPricePerNight());
    }
}