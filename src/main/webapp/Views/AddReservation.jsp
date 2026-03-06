<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.OceanViewResort.Model.RoomTypeBean" %>
<%@ page import="com.OceanViewResort.Model.RoomBean" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ocean View Resort | Add Reservation</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>

<style>

/* ──────────────────────────────
   Global Styles
────────────────────────────── */
body {
    font-family: 'Roboto', sans-serif;
    background: linear-gradient(135deg, #f8f6f2, #fdfcf9);
    color: #2c2c2c;
    margin: 0;
    overflow-x: hidden;
}

.resort-logo {
    width: 230px;
    height: auto;
    display: block;
    margin-top: -50px;
    margin-bottom: -40px;
}


/* ──────────────────────────────
   Sidebar
────────────────────────────── */
.sidebar {
    width: 250px;
    height: 100vh;
    background: #fff;
    border-right: 1px solid #eee;
    position: fixed;
    top: 0;
    left: 0;
    padding-top: 20px;
    overflow-y: auto;
    z-index: 1000;
}

.sidebar a {
    display: flex;
    align-items: center;
    color: #555;
    padding: 12px 20px;
    text-decoration: none;
    font-size: 15px;
    margin: 4px 12px;
    border-radius: 12px;
    transition: all 0.3s ease;
}

.sidebar a:hover,
.sidebar a.active {
    background: linear-gradient(90deg, #fef6e8, #fffaf0);
    color: #9E7F47;
    transform: translateX(5px);
}

.sidebar .material-icons {
    margin-right: 18px;
    font-size: 20px;
}


/* ──────────────────────────────
   Content
────────────────────────────── */
.content {
    margin-left: 250px;
    padding: 40px;
    min-height: 100vh;
}

.dashboard-title {
    font-weight: 600;
    margin-bottom: 5px;
}

.dashboard-sub {
    color: #888;
    margin-bottom: 25px;
}


/* ──────────────────────────────
   Step Cards
────────────────────────────── */
.step-card {
    background: #fff;
    border-radius: 20px;
    padding: 28px 30px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
    margin-bottom: 24px;
    border-left: 4px solid #9E7F47;
    transition: opacity 0.3s;
}

.step-title {
    font-weight: 600;
    font-size: 16px;
    color: #3a3a3a;
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}

.step-badge {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 30px;
    height: 30px;
    background: #9E7F47;
    color: #fff;
    border-radius: 50%;
    font-weight: 700;
    font-size: 14px;
    margin-right: 10px;
    flex-shrink: 0;
}

.step-badge.grey {
    background: #bbb;
}


/* ──────────────────────────────
   Form Inputs
────────────────────────────── */
.custom-input {
    width: 100%;
    border-radius: 12px;
    border: 1px solid #e6e0d6;
    padding: 10px 14px;
    transition: 0.3s ease;
}

.custom-input:focus {
    border-color: #9E7F47;
    box-shadow: 0 0 0 3px rgba(158, 127, 71, 0.15);
    outline: none;
}

.readonly-field {
    background: #f9f6f0 !important;
}


/* ──────────────────────────────
   Buttons
────────────────────────────── */
.btn-check-avail {
    background: #fff;
    color: #9E7F47;
    border: 2px solid #9E7F47;
    border-radius: 30px;
    padding: 9px 26px;
    font-weight: 600;
    transition: 0.3s;
    cursor: pointer;
}

.btn-check-avail:hover {
    background: #9E7F47;
    color: #fff;
}

.btn-save {
    background: linear-gradient(135deg, #9E7F47, #c8a96b);
    color: #fff;
    border: none;
    border-radius: 30px;
    padding: 11px 34px;
    font-weight: 600;
    font-size: 15px;
    transition: 0.3s ease;
    cursor: pointer;
}

.btn-save:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 28px rgba(158, 127, 71, 0.35);
    color: #fff;
}

.btn-save:disabled {
    background: #ccc;
    cursor: not-allowed;
    transform: none;
    box-shadow: none;
}

.btn-start-over {
    background: #f1f1f1;
    border: none;
    border-radius: 30px;
    padding: 11px 26px;
    color: #666;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 6px;
}

.btn-start-over:hover {
    background: #e6e6e6;
    color: #444;
}


/* ──────────────────────────────
   Status & Availability
────────────────────────────── */
.status-confirmed {
    background-color: #e9f5ec !important;
    color: #2e7d32 !important;
    font-weight: 600;
}

.avail-banner {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-top: 14px;
    padding: 12px 18px;
    border-radius: 12px;
    font-size: 14px;
    font-weight: 500;
}

.avail-ok {
    background: #e8f5e9;
    color: #2e7d32;
    border: 1px solid #a5d6a7;
}

.avail-none {
    background: #fdecea;
    color: #c62828;
    border: 1px solid #ef9a9a;
}

.avail-pending {
    background: #fff8e1;
    color: #e65100;
    border: 1px solid #ffe082;
}

</style>
</head>
<body>

<%-- ─── Resolve attributes once ─────────────────────────── --%>
<%
    List<RoomTypeBean> roomTypes   = (List<RoomTypeBean>) request.getAttribute("roomTypes");
    List<RoomBean>     availRooms  = (List<RoomBean>)     request.getAttribute("availableRooms");
    String  selCheckIn  = (String)  request.getAttribute("selectedCheckIn");
    String  selCheckOut = (String)  request.getAttribute("selectedCheckOut");
    Integer selRoomType = (Integer) request.getAttribute("selectedRoomType");

    // availState: "unchecked" | "available" | "none"
    String availState = "unchecked";
    if (availRooms != null) availState = availRooms.isEmpty() ? "none" : "available";
    boolean canSave = "available".equals(availState);
%>

<!-- Sidebar -->
<div class="sidebar">
    <img src="<%=request.getContextPath()%>/images/logo.png" class="resort-logo" alt="Logo">
    <a href="<%=request.getContextPath()%>/DashboardServlet"><span class="material-icons">dashboard</span> Dashboard</a>
    <a href="<%=request.getContextPath()%>/AddReservationServlet" class="active"><span class="material-icons">event_available</span> Add Reservations</a>
    <a href="<%=request.getContextPath()%>/ViewReservationServlet"><span class="material-icons">receipt_long</span> View Reservations</a>
    <a href="<%=request.getContextPath()%>/RoomManagementServlet"><span class="material-icons">meeting_room</span> Rooms Management</a>
    <a href="<%=request.getContextPath()%>/Views/Help.jsp"><span class="material-icons">support_agent</span> Help</a>
    <a href="<%=request.getContextPath()%>/logout"><span class="material-icons">logout</span> Logout</a>
</div>

<!-- Main Content -->
<div class="content">
    <h2 class="dashboard-title">Add Reservation</h2>
    <p class="dashboard-sub">Check room availability first, then fill in guest details to save.</p>

    <%-- Save result alert --%>
    <% String msg = (String) request.getAttribute("message");
       if (msg != null) { boolean ok = msg.startsWith("Reservation saved"); %>
    <div class="alert alert-<%= ok ? "success" : "danger" %> alert-dismissible fade show">
        <span class="material-icons align-middle me-1"><%= ok ? "check_circle" : "error" %></span>
        <%= msg %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>


    <!-- ══════════════════════════════════════════════════
         STEP 1 – Availability Check
    ══════════════════════════════════════════════════ -->
    <div class="step-card">
        <div class="step-title">
            <span class="step-badge">1</span> Check Room Availability
        </div>

        <form method="post" action="<%=request.getContextPath()%>/AddReservationServlet">
            <input type="hidden" name="action" value="loadRooms">
            <div class="row g-3 align-items-end">

                <div class="col-md-3">
                    <label class="form-label">Check-in Date <span class="text-danger">*</span></label>
                    <input type="date" name="checkIn" class="custom-input"
                           value="<%= selCheckIn  != null ? selCheckIn  : "" %>" required>
                </div>

                <div class="col-md-3">
                    <label class="form-label">Check-out Date <span class="text-danger">*</span></label>
                    <input type="date" name="checkOut" class="custom-input"
                           value="<%= selCheckOut != null ? selCheckOut : "" %>" required>
                </div>

                <div class="col-md-4">
                    <label class="form-label">Room Type <span class="text-danger">*</span></label>
                    <select name="roomType" class="form-select custom-input" required>
                        <option value="" disabled <%= selRoomType == null ? "selected" : "" %>>— Select Room Type —</option>
                        <%
                            if (roomTypes != null && !roomTypes.isEmpty()) {
                                for (RoomTypeBean rt : roomTypes) {
                                    boolean isSelected = (selRoomType != null && selRoomType == rt.getRoomTypeId());
                        %>
                            <option value="<%= rt.getRoomTypeId() %>" <%= isSelected ? "selected" : "" %>>
                                <%= rt.getTypeName() %> – LKR <%= String.format("%,.0f", rt.getPricePerNight()) %>/night
                            </option>
                        <% }
                           } else { %>
                            <option disabled>No room types found – check DB connection</option>
                        <% } %>
                    </select>
                </div>

                <div class="col-md-2">
                    <button type="submit" class="btn-check-avail w-100">
                        <span class="material-icons" style="font-size:17px;vertical-align:middle;">search</span> Check
                    </button>
                </div>
            </div>

            <!-- Availability banner -->
            <% if ("available".equals(availState)) { %>
                <div class="avail-banner avail-ok">
                    <span class="material-icons">check_circle</span>
                    <strong><%= availRooms.size() %> room(s) available</strong> for selected dates. Fill in guest details below and save.
                </div>
            <% } else if ("none".equals(availState)) { %>
                <div class="avail-banner avail-none">
                    <span class="material-icons">cancel</span>
                    No rooms available for the selected dates and type. Please try different dates.
                </div>
            <% } else { %>
                <div class="avail-banner avail-pending">
                    <span class="material-icons">info</span>
                    Select dates and room type above, then click <strong>Check</strong>.
                </div>
            <% } %>
        </form>
    </div>


    <!-- ══════════════════════════════════════════════════
         STEP 2 – Guest Details (always visible; locked until Step 1 done)
    ══════════════════════════════════════════════════ -->
    <div class="step-card" style="<%= !canSave ? "opacity:0.5; pointer-events:none;" : "" %>">
        <div class="step-title">
            <span class="step-badge <%= !canSave ? "grey" : "" %>">2</span>
            Guest Information
            <% if (!canSave) { %>
                <span class="ms-3 text-muted" style="font-size:13px; font-weight:400;">
                    — Complete Step 1 first to unlock this section
                </span>
            <% } %>
        </div>

        <form method="post" action="<%=request.getContextPath()%>/AddReservationServlet">
            <input type="hidden" name="checkIn"  value="<%= selCheckIn  != null ? selCheckIn  : "" %>">
            <input type="hidden" name="checkOut" value="<%= selCheckOut != null ? selCheckOut : "" %>">
            <input type="hidden" name="roomType" value="<%= selRoomType != null ? selRoomType : "" %>">

            <div class="row g-3">

                <!-- Auto ID -->
                <div class="col-md-4">
                    <label class="form-label">Reservation ID</label>
                    <input type="text" class="custom-input readonly-field" value="AUTO-GENERATED" readonly>
                </div>

                <!-- Status -->
                <div class="col-md-4">
                    <label class="form-label">Status</label>
                    <input type="text" class="custom-input status-confirmed" value="Confirmed" readonly>
                </div>

                <!-- Reservation Type -->
                <div class="col-md-4">
                    <label class="form-label">Reservation Type <span class="text-danger">*</span></label>
                    <select name="reservationType" class="form-select custom-input" required>
                        <option value="" selected disabled>Select Type</option>
                        <option value="Walk-in">Walk-in</option>
                        <option value="Advanced">Advanced</option>
                    </select>
                </div>

                <!-- Guest Name -->
                <div class="col-md-6">
                    <label class="form-label">Guest Name <span class="text-danger">*</span></label>
                    <input type="text" name="guestName" class="custom-input"
                           placeholder="Enter full name" required>
                </div>

                <!-- Contact No -->
                <div class="col-md-6">
                    <label class="form-label">Contact No. <span class="text-danger">*</span></label>
                    <input type="tel" name="contactNo" class="custom-input"
                           placeholder="+94 XX XXX XXXX" required>
                </div>
                
                <!-- Email -->
				<div class="col-md-6">
				    <label class="form-label">Email Address <span class="text-danger">*</span></label>
				    <input type="email" 
				           name="email" 
				           class="custom-input"
				           placeholder="example@gmail.com" 
				           required
				           pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
				           title="Enter a valid email address">
				</div>

                <!-- Address -->
                <div class="col-12">
                    <label class="form-label">Address</label>
                    <textarea name="address" class="custom-input" rows="2"
                              placeholder="Enter guest address"></textarea>
                </div>

                <!-- Room No dropdown -->
                <div class="col-md-4">
                    <label class="form-label">Room No. <span class="text-danger">*</span></label>
                    <select name="roomId" class="form-select custom-input" required>
                        <% if (!canSave) { %>
                            <option value="">— Check availability first —</option>
                        <% } else {
                               for (RoomBean rm : availRooms) { %>
                            <option value="<%= rm.getRoomId() %>">Room <%= rm.getRoomNumber() %></option>
                        <%     } } %>
                    </select>
                </div>

                <!-- Check-in (display only) -->
                <div class="col-md-4">
                    <label class="form-label">Check-in Date</label>
                    <input type="text" class="custom-input readonly-field"
                           value="<%= selCheckIn != null ? selCheckIn : "—" %>" readonly>
                </div>

                <!-- Check-out (display only) -->
                <div class="col-md-4">
                    <label class="form-label">Check-out Date</label>
                    <input type="text" class="custom-input readonly-field"
                           value="<%= selCheckOut != null ? selCheckOut : "—" %>" readonly>
                </div>

            </div>

            <hr style="border:none; border-top:1px dashed #e0d8cc; margin:24px 0 20px;">

            <div class="d-flex gap-3 align-items-center">
                <button type="submit" class="btn-save d-flex align-items-center gap-2"
                        <%= !canSave ? "disabled" : "" %>>
                    <span class="material-icons">save</span> Save Reservation
                </button>
                <a href="<%=request.getContextPath()%>/AddReservationServlet"
                   class="btn-start-over">
                    <span class="material-icons">refresh</span> Start Over
                </a>
            </div>

        </form>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
