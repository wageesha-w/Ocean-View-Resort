<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.OceanViewResort.Model.ReservationBean" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ocean View Resort | View Reservations</title>

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
   Card & Table
────────────────────────────── */
.card-box {
    background: #fff;
    padding: 30px;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
}

.table th {
    background: #fdf7ec;
    font-weight: 500;
}


/* ──────────────────────────────
   Status Badges
────────────────────────────── */
.status-badge {
    padding: 6px 14px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: 500;
}

.confirmed {
    background: #e7f3ff;
    color: #0d6efd;
}

.completed {
    background: #e8f8f0;
    color: #198754;
}

.cancelled {
    background: #fde8e8;
    color: #dc3545;
}


/* ──────────────────────────────
   Buttons
────────────────────────────── */
.btn-gold {
    background: #9E7F47;
    color: white;
}

.btn-gold:hover {
    background: #866a3c;
    color: white;
}


/* ──────────────────────────────
   Print Bill Modal
────────────────────────────── */
@media print {
    body * {
        visibility: hidden;
    }

    #printArea,
    #printArea * {
        visibility: visible;
    }

    #printArea {
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
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

<!-- Sidebar -->
<div class="sidebar">
    <img src="<%=request.getContextPath()%>/images/logo.png" class="resort-logo" alt="Logo">
    <a href="<%=request.getContextPath()%>/DashboardServlet"><span class="material-icons">dashboard</span> Dashboard</a>
    <a href="<%=request.getContextPath()%>/AddReservationServlet"><span class="material-icons">event_available</span> Add Reservations</a>
    <a href="<%=request.getContextPath()%>/ViewReservationServlet" class="active"><span class="material-icons">receipt_long</span> View Reservations</a>
    <a href="<%=request.getContextPath()%>/RoomManagementServlet"><span class="material-icons">meeting_room</span> Rooms Management</a>
    <a href="<%=request.getContextPath()%>/Views/Help.jsp"><span class="material-icons">support_agent</span> Help</a>
    <a href="#" data-bs-toggle="modal" data-bs-target="#logoutModal"><span class="material-icons">logout</span> Logout</a>
</div>

