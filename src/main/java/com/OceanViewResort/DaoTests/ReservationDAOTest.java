package com.OceanViewResort.DaoTests;

import static org.junit.jupiter.api.Assertions.*;
import java.sql.Date;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.OceanViewResort.Dao.ReservationDAO;
import com.OceanViewResort.Model.ReservationBean;

public class ReservationDAOTest {

    private ReservationDAO dao;

    @BeforeEach
    public void setUp() {
        dao = new ReservationDAO();
    }

 // 1. Test Add Reservation
    @Test
    public void testAddReservation() {
        ReservationBean reservation = new ReservationBean();
        reservation.setGuestName("Alice Smith");
        reservation.setAddress("123 Ocean View Street");
        reservation.setContactNo("0712345678");
        reservation.setEmail("alice@example.com");
        reservation.setRoomId(1);         
        reservation.setRoomTypeId(1);     
        reservation.setCheckIn(Date.valueOf("2026-03-10"));
        reservation.setCheckOut(Date.valueOf("2026-03-12"));
        reservation.setReservationType("Walk-in");
        reservation.setTotalBill(0.0);    

        boolean added = dao.addReservation(reservation);
        assertTrue(added, "Reservation should be added successfully");
    }

    // 2. Test Get All Reservations
    @Test
    public void testGetAllReservations() {
        List<ReservationBean> list = dao.getAllReservations();
        assertNotNull(list, "Should return a non-null list of reservations");
        assertTrue(list.size() > 0, "There should be at least one reservation");
    }

    // 3. Test Get Reservation by ID
    @Test
    public void testGetReservationById() {
        int reservationId = 1; // Use an existing reservation ID in DB
        ReservationBean r = dao.getReservationById(reservationId);
        assertNotNull(r, "Reservation should not be null");
        assertEquals(reservationId, r.getReservationId(), "Reservation ID should match");
    }

    // 4. Test Complete Stay and Bill Calculation
    @Test
    public void testCompleteStay() {
        int reservationId = 1; 
        boolean completed = dao.completeStay(reservationId);
        assertTrue(completed, "Reservation should be completed and bill calculated");

        ReservationBean r = dao.getReservationById(reservationId);
        assertEquals("Completed", r.getStatus(), "Status should be Completed");
        assertTrue(r.getTotalBill() > 0, "Total bill should be greater than 0");
    }

    // 5. Test Cancel Reservation
    @Test
    public void testCancelReservation() {
        int reservationId = 1; 
        boolean cancelled = dao.updateStatus(reservationId, "Cancelled");
        assertTrue(cancelled, "Reservation should be cancelled successfully");

        ReservationBean r = dao.getReservationById(reservationId);
        assertEquals("Cancelled", r.getStatus(), "Status should be Cancelled");
    }

    // 6. Test Search Reservations
    @Test
    public void testSearchReservations() {
        List<ReservationBean> results = dao.searchReservations("Alice");
        assertNotNull(results, "Search results should not be null");
        assertTrue(results.stream().anyMatch(r -> r.getGuestName().equals("Alice Smith")),
                   "Search should find Alice Smith");
    }

    // 7. Test Get Reservations by Status
    @Test
    public void testGetReservationsByStatus() {
        List<ReservationBean> confirmed = dao.getReservationsByStatus("Confirmed");
        assertNotNull(confirmed, "Filtered list should not be null");
        assertTrue(confirmed.stream().allMatch(r -> r.getStatus().equals("Confirmed")),
                   "All reservations should have status Confirmed");
    }

    // 8. Test Count By Status
    @Test
    public void testCountByStatus() {
        int total = dao.countByStatus(null);
        int confirmed = dao.countByStatus("Confirmed");
        assertTrue(total >= confirmed, "Total reservations should be >= confirmed");
    }

    // 9. Test Count Today's Check-Ins
    @Test
    public void testCountTodayCheckIns() {
        int todayCheckIns = dao.countTodayCheckIns();
        assertTrue(todayCheckIns >= 0, "Today's check-ins should be zero or more");
    }

    // 10. Test Total Revenue
    @Test
    public void testTotalRevenue() {
        double revenue = dao.getTotalRevenue();
        assertTrue(revenue >= 0, "Total revenue should be zero or more");
    }

    // 11. Test Get Recent N Reservations
    @Test
    public void testGetRecentReservations() {
        int limit = 3;
        List<ReservationBean> recent = dao.getRecentReservations(limit);
        assertNotNull(recent, "Recent reservations should not be null");
        assertTrue(recent.size() <= limit, "Should return at most " + limit + " reservations");
    }

    // 12. Test Calculate Bill
    @Test
    public void testCalculateBill() {
        Date checkIn = Date.valueOf("2026-03-10");
        Date checkOut = Date.valueOf("2026-03-12");
        int roomTypeId = 1;

        double bill = dao.calculateBill(checkIn, checkOut, roomTypeId);
        assertTrue(bill > 0, "Calculated bill should be greater than 0");
    }
}