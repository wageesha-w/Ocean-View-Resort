package com.OceanViewResort.Model;

import java.sql.Date;

public class ReservationBean {

    private int reservationId;
    private String guestName;
    private String address;
    private String contactNo;
    private String email;
	private int roomId;
    private int roomTypeId;
    private String roomTypeName;   // for display (joined from room_types)
    private String roomNumber;     // for display (joined from rooms)
    private Date checkIn;
    private Date checkOut;
    private String reservationType; // "Walk-in" or "Advanced"
    private String status;          // "Confirmed", "Completed", "Cancelled"
    private double totalBill;

    // ── Constructors ──────────────────────────────────────────
    public ReservationBean() {}

    // ── Getters & Setters ─────────────────────────────────────
    public int getReservationId() { return reservationId; }
    public void setReservationId(int reservationId) { this.reservationId = reservationId; }

    public String getGuestName() { return guestName; }
    public void setGuestName(String guestName) { this.guestName = guestName; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getContactNo() { return contactNo; }
    public void setContactNo(String contactNo) { this.contactNo = contactNo; }
    
    public String getEmail() {return email;}
	public void setEmail(String email) {this.email = email;}

    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }

    public int getRoomTypeId() { return roomTypeId; }
    public void setRoomTypeId(int roomTypeId) { this.roomTypeId = roomTypeId; }

    public String getRoomTypeName() { return roomTypeName; }
    public void setRoomTypeName(String roomTypeName) { this.roomTypeName = roomTypeName; }

    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }

    public Date getCheckIn() { return checkIn; }
    public void setCheckIn(Date checkIn) { this.checkIn = checkIn; }

    public Date getCheckOut() { return checkOut; }
    public void setCheckOut(Date checkOut) { this.checkOut = checkOut; }

    public String getReservationType() { return reservationType; }
    public void setReservationType(String reservationType) { this.reservationType = reservationType; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public double getTotalBill() { return totalBill; }
    public void setTotalBill(double totalBill) { this.totalBill = totalBill; }
}