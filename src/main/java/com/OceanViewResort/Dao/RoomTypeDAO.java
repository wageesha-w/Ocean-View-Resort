package com.OceanViewResort.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.OceanViewResort.Model.RoomTypeBean;

import util.DBConnection;

public class RoomTypeDAO {


    public List<RoomTypeBean> getAllRoomTypes() {
        List<RoomTypeBean> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM room_types");
             ResultSet rs = ps.executeQuery()) {
             
            while (rs.next()) {
                RoomTypeBean roomType = new RoomTypeBean();
                roomType.setRoomTypeId(rs.getInt("room_type_id"));
                roomType.setTypeName(rs.getString("type_name"));
                roomType.setPricePerNight(rs.getDouble("price_per_night"));
                list.add(roomType);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updatePrice(int roomTypeId, double newPrice) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "UPDATE room_types SET price_per_night=? WHERE room_type_id=?")) {
            ps.setDouble(1, newPrice);
            ps.setInt(2, roomTypeId);
            int updated = ps.executeUpdate();
            return updated > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}