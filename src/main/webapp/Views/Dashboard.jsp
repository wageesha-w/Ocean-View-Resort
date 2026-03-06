<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.OceanViewResort.Model.RoomBean" %>
<%@ page import="com.OceanViewResort.Model.RoomTypeBean" %>
<%@ page import="com.OceanViewResort.Model.ReservationBean" %>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Ocean View Resort | Admin Dashboard</title>

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


/* ──────────────────────────────
   Sidebar
────────────────────────────── */
.resort-logo {
    width: 230px;
    height: auto;
    display: block;
    margin-top: -50px;
    margin-bottom: -40px;
}

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
   Stat Cards
────────────────────────────── */
.stat-card {
    position: relative;
    border-radius: 20px;
    padding: 25px;
    background: rgba(255, 255, 255, 0.95);
    border: 1px solid rgba(158, 127, 71, 0.12);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
    transition: 0.3s ease;
    overflow: hidden;
}

.stat-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.09);
}

.stat-card::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    height: 4px;
    width: 100%;
    background: linear-gradient(to right, #9E7F47, #d6b980);
}

.stat-card .material-icons {
    font-size: 34px;
    color: #9E7F47;
}

.stat-card h5 {
    margin-top: 14px;
    font-size: 13px;
    color: #888;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.stat-card h3 {
    margin-top: 4px;
    font-size: 30px;
    font-weight: 700;
    color: #2c2c2c;
}

.stat-card .stat-sub {
    font-size: 12px;
    color: #aaa;
    margin-top: 2px;
}


