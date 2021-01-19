<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<title>Settings</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://www.w3schools.com/lib/w3-theme-black.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
html, body {
  height: 100%;
}
body {
  display: flex;
  flex-direction: column;
}
.content {
  flex: 1 0 auto;
}
.footer {
  flex-shrink: 0;
}

.fa-gear {
	font-size: 200px;
	color: teal;
}

.fa-x {
	font-size: 15px;
}

.center {
	display: block;
	margin-left: auto;
	margin-right: auto;
	width: 50%;
}
</style>
<body id="myPage">

<div class="content">

	<%
		String username = null;
		if (session.getAttribute("username") == null) {
			response.sendRedirect("login.jsp");
		} else {
			username = (String) session.getAttribute("username");
		}
		String userName = null;
		String sessionID = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("username"))
					userName = cookie.getValue();
				if (cookie.getName().equals("JSESSIONID"))
					sessionID = cookie.getValue();
			}
		}

		String email = (String) request.getAttribute("email");
		String state = (String) request.getAttribute("state");
		if (state == null) {
			state = "no-action";
		}
	%>

	<!-- Navbar -->
	<div class="w3-top">
		<div class="w3-bar w3-theme-d2 w3-left-align">
		<a href="home.jsp"
				class="w3-bar-item w3-button"style="padding:0px ;" ><img id="logo-img" src="logo1.png" style="height:38px;" onmouseover="hover(this);" onmouseout="unhover(this);" /></a>
		
			<a class="w3-bar-item w3-button w3-hide-medium w3-hide-large   w3-theme-d2"
				href="javascript:void(0);" onclick="openNav()"><i
				class="fa fa-caret-down"></i></a>
			<form action="GetAllLists" method="post">
				<button class="w3-bar-item w3-button w3-hide-small  "
					type="submit">My Lists</button>
			</form>
			<a href="games.html"
				class="w3-bar-item w3-button w3-hide-small  ">Games</a>
			<form action="GetCommunitycategories" method="post">
				<button class="w3-bar-item w3-button w3-hide-small  "
					type="submit">Community</button>
			</form>
			<div class="w3-dropdown-hover w3-teal">
				<button class="w3-button" title="Notifications"
					style="position: absolute; top: 0px; right: 0px">
					Profile <i class="fa fa-caret-down"></i>
				</button>
				<div class="w3-dropdown-content w3-card-4 w3-bar-block"
					style="position: absolute; top: 39px; right: 0px">
					<a href="FunctionsForSettings" class="w3-bar-item w3-button w3-teal">Settings</a>
					<form action="LogOutUser" method="post">
						<button class="w3-bar-item w3-button" type="submit">Log
							Out</button>
					</form>
				</div>
			</div>
		</div>

		<!-- Navbar on small screens -->
		<div id="navDemo"
			class="w3-bar-block w3-theme-d2 w3-hide w3-hide-large w3-hide-medium">
			<form action="GetAllLists" method="post">
				<button class="w3-bar-item w3-button"
					type="submit">My Lists</button>
			</form> 
			<a	href="games.html"
				class="w3-bar-item w3-button">Games</a>
			<form action="GetCommunitycategories" method="post">
				<button class="w3-bar-item w3-button"
					type="submit">Community</button>
			</form>
			
		</div>
	</div>



	<!-- Contact Container -->
	<div class="w3-container w3-padding-64 w3-theme-l5" id="contact">
		<div class="w3-row">
			<div class="w3-col m5">
				<i class="fa fa-gear center"></i>
			</div>
			<div class="w3-col m7">
				<form class="w3-container w3-card-4 w3-padding-16 w3-white"
					action="FunctionsForSettings" method="post">
					<div class="w3-section">
						<%
							if (state.equals("username-fail")) {
						%>
						<label style="color: red">This username is already taken!</label><br>
						<%
							} else if (state.equals("username-success")) {
						%>
						<label style="color: green">Username updated successfully!</label><br>
						<%
							}
						%>
						<label><b>Username:</b> <%=username%></label> <input
							class="w3-input" type="text" name="newUsername"
							placeholder="Enter new username..." required>
					</div>
					<input type="hidden" name="change" value="username">
					<button type="submit" class="w3-button  w3-theme ">save</button>
				</form>

				<form class="w3-container w3-card-4 w3-padding-16 w3-white"
					action="FunctionsForSettings" method="post">
					<div class="w3-section">
						<%
							if (state.equals("email-fail")) {
						%>
						<label style="color: red">There is another account
							registered with this email.</label><br>
						<%
							} else if (state.equals("email-success")) {
						%>
						<label style="color: green">Password updated successfully!</label><br>
						<%
							}
						%>
						<label><b>Email:</b> <%=email%></label> <input class="w3-input"
							type="text" name="newEmail" placeholder="Enter new email..."
							required>
					</div>
					<input type="hidden" name="change" value="email">
					<button type="submit" class="w3-button  w3-theme ">save</button>
				</form>

				<form class="w3-container w3-card-4 w3-padding-16 w3-white"
					action="FunctionsForSettings" method="post">
					<div class="w3-section">
						<%
							if (state.equals("password-fail")) {
						%>
						<label style="color: red">Wrong Password!</label><br>
						<%
							} else if (state.equals("password-success")) {
						%>
						<label style="color: green">Password updated successfully!</label><br>
						<%
							}
						%>
						<label><b>Password</b></label> <input class="w3-input" type="text"
							name="oldPassword" placeholder="Enter old password..." required>
						<input class="w3-input" type="text" name="newPassword"
							placeholder="Enter new password..." required>
					</div>
					<input type="hidden" name="change" value="password">
					<button type="submit" class="w3-button  w3-theme ">save</button>
				</form>

				<form class="w3-container w3-card-4 w3-padding-16 w3-white"
					action="FunctionsForSettings" method="post">

					<div class="w3-section">
						<%
							if (state.equals("delete-wrong-password")) {
						%>
						<label style="color: red">Wrong Password!</label><br>
						<%
							} else if (state.equals("delete-db_fail")) {
						%>
						<label style="color: red">Something went wrong. Try again.</label><br>
						<%
							}
						%>
						<label><b>Do you want to delete your account?</b></label>
					</div>
					<a style="color: red">All created data will be permanently deleted! This is an
						irreversible action that can not be undone! </a> <input
						class="w3-input" type="text" name="password"
						placeholder="Password required for this action..." required><br>
					<input type="hidden" name="change" value="delete-account">
					<button type="submit" class="w3-button  w3-theme ">
						<i class="fa fa-x"></i> Delete Account
					</button>
				</form>

			</div>
		</div>
	</div>




