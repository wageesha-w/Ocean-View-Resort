package com.OceanViewResort.BeanTest;

import static org.junit.jupiter.api.Assertions.*;

import java.sql.Date;

import org.junit.jupiter.api.Test;

import com.OceanViewResort.Model.ReservationBean;

class ReservationBeanTest {

    @Test
    void testSettersAndGetters() {

        ReservationBean reservation = new ReservationBean();

        reservation.setReservationId(101);
        reservation.setGuestName("John Silva");
        reservation.setAddress("Colombo");
        reservation.setContactNo("0771234567");
        reservation.setEmail("john@gmail.com");
        reservation.setRoomId(5);
        reservation.setRoomTypeId(2);
        reservation.setRoomTypeName("Deluxe");
        reservation.setRoomNumber("A101");
        reservation.setCheckIn(Date.valueOf("2026-03-10"));
        reservation.setCheckOut(Date.valueOf("2026-03-12"));
        reservation.setReservationType("Advanced");
        reservation.setStatus("Confirmed");
        reservation.setTotalBill(25000.00);

        assertEquals(101, reservation.getReservationId());
        assertEquals("John Silva", reservation.getGuestName());
        assertEquals("Colombo", reservation.getAddress());
        assertEquals("0771234567", reservation.getContactNo());
        assertEquals("john@gmail.com", reservation.getEmail());
        assertEquals(5, reservation.getRoomId());
        assertEquals(2, reservation.getRoomTypeId());
        assertEquals("Deluxe", reservation.getRoomTypeName());
        assertEquals("A101", reservation.getRoomNumber());
        assertEquals(Date.valueOf("2026-03-10"), reservation.getCheckIn());
        assertEquals(Date.valueOf("2026-03-12"), reservation.getCheckOut());
        assertEquals("Advanced", reservation.getReservationType());
        assertEquals("Confirmed", reservation.getStatus());
        assertEquals(25000.00, reservation.getTotalBill());
    }
}