/* Revenue Card Accent */
.stat-card.revenue::before {
    background: linear-gradient(to right, #2e7d32, #66bb6a);
}

.stat-card.revenue .material-icons {
    color: #2e7d32;
}

.stat-card.revenue h3 {
    color: #2e7d32;
}


/* ──────────────────────────────
   Availability Section
────────────────────────────── */
.availability-card {
    background: linear-gradient(135deg, #ffffff, #fdfaf4);
    border-radius: 25px;
    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.06);
    border: 1px solid rgba(158, 127, 71, 0.2);
}

.custom-input {
    border-radius: 12px;
    border: 1px solid #e6e0d6;
    padding: 10px 12px;
    transition: 0.3s ease;
}

.custom-input:focus {
    border-color: #9E7F47;
    box-shadow: 0 0 0 3px rgba(158, 127, 71, 0.15);
}

.btn-availability {
    background: linear-gradient(135deg, #9E7F47, #c8a96b);
    border: none;
    border-radius: 30px;
    padding: 10px 24px;
    font-weight: 500;
    color: #fff;
    transition: 0.3s ease;
}

.btn-availability:hover {
    transform: scale(1.04);
    box-shadow: 0 10px 25px rgba(158, 127, 71, 0.3);
    color: #fff;
}


/* ──────────────────────────────
   Tables
────────────────────────────── */
.table-section {
    margin-top: 40px;
}

.table-wrapper {
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.05);
    overflow-x: auto;
}

.table {
    min-width: 700px;
}

.table thead {
    background: linear-gradient(to right, #f8f4ec, #fdfbf7);
}

.table th {
    border: none;
    padding: 15px 16px;
    font-size: 13px;
    color: #6b5c3e;
    font-weight: 600;
}

.table td {
    padding: 14px 16px;
    border-top: 1px solid #f5f5f5;
    font-size: 14px;
}

.table tbody tr:hover {
    background: #fcf8f2;
}


/* Status Badges */
.badge-confirmed,
.badge-completed,
.badge-cancelled {
    padding: 5px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 500;
}

.badge-confirmed {
    background: #e7f3ff;
    color: #0d6efd;
}

.badge-completed {
    background: #e8f5e9;
    color: #2e7d32;
}

.badge-cancelled {
    background: #fde8e8;
    color: #dc3545;
}


/* Buttons */
.btn-gold {
    background: linear-gradient(135deg, #9E7F47, #c8a96b);
    border: none;
    border-radius: 20px;
    padding: 5px 16px;
    font-size: 13px;
    color: white;
}

.btn-gold:hover {
    opacity: 0.9;
    color: white;
}


/* ──────────────────────────────
   Responsive
────────────────────────────── */
@media (max-width: 991px) {
    .sidebar {
        width: 200px;
    }

    .content {
        margin-left: 200px;
        padding: 25px;
    }
}

@media (max-width: 768px) {
    .sidebar {
        position: relative;
        width: 100%;
        height: auto;
    }

    .content {
        margin-left: 0;
        padding: 20px;
    }
}


/* ──────────────────────────────
   Modal Glass Effect
────────────────────────────── */
.modal {
    backdrop-filter: blur(8px);
}

.glass-modal {
    background: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border-radius: 20px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
}

.modal-content {
    animation: fadeZoom 0.3s ease-in-out;
}

@keyframes fadeZoom {
    from {
        transform: scale(0.8);
        opacity: 0;
    }
    to {
        transform: scale(1);
        opacity: 1;
    }
}

</style>
</head>
<body>

<%-- Resolve stats set by DashboardServlet --%>
<%
    Integer totalRes   = (Integer) request.getAttribute("totalReservations");
    Integer activeBook = (Integer) request.getAttribute("activeBookings");
    Integer todayCI    = (Integer) request.getAttribute("todayCheckIns");
    Double  revenue    = (Double)  request.getAttribute("totalRevenue");

    if (totalRes   == null) totalRes   = 0;
    if (activeBook == null) activeBook = 0;
    if (todayCI    == null) todayCI    = 0;
    if (revenue    == null) revenue    = 0.0;
%>

<!-- Sidebar -->
<div class="sidebar">
    <img src="<%=request.getContextPath()%>/images/logo.png" class="resort-logo" alt="Logo">
    <a href="<%=request.getContextPath()%>/DashboardServlet" class="active"><span class="material-icons">dashboard</span> Dashboard</a>
    <a href="<%=request.getContextPath()%>/AddReservationServlet"><span class="material-icons">event_available</span> Add Reservations</a>
    <a href="<%=request.getContextPath()%>/ViewReservationServlet"><span class="material-icons">receipt_long</span> View Reservations</a>
    <a href="<%=request.getContextPath()%>/RoomManagementServlet"><span class="material-icons">meeting_room</span> Rooms Management</a>
    <a href="<%=request.getContextPath()%>/Views/Help.jsp"><span class="material-icons">support_agent</span> Help</a>
    <a href="#" data-bs-toggle="modal" data-bs-target="#logoutModal"><span class="material-icons">logout</span> Logout</a>
</div>

<!-- Main Content -->
<div class="content">

    <h2 class="dashboard-title">Admin Dashboard</h2>
    <p class="dashboard-sub">Welcome back. Here's what's happening at Ocean View Resort.</p>

    <!-- ══ Stat Cards ══════════════════════════════════════════ -->
    <div class="row g-4">

        <!-- Total Reservations -->
        <div class="col-md-3">
            <div class="stat-card text-center">
                <span class="material-icons">hotel</span>
                <h5>Total Reservations</h5>
                <h3><%= totalRes %></h3>
                <div class="stat-sub">All time</div>
            </div>
        </div>

        <!-- Active Bookings -->
        <div class="col-md-3">
            <div class="stat-card text-center">
                <span class="material-icons">event_available</span>
                <h5>Active Bookings</h5>
                <h3><%= activeBook %></h3>
                <div class="stat-sub">Confirmed</div>
            </div>
        </div>

        <!-- Today's Check-ins -->
        <div class="col-md-3">
            <div class="stat-card text-center">
                <span class="material-icons">today</span>
                <h5>Today's Check-ins</h5>
                <h3><%= todayCI %></h3>
                <div class="stat-sub">Arriving today</div>
            </div>
        </div>

        <!-- Total Revenue -->
        <div class="col-md-3">
            <div class="stat-card revenue text-center">
                <span class="material-icons">payments</span>
                <h5>Total Revenue</h5>
                <h3>
                    <%
                        // Format: 1,250,000 → 1.25M  or just plain LKR
                        if (revenue >= 1_000_000) {
                    %>LKR <%= String.format("%.2fM", revenue / 1_000_000) %><%
                        } else {
                    %>LKR <%= String.format("%,.0f", revenue) %><%
                        }
                    %>
                </h3>
                <div class="stat-sub">From completed stays</div>
            </div>
        </div>

    </div>



    <!-- ══ Recent Reservations ══════════════════════════════════ -->
    <div class="table-section">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4 class="mb-0">Recent Reservations</h4>
            <a href="<%=request.getContextPath()%>/ViewReservationServlet"
               class="btn btn-gold btn-sm">View All</a>
        </div>
        <div class="table-wrapper">
            <table class="table mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Guest</th>
                        <th>Room</th>
                        <th>Check-In</th>
                        <th>Check-Out</th>
                        <th>Status</th>
                        <th>Bill (LKR)</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<ReservationBean> recent =
                        (List<ReservationBean>) request.getAttribute("recentReservations");
                    if (recent == null || recent.isEmpty()) {
                %>
                    <tr>
                        <td colspan="7" class="text-center text-muted py-4">No reservations yet.</td>
                    </tr>
                <%
                    } else {
                        for (ReservationBean res : recent) {
                            String badge = "badge-confirmed";
                            if ("Completed".equals(res.getStatus())) badge = "badge-completed";
                            if ("Cancelled".equals(res.getStatus())) badge = "badge-cancelled";
                %>
                    <tr>
                        <td><strong>R<%= String.format("%04d", res.getReservationId()) %></strong></td>
                        <td><%= res.getGuestName() %></td>
                        <td><%= res.getRoomNumber() %> – <%= res.getRoomTypeName() %></td>
                        <td><%= res.getCheckIn() %></td>
                        <td><%= res.getCheckOut() %></td>
                        <td><span class="<%= badge %>"><%= res.getStatus() %></span></td>
                        <td>
                            <% if ("Completed".equals(res.getStatus())) { %>
                                <%= String.format("%,.0f", res.getTotalBill()) %>
                            <% } else { %> — <% } %>
                        </td>
                    </tr>
                <%      }
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

</div><!-- end .content -->

		<!-- Logout Confirmation Modal -->
			<div class="modal fade" id="logoutModal" tabindex="-1">
			  <div class="modal-dialog modal-dialog-centered">
			    <div class="modal-content glass-modal border-0">
			
			      <div class="modal-header border-0">
			        <h5 class="modal-title text-white fw-bold">
			          Confirm Logout
			        </h5>
			        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
			      </div>
			
			      <div class="modal-body text-center text-white">
			        <p class="fs-5">Are you sure you want to logout?</p>
			      </div>
			
			      <div class="modal-footer border-0 justify-content-center">
			        <button type="button" class="btn btn-light px-4" data-bs-dismiss="modal">
			          Cancel
			        </button>
			
			        <a href="<%=request.getContextPath()%>/logout" 
			           class="btn btn-danger px-4">
			          Yes, Logout
			        </a>
			      </div>
			
			    </div>
			  </div>
			</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
