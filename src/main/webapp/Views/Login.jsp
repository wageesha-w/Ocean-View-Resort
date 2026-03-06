<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ocean View Resort | Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <style>
        /* ===== Body & Background ===== */
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background: url('../images/resort-bg.png') no-repeat center center/cover;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;
            position: relative;
        }

        body::before {
            content: "";
            position: absolute;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.4);
            backdrop-filter: blur(1px);
            z-index: 0;
        }

        .login-card {
            position: relative;
            z-index: 1;
            width: 380px;
            padding: 40px;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(15px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.37);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: rgba(255, 255, 255);
            animation: fadeIn 1s ease-in-out;
            text-align: center;
        }

        .resort-logo {
            width: 250px;
            height: 250px;
            margin-top: -100px;
            margin-bottom: -60px;
        }

        .modern-input {
		    background: transparent;       /* completely transparent */
		    border: none;                  /* no border */
		    border-bottom: 2px solid rgba(255, 255, 255, 0.6); /* underline only */
		    border-radius: 50px;
		    color: #fff;                   /* text color */
		    padding-left: 10px;
		}
		
		.modern-input::placeholder {
		    color: rgba(255,255,255,0.7);
		}
		
		.modern-input:focus {
		    background: rgba(255, 255, 255, 0.1) !important;
		    color: #fff !important;
		    border-bottom: 2px solid rgba(255, 255, 255, 0.6) !important; 
		    box-shadow: none !important;
		}
		
		/* Remove Chrome autofill white background */
		input:-webkit-autofill,
		input:-webkit-autofill:hover,
		input:-webkit-autofill:focus,
		input:-webkit-autofill:active {
		    -webkit-box-shadow: 0 0 0 30px rgba(255, 255, 255, 0.1) inset !important;
		    -webkit-text-fill-color: #fff !important;
		    transition: background-color 5000s ease-in-out 0s;
		}

        .btn-modern {
            background: linear-gradient(135deg, #9E7F47, #7c550e);
            border: none;
            border-radius: 30px;
            padding: 10px;
            color:#fff;
            font-weight: 500;
            letter-spacing: 1.5px;
            transition: 0.3s ease;
            width: 100%;
        }

        .btn-modern:hover {
            transform: translateY(-3px);
            box-shadow: 0 0 15px rgba(113, 106, 14, 0.6);
        }


        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>

<body>
    <div class="login-card">

        <div class="logo">
		    <img src="<%=request.getContextPath()%>/images/logo.png"
		     class="resort-logo" alt="Logo">
		</div>

        <h3 class="mb-4">Admin Portal Access</h3>
        


        <form action="<%= request.getContextPath() %>/login" method="post">
            
            <div class="input-group mb-4">
                <span class="input-group-text bg-transparent border-0">
                    <i class="bi bi-person text-white"></i>
                </span>
                <input type="text" name="username" 
                       class="form-control modern-input" 
                       placeholder="Username" required>
            </div>

            <div class="input-group mb-4">
                <span class="input-group-text bg-transparent border-0">
                    <i class="bi bi-lock text-white"></i>
                </span>
                <input type="password" name="password" 
                       class="form-control modern-input" 
                       placeholder="Password" required>
            </div>

            <div class="d-flex justify-content-between mb-4 small text-light">
                <div>
                    <input type="checkbox" id="remember">
                    <label for="remember"> Remember me</label>
                </div>

            </div>

            <button type="submit" class="btn btn-modern">
                Sign In
            </button>
        </form>

    </div>

</body>
</html>