<!-- Content -->
<div class="content">

    <h2 class="dashboard-title">View Reservations</h2>
    <p class="dashboard-sub">Manage and track all guest reservations efficiently.</p>

    <%-- Action message --%>
    <% String msg = (String) request.getAttribute("message");
       if (msg != null) { %>
    <div class="alert alert-info alert-dismissible fade show">
        <%= msg %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>

    <div class="card-box">

        <!-- Search + Filter -->
        <form method="get" action="<%=request.getContextPath()%>/ViewReservationServlet" class="row mb-4">
            <div class="col-md-6 mb-2">
                <input type="text" name="search" class="form-control"
                       placeholder="Search by ID, Guest Name or Contact No."
                       value="<%= request.getAttribute("keyword") != null ? request.getAttribute("keyword") : "" %>">
            </div>
            <div class="col-md-3 mb-2">
                <select name="statusFilter" class="form-select">
                    <option value="All">All Statuses</option>
                    <% String sf = (String) request.getAttribute("statusFilter"); %>
                    <option value="Confirmed"  <%= "Confirmed".equals(sf)  ? "selected" : "" %>>Confirmed</option>
                    <option value="Completed"  <%= "Completed".equals(sf)  ? "selected" : "" %>>Completed</option>
                    <option value="Cancelled"  <%= "Cancelled".equals(sf)  ? "selected" : "" %>>Cancelled</option>
                </select>
            </div>
            <div class="col-md-2 mb-2">
                <button type="submit" class="btn btn-gold w-100">Search</button>
            </div>
            <div class="col-md-1 mb-2">
                <a href="<%=request.getContextPath()%>/ViewReservationServlet" class="btn btn-outline-secondary w-100">Clear</a>
            </div>
        </form>

        <!-- Reservation Table -->
        <div class="table-responsive">
            <table class="table align-middle">
                <thead>
                    <tr>
                        <th>Res. ID</th>
                        <th>Guest Name</th>
                        <th>Contact</th>
                        <th>Room Type</th>
                        <th>Room No.</th>
                        <th>Check-In</th>
                        <th>Check-Out</th>
                        <th>Status</th>
                        <th>Bill (LKR)</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<ReservationBean> reservations = (List<ReservationBean>) request.getAttribute("reservations");
                    if (reservations == null || reservations.isEmpty()) {
                %>
                    <tr><td colspan="10" class="text-center text-muted py-4">No reservations found.</td></tr>
                <%
                    } else {
                        for (ReservationBean r : reservations) {
                            String badgeClass = "confirmed";
                            if ("Completed".equals(r.getStatus()))  badgeClass = "completed";
                            if ("Cancelled".equals(r.getStatus()))  badgeClass = "cancelled";
                %>
                    <tr>
                        <td><strong>R<%= String.format("%04d", r.getReservationId()) %></strong></td>
                        <td><%= r.getGuestName() %></td>
                        <td><%= r.getContactNo() %></td>
                        <td><%= r.getRoomTypeName() %></td>
                        <td><%= r.getRoomNumber() %></td>
                        <td><%= r.getCheckIn() %></td>
                        <td><%= r.getCheckOut() %></td>
                        <td><span class="status-badge <%= badgeClass %>"><%= r.getStatus() %></span></td>
                        <td>
                            <% if ("Completed".equals(r.getStatus())) { %>
                                <%= String.format("%.2f", r.getTotalBill()) %>
                            <% } else { %> – <% } %>
                        </td>
                        <td>
                            <!-- Print Bill (only for Completed) -->
                            <% if ("Completed".equals(r.getStatus())) { %>
                            <button class="btn btn-sm btn-outline-dark mb-1"
                                    onclick="printBill(<%= r.getReservationId() %>,
                                                       '<%= r.getGuestName() %>',
                                                       '<%= r.getRoomTypeName() %>',
                                                       '<%= r.getRoomNumber() %>',
                                                       '<%= r.getCheckIn() %>',
                                                       '<%= r.getCheckOut() %>',
                                                       '<%= String.format("%.2f", r.getTotalBill()) %>')">
                                <span class="material-icons" style="font-size:15px;vertical-align:middle;">print</span> Print
                            </button>
                            <% } %>

                            <!-- Complete Stay -->
                            <% if ("Confirmed".equals(r.getStatus())) { %>
                            <form method="post" action="<%=request.getContextPath()%>/ViewReservationServlet" class="d-inline mb-1">
                                <input type="hidden" name="action" value="complete">
                                <input type="hidden" name="reservationId" value="<%= r.getReservationId() %>">
                                <button type="submit" class="btn btn-sm btn-success"
                                        onclick="return confirm('Mark this stay as completed?')">
                                    Complete
                                </button>
                            </form>

                            <!-- Cancel -->
                            <form method="post" action="<%=request.getContextPath()%>/ViewReservationServlet" class="d-inline">
                                <input type="hidden" name="action" value="cancel">
                                <input type="hidden" name="reservationId" value="<%= r.getReservationId() %>">
                                <button type="submit" class="btn btn-sm btn-danger"
                                        onclick="return confirm('Cancel this reservation?')">
                                    Cancel
                                </button>
                            </form>
                            <% } %>
                        </td>
                    </tr>
                <%      }
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- ══ Hidden Print Area ══════════════════════════════════════ -->
<div id="printArea" style="display:none; padding:40px; font-family:'Roboto',sans-serif;">
    <h2 style="color:#9E7F47; text-align:center;">Ocean View Resort</h2>
    <h4 style="text-align:center; color:#555;">Guest Invoice</h4>
    <hr>
    <table style="width:100%; font-size:15px;">
        <tr><td><strong>Reservation ID:</strong></td><td id="p-id"></td></tr>
        <tr><td><strong>Guest Name:</strong></td><td id="p-guest"></td></tr>
        <tr><td><strong>Room Type:</strong></td><td id="p-type"></td></tr>
        <tr><td><strong>Room No.:</strong></td><td id="p-room"></td></tr>
        <tr><td><strong>Check-in:</strong></td><td id="p-ci"></td></tr>
        <tr><td><strong>Check-out:</strong></td><td id="p-co"></td></tr>
    </table>
    <hr>
    <h4 style="text-align:right; color:#9E7F47;">Total Bill: LKR <span id="p-bill"></span></h4>
    <p style="text-align:center; color:#888; font-size:13px; margin-top:30px;">Thank you for staying at Ocean View Resort!</p>
</div>

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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
function printBill(id, guest, type, room, ci, co, bill) {
    document.getElementById('p-id').textContent    = 'R' + String(id).padStart(4,'0');
    document.getElementById('p-guest').textContent = guest;
    document.getElementById('p-type').textContent  = type;
    document.getElementById('p-room').textContent  = room;
    document.getElementById('p-ci').textContent    = ci;
    document.getElementById('p-co').textContent    = co;
    document.getElementById('p-bill').textContent  = bill;
    document.getElementById('printArea').style.display = 'block';
    window.print();
    document.getElementById('printArea').style.display = 'none';
}
</script>
</body>
</html>
