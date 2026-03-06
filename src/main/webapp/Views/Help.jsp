<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ocean View Resort | Help</title>

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

/* ============ HELP SECTION UI ============ */
.help-card {
    background: #ffffff;
    border-radius: 18px;
    padding: 25px 30px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.05);
    margin-bottom: 25px;
}

.help-card h5 {
    font-weight: 600;
    margin-bottom: 15px;
}

.help-card p {
    margin-bottom: 8px;
}

.icon-box {
    width: 50px;
    height: 50px;
    background: #fef6e8;
    color: #9E7F47;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 12px;
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
    <a href="<%=request.getContextPath()%>/RoomManagementServlet"><span class="material-icons">meeting_room</span> Rooms Management</a>
    <a href="<%=request.getContextPath()%>/Views/Help.jsp" class="active"><span class="material-icons">support_agent</span> Help</a>
    <a href="#" data-bs-toggle="modal" data-bs-target="#logoutModal"><span class="material-icons">logout</span> Logout</a>
</div>

<!-- Main Content -->
<div class="content">

<h2 class="dashboard-title">Help Section</h2>
<p class="dashboard-sub">
    Ocean View Resort Admin Dashboard – Guidance for Admin Operations.
</p>

<!-- How to Log in -->
<div class="help-card">
    <div class="icon-box"><span class="material-icons">login</span></div>
    <h5>How to Log In</h5>
    <p>1. Navigate to the login page.</p>
    <p>2. Enter your admin credentials.</p>
    <p>3. Click the login button to access the dashboard.</p>
</div>

<!-- How to Add a Reservation -->
<div class="help-card">
    <div class="icon-box"><span class="material-icons">event_available</span></div>
    <h5>How to Add a Reservation</h5>
    <p>1. When a guest arrives, collect their preferred room type, check-in, and check-out dates.</p>
    <p>2. Use the <strong>Check Availability</strong> option in the dashboard to confirm room availability.</p>
    <p>3. If available, go to <strong>Add Reservations</strong> and fill out the form.</p>
    <p>4. Save the reservation. Status will default to <strong>Confirmed</strong>.</p>
</div>

<!-- How to Generate a Bill -->
<div class="help-card">
    <div class="icon-box"><span class="material-icons">receipt_long</span></div>
    <h5>How to Generate a Bill</h5>
    <p>1. Go to <strong>View Reservations</strong>.</p>
    <p>2. Locate the reservation and click <strong>Complete Stay</strong>.</p>
    <p>3. Click the <strong>Print</strong> button to view the bill, calculated by number of nights × room rate.</p>
</div>

<!-- Contact IT Support -->
<div class="help-card">
    <div class="icon-box"><span class="material-icons">support_agent</span></div>
    <h5>Contact IT Support</h5>
    <p>If you encounter technical issues, contact IT support via phone or email provided in the dashboard.</p>
</div>

<!-- Staff Instructions -->
<div class="help-card">
    <div class="icon-box"><span class="material-icons">people_alt</span></div>
    <h5>Staff Instructions</h5>
    <p>Follow the application flow strictly:</p>
    <ul>
        <li>Guest arrives → Admin collects details → Check availability.</li>
        <li>If room available → Add Reservation → Confirmed status.</li>
        <li>Use View Reservations to manage, edit, or complete stay.</li>
        <li>Logout safely after session ends. Session will destroy and redirect to login page.</li>
    </ul>
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