<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="db_management.dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>

<!DOCTYPE html>
<html>
<title>Sign Up</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-black.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

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


  .fa-info,.fa-language {font-size:200px}
  .center {
    display: block;
    margin-left: auto;
    margin-right: auto;
    width: 50%;
}
</style>
<body id="myPage">

<div class="content">

<!-- Navbar -->
<div class="w3-top">
 <div class="w3-bar w3-theme-d2 w3-left-align">
 <a href="first-page.html" class="w3-bar-item w3-button "style="padding:0px ;"><img id="logo-img" src="logo1.png" style="height:38px;" onmouseover="hover(this);" onmouseout="unhover(this);" /></a> 
  <a class="w3-bar-item w3-button w3-hide-medium w3-hide-large  w3-theme-d2" href="javascript:void(0);" onclick="openNav()"><i class="fa fa-caret-down"></i></a>
  
  <a href="signup.jsp" class="w3-bar-item w3-button w3-hide-small  w3-teal">Sign Up</a>
  <a href="login.jsp" class="w3-bar-item w3-button w3-hide-small ">Log In</a>
  
  
 </div>

  <!-- Navbar on small screens -->
  <div id="navDemo" class="w3-bar-block w3-theme-d2 w3-hide w3-hide-large w3-hide-medium">
    <a href="signup.jsp" class="w3-bar-item w3-button w3-teal">Sign Up</a>
    <a href="login.jsp" class="w3-bar-item w3-button">Log In</a>
    

  </div>
</div>

<%
String error_message = (String )request.getAttribute("error_message_sign_up");
if(error_message == null){
	error_message ="no_error";
	
}
else{
	if(!error_message.equals("error_username")){
		error_message ="no_error";
	} 
}
%>
<div id="error_msg" value="<%=error_message%>" style="display:none" >
</div>
<!-- Contact Container -->
<div class="w3-container w3-padding-64 w3-theme-l5" id="contact">
  <div class="w3-row">
    <div class="w3-col m5">
      <img src="lang4.jpg" style="width:65%" class="center">
    </div>
    <div class="w3-col m7">
      <form class="w3-container w3-card-4 w3-padding-16 w3-white" action="SignUpUser.do" method = "post">
      <div class="w3-section">      
        <label><b>Username</b></label>
        <input class="w3-input" type="text" name="username" autocomplete="off" required>
      </div>
       <div id = "error_username" style="color:#800020; display:none;"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>
      <label>Error username</label></div>
      <div class="w3-section">  
       
        <label><b>Email</b></label>
        <input class="w3-input" type="email" name="email" autocomplete="off" required>
      </div>
      <div class="w3-section">      
        <label><b>Password</b></label>
        <input class="w3-input" type="password" name="password" autocomplete="off" required>
      </div>  
      
      <button type="submit" class="w3-button center w3-teal ">Sign Up</button>
      </form>
    </div>
  </div>
</div>


<br><br><br><br><br><br>


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

//errorhandle
function errorHande(error_msg){
    var error_username = document.getElementById("error_username");
	if(error_msg == "no_error"){
  		error_username.style.display = "none";
	   
	}else if(error_msg == "error_username"){

	    error_username.style.display = "block";
	}
}

window.onload = function() {

	let msg = document.getElementById('error_msg').getAttribute('value');

	errorHande(msg);
};

//hover logo
function hover(element) {
  element.setAttribute('src', 'logo2.png');
}

function unhover(element) {
  element.setAttribute('src', 'logo1.png');
}
</script>

</body>
</html>