</div>

	<!-- Footer -->
	<footer class="footer w3-container w3-padding-32 w3-theme-d1 w3-center">
		<h4 class="center">Contact</h4>
		<div class="center">
			<a class="w3-button w3-large w3-teal" href="javascript:void(0)" title="Facebook">
				<i class="fa fa-facebook"></i>
			</a>
			<a class="w3-button w3-large w3-teal" href="javascript:void(0)" title="Google +">
				<i class="fa fa-instagram"></i>
			</a>
			<a class="w3-button w3-large w3-teal w3-hide-small" href="javascript:void(0)" title="Linkedin">
				<i class="fa fa-envelope"></i>
			</a>
		</div>

		<div style="position: relative; bottom: 100px; z-index: 1;"
			class="w3-tooltip w3-right">
			<span class="w3-text w3-padding w3-teal w3-hide-small">Go To
				Top</span> <a class="w3-button w3-theme" href="#myPage"><span
				class="w3-xlarge"> <i class="fa fa-chevron-circle-up"></i></span></a>
		</div>
	</footer>
	<!-- EndOf Footer -->
	<script>
		// Script for side navigation
		function w3_open() {
			var x = document.getElementById("mySidebar");
			x.style.width = "300px";
			x.style.paddingTop = "10%";
			x.style.display = "block";
		}

		// Close side navigation
		function w3_close() {
			document.getElementById("mySidebar").style.display = "none";
		}

		// Used to toggle the menu on smaller screens when clicking on the menu button
		function openNav() {
			var x = document.getElementById("navDemo");
			if (x.className.indexOf("w3-show") == -1) {
				x.className += " w3-show";
			} else {
				x.className = x.className.replace(" w3-show", "");
			}
		}
		
	     //hover logo
		function hover(element) {
		  element.setAttribute('src', 'logo2.png');
		}
		
		function unhover(element) {
		  element.setAttribute('src', 'logo1.png');
		}
		
	      
	     //
		window.onload = function() {
			var back_times = localStorage.getItem('back_times');

		    if(back_times) {
		    	localStorage.removeItem("back_times");
		    }
		};
	</script>

</body>
</html>
