<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.List" %>
<%@ page import="com.OceanViewResort.Model.RoomTypeBean" %>
<%@ page import="com.OceanViewResort.Dao.RoomTypeDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ocean View Resort | Rooms Management</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>

<style>

/* ============ BODY ============ */
body {
    font-family: 'Roboto', sans-serif;
    background: linear-gradient(135deg, #f8f6f2, #fdfcf9);
    color: #2c2c2c;
    margin: 0;
    overflow-x: hidden;
}

/* ============ SIDEBAR ============ */

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
    background: #ffffff;
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

/* ============ CONTENT ============ */
.content {
    margin-left: 250px;
    padding: 40px;
    min-height: 100vh;
    transition: 0.3s;
}

.dashboard-title {
    font-weight: 600;
    margin-bottom: 5px;
}

.dashboard-sub {
    color: #888;
    margin-bottom: 25px;
}

/* ============ ROOM MANAGEMENT UI ============ */
.manage-card {
    background: #ffffff;
    border-radius: 18px;
    padding: 30px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.05);
    margin-bottom: 30px;
}

.manage-card h5 {
    font-weight: 600;
    margin-bottom: 20px;
}

.icon-box {
    width: 48px;
    height: 48px;
    background: #fef6e8;
    color: #9E7F47;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 15px;
}

.btn-gold {
    background: #9E7F47;
    color: #fff;
    border-radius: 10px;
    padding: 8px 22px;
}

.btn-gold:hover {
    background: #866a3c;
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
    <a href="<%=request.getContextPath()%>/ViewReservationServlet"><span class="material-icons">receipt_long</span> View Reservations</a>
    <a href="<%=request.getContextPath()%>/RoomManagementServlet" class="active"><span class="material-icons">meeting_room</span> Rooms Management</a>
    <a href="<%=request.getContextPath()%>/Views/Help.jsp"><span class="material-icons">support_agent</span> Help</a>
    <a href="#" data-bs-toggle="modal" data-bs-target="#logoutModal"><span class="material-icons">logout</span> Logout</a>
</div>

<div class="content">

<h2 class="dashboard-title">Room Management</h2>
<p class="dashboard-sub">Manage room types, pricing, and availability at Ocean View Resort.</p>

<%
    String message = (String) request.getAttribute("message");
    if (message != null) {
%>
    <div class="alert alert-info alert-dismissible fade show" role="alert">
        <%= message %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%
    }
%>

<!-- Add New Room -->
<div class="manage-card">
    <div class="icon-box"><span class="material-icons">add_home</span></div>
    <h5>Add New Room</h5>

    <form method="post" action="<%=request.getContextPath()%>/RoomManagementServlet">
        <input type="hidden" name="action" value="addRoom">

        <div class="row">
            <div class="col-md-4 mb-3">
                <label class="form-label">Select Room Type</label>
                <select class="form-select" name="roomType">
                    <%
                        RoomTypeDAO dao = new RoomTypeDAO();
                        List<RoomTypeBean> roomTypes = dao.getAllRoomTypes();
                        for(RoomTypeBean rt : roomTypes){
                    %>
                        <option value="<%= rt.getRoomTypeId() %>"><%= rt.getTypeName() %></option>
                    <%
                        }
                    %>
                </select>
            </div>
            <div class="col-md-4 mb-3">
                <label class="form-label">Room No:</label>
                <input type="text" class="form-control" name="roomNumber" placeholder="101" required>
            </div>

        </div>

        <button type="submit" class="btn btn-gold mt-2">Add Room</button>
    </form>
</div>

<!-- Update Price -->
<div class="manage-card">
    <div class="icon-box"><span class="material-icons">price_change</span></div>
    <h5>Update Room Price</h5>

    <form method="post" action="<%=request.getContextPath()%>/RoomManagementServlet">
        <input type="hidden" name="action" value="updatePrice">

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Select Room Type</label>
                <select class="form-select" name="roomType">
                    <%
                        for(RoomTypeBean rt : roomTypes){
                    %>
                        <option value="<%= rt.getRoomTypeId() %>"><%= rt.getTypeName() %></option>
                    <%
                        }
                    %>
                </select>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">New Price</label>
                <input type="text" class="form-control" name="newPrice" placeholder="LKR 15000" required>
            </div>
        </div>

        <button type="submit" class="btn btn-gold">Update Price</button>
    </form>
</div>

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
</body>
</html>