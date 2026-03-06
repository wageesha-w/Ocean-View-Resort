package com.OceanViewResort.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.OceanViewResort.Model.RoomBean;
import util.DBConnection;

public class RoomDAO {

    // ===============================
    // Add New Room
    // ===============================
    public boolean addRoom(String roomNumber, int roomTypeId) {

        boolean rowInserted = false;
        String sql = "INSERT INTO rooms (room_number, room_type_id) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, roomNumber);
            stmt.setInt(2, roomTypeId);

            rowInserted = stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rowInserted;
    }


    // ===============================
    // Get Rooms By Type
    // ===============================
    public List<RoomBean> getRoomsByType(int roomTypeId) {

        List<RoomBean> rooms = new ArrayList<>();
        String sql = "SELECT * FROM rooms WHERE room_type_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roomTypeId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                RoomBean room = new RoomBean();
                room.setRoomId(rs.getInt("room_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setRoomTypeId(rs.getInt("room_type_id"));
                room.setStatus(rs.getString("status"));

                rooms.add(room);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rooms;
    }


    // ===============================
    // Get Available Rooms
    // ===============================
    public List<RoomBean> getAvailableRooms(int roomTypeId, String checkIn, String checkOut) {

        List<RoomBean> rooms = new ArrayList<>();

        String sql = "SELECT * FROM rooms r " +
                     "WHERE r.room_type_id = ? " +
                     "AND r.status = 'Available' " +
                     "AND r.room_id NOT IN ( " +
                     "   SELECT room_id FROM reservations " +
                     "   WHERE status = 'Confirmed' " +
                     "   AND (? < check_out AND ? > check_in) " +
                     ")";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roomTypeId);
            ps.setString(2, checkIn);
            ps.setString(3, checkOut);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                RoomBean room = new RoomBean();
                room.setRoomId(rs.getInt("room_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setRoomTypeId(rs.getInt("room_type_id"));
                room.setStatus(rs.getString("status"));

                rooms.add(room);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rooms;
    }
}