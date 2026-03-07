package com.OceanViewResort.Dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.OceanViewResort.Model.ReservationBean;
import util.DBConnection;

public class ReservationDAO {

    // 1. ADD NEW RESERVATION
    public boolean addReservation(ReservationBean r) {
    	String sql = "INSERT INTO reservations "
    	           + "(guest_name, address, contact_no, email, room_id, room_type_id, "
    	           + " check_in, check_out, reservation_type, status, total_bill) "
    	           + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'Confirmed', ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
        	ps.setString(1, r.getGuestName());
        	ps.setString(2, r.getAddress());
        	ps.setString(3, r.getContactNo());
        	ps.setString(4, r.getEmail());
        	ps.setInt(5,    r.getRoomId());
        	ps.setInt(6,    r.getRoomTypeId());
        	ps.setDate(7,   r.getCheckIn());
        	ps.setDate(8,   r.getCheckOut());
        	ps.setString(9, r.getReservationType());
        	ps.setDouble(10, r.getTotalBill());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // 2. GET ALL RESERVATIONS
    public List<ReservationBean> getAllReservations() {
        List<ReservationBean> list = new ArrayList<>();
        String sql = "SELECT res.*, ro.room_number, rt.type_name "
                   + "FROM reservations res "
                   + "JOIN rooms ro ON res.room_id = ro.room_id "
                   + "JOIN room_types rt ON res.room_type_id = rt.room_type_id "
                   + "ORDER BY res.reservation_id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 3. GET BY ID
    public ReservationBean getReservationById(int id) {
        String sql = "SELECT res.*, ro.room_number, rt.type_name "
                   + "FROM reservations res "
                   + "JOIN rooms ro ON res.room_id = ro.room_id "
                   + "JOIN room_types rt ON res.room_type_id = rt.room_type_id "
                   + "WHERE res.reservation_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // 4. UPDATE STATUS
    public boolean updateStatus(int reservationId, String newStatus) {
        String sql = "UPDATE reservations SET status = ? WHERE reservation_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, reservationId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // 5. COMPLETE STAY  (Confirmed → Completed + compute bill)
    public boolean completeStay(int reservationId) {
        ReservationBean r = getReservationById(reservationId);
        if (r == null) return false;
        double bill = calculateBill(r.getCheckIn(), r.getCheckOut(), r.getRoomTypeId());
        String sql = "UPDATE reservations SET status='Completed', total_bill=? WHERE reservation_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, bill);
            ps.setInt(2, reservationId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // 6. CALCULATE BILL  (nights × price_per_night)
    public double calculateBill(Date checkIn, Date checkOut, int roomTypeId) {
        long nights = (checkOut.getTime() - checkIn.getTime()) / (1000L * 60 * 60 * 24);
        if (nights <= 0) nights = 1;
        return nights * getPricePerNight(roomTypeId);
    }

    private double getPricePerNight(int roomTypeId) {
        String sql = "SELECT price_per_night FROM room_types WHERE room_type_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomTypeId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getDouble("price_per_night");
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // 7. SEARCH
    public List<ReservationBean> searchReservations(String keyword) {
        List<ReservationBean> list = new ArrayList<>();
        String sql = "SELECT res.*, ro.room_number, rt.type_name "
                + "FROM reservations res "
                + "JOIN rooms ro ON res.room_id = ro.room_id "
                + "JOIN room_types rt ON res.room_type_id = rt.room_type_id "
                + "WHERE res.guest_name LIKE ? OR res.contact_no LIKE ? "
                + "   OR res.email LIKE ? "
                + "   OR CAST(res.reservation_id AS CHAR) LIKE ? "
                + "ORDER BY res.reservation_id DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String kw = "%" + keyword + "%";
            ps.setString(1, kw);
            ps.setString(2, kw);
            ps.setString(3, kw);
            ps.setString(4, kw);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 8. FILTER BY STATUS
    public List<ReservationBean> getReservationsByStatus(String status) {
        List<ReservationBean> list = new ArrayList<>();
        String sql = "SELECT res.*, ro.room_number, rt.type_name "
                   + "FROM reservations res "
                   + "JOIN rooms ro ON res.room_id = ro.room_id "
                   + "JOIN room_types rt ON res.room_type_id = rt.room_type_id "
                   + "WHERE res.status = ? ORDER BY res.reservation_id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 9. COUNT BY STATUS  ← NEW  (null = all)
    public int countByStatus(String status) {
        String sql = (status == null)
            ? "SELECT COUNT(*) FROM reservations"
            : "SELECT COUNT(*) FROM reservations WHERE status = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (status != null) ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // 10. COUNT TODAY'S CHECK-INS  
    public int countTodayCheckIns() {
        String sql = "SELECT COUNT(*) FROM reservations "
                   + "WHERE check_in = CURDATE() AND status = 'Confirmed'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // 11. TOTAL REVENUE  
    public double getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(total_bill), 0) FROM reservations "
                   + "WHERE status = 'Completed'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // 12. GET RECENT N RESERVATIONS 
    public List<ReservationBean> getRecentReservations(int limit) {
        List<ReservationBean> list = new ArrayList<>();
        String sql = "SELECT res.*, ro.room_number, rt.type_name "
                   + "FROM reservations res "
                   + "JOIN rooms ro ON res.room_id = ro.room_id "
                   + "JOIN room_types rt ON res.room_type_id = rt.room_type_id "
                   + "ORDER BY res.reservation_id DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // PRIVATE – map row → bean
    private ReservationBean mapRow(ResultSet rs) throws Exception {
        ReservationBean r = new ReservationBean();
        r.setReservationId(rs.getInt("reservation_id"));
        r.setGuestName(rs.getString("guest_name"));
        r.setAddress(rs.getString("address"));
        r.setContactNo(rs.getString("contact_no"));
        r.setEmail(rs.getString("email"));
        r.setRoomId(rs.getInt("room_id"));
        r.setRoomTypeId(rs.getInt("room_type_id"));
        r.setRoomTypeName(rs.getString("type_name"));
        r.setRoomNumber(rs.getString("room_number"));
        r.setCheckIn(rs.getDate("check_in"));
        r.setCheckOut(rs.getDate("check_out"));
        r.setReservationType(rs.getString("reservation_type"));
        r.setStatus(rs.getString("status"));
        r.setTotalBill(rs.getDouble("total_bill"));
        return r;
    }
}