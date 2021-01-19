<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<title>Home</title>
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
.fa-info {
	font-size: 140px
}

.fa-list, .fa-puzzle-piece, .fa-users {
	font-size: 100px
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
		//allow access only if session exists
	String username = null;
	if (session.getAttribute("username") == null) {
		response.sendRedirect("login.jsp");
	} else
		username = (String) session.getAttribute("username");
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
	%>
	<!-- Navbar -->
	<div class="w3-top">
		<div class="w3-bar w3-theme-d2 w3-left-align">
			<a href="home.jsp"
				class="w3-bar-item w3-button w3-teal" style="padding:0px ;"><img id="logo-img" src="logo3.png" style="height:38px;" onmouseover="hover(this);" onmouseout="unhover(this);" /></a> 
			<a class="w3-bar-item w3-button w3-hide-medium w3-hide-large  w3-theme-d2"
				href="javascript:void(0);" onclick="openNav()"><i
				class="fa fa-caret-down"></i></a>
			<form action="GetAllLists" method="post">
				<button class="w3-bar-item w3-button w3-hide-small w3-hover-lightgrey "
					type="submit">My Lists</button>
			</form>
			<a href="games.html"
				class="w3-bar-item w3-button w3-hide-small w3-hover-lightgrey">Games</a>
			<form action="GetCommunitycategories" method="post">
				<button class="w3-bar-item w3-button w3-hide-small w3-hover-lightgrey"
					type="submit">Community</button>
			</form>
			<div class="w3-dropdown-hover">
				<button class="w3-button" title="Notifications"
					style="position: absolute; top: 0px; right: 0px">
					Profile <i class="fa fa-caret-down"></i>
				</button>
				<div class="w3-dropdown-content w3-card-4 w3-bar-block"
					style="position: absolute; top: 39px; right: 0px">
					<a href="FunctionsForSettings" class="w3-bar-item w3-button">Settings</a>
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
			<a href="games.html"
				class="w3-bar-item w3-button">Games</a>
			<form action="GetCommunitycategories" method="post">
				<button class="w3-bar-item w3-button"
					type="submit">Community</button>
			</form>

		</div>
	</div>



	<!-- Image Header -->
	<div class="w3-display-container w3-animate-opacity">
		<img src="lang8.jpg" 
			style="width: 100%; min-height: 350px; max-height: 500px; padding-top: 38px">

	</div>



	<!-- Contact Container -->
	<div class="w3-row-padding w3-padding-64 w3-container">
		<div class="w3-content">
			<div class="w3-threequarter">
				<h1 class="w3-text-teal">
					<b>About Us</b>
				</h1>
				<div class="w3-padding-32">
					<b style="  font-size: 25px">WordDrop has been created to help you learn vocabulary
						more efficiently.</b>
				
						<p style="  font-size: 18px">Some functions of the application are the following:</p>
						<ul style="  font-size: 18px">
							<li>Create custom lists of new words</li>
							<li>Connect words with images to help you memorize easier</li>
							<li>Connect words with their translation</li>
							<li>Explore lists from other members</li>
							<li>Play games to test and challenge yourself against both
								new and old gained vocabulary</li>
						</ul>
		</div>

			</div>

			<div class="w3-quarter w3-center" style="padding-top:140px">
				<i class="fa fa-info w3-padding-64 w3-text-teal center"></i>
			</div>
		</div>
	</div>



	<div class="w3-row-padding w3-padding-64 w3-container">
		<div class="w3-content">
			<div class="w3-threequarter">
				<h1 class="w3-text-teal">
					<b>My Lists</b>
				</h1>
				<p class="w3-padding-32"  style="  font-size: 18px">This field gives you the opportunity to
					create your own lists. In your lists, you
					can organize the words, their translation and maybe connect them
					with images. When you create a list you must give the name you want for the list, the first language , the second language and a tag(only if you want). 
					Τhe tag helps you to rank your list in a wider category. You can delete a list, rename a list or change the tag. </p>
					<p  style="  font-size: 18px">In each list you can add words. When you add a word you have to give the word , the translation and an image. You can always change the given info or delete the word if you change your mind.
					Remember you can not add the same word twice.</p>


			</div>

			<div class="w3-quarter w3-center" style="padding-top:140px">
				<i class="fa fa-list w3-padding-64 w3-text-teal center"></i>
			</div>
		</div>
	</div>


	<div class="w3-row-padding w3-padding-64 w3-container">
		<div class="w3-content">
			<div class="w3-threequarter">
				<h1 class="w3-text-teal">
					<b>Games</b>
				</h1>
				<p class="w3-padding-32"  style="  font-size: 18px">In this field you can play different
					games and this will help you memorize the words added in your
					lists.WordDrop support 3 types of games:</p>
						<ul  style="  font-size: 18px">
							<li>Classic review</li>
							<li>Flashcard game</li>
							<li>Multiple choise</li>
				
						</ul>
					<p  style="  font-size: 18px"> Remember learning can be fun :)</p>


			</div>

			<div class="w3-quarter w3-center" style="padding-top:140px">
				<i class="fa fa-puzzle-piece w3-padding-64 w3-text-teal center"></i>
			</div>
		</div>
	</div>

	<div class="w3-row-padding w3-padding-64 w3-container">
		<div class="w3-content">
			<div class="w3-threequarter">
				<h1 class="w3-text-teal">
					<b>Community</b>
				</h1>
				<p class="w3-padding-32"  style="  font-size: 18px">Oh yes! We have created a community
					where you can find lists from other members categorized by language.
					You can borrow whichever list you like and copy it in your profile or you can play a game from this list.</p>
				<p style="  font-size: 18px">If you find a user's list interesting you can visit his profile to see more of his lists</p>

			</div>

			<div class="w3-quarter w3-center" style="padding-top:100px">
				<i class="fa fa-users w3-padding-64 w3-text-teal center"></i>
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
		
		//
		window.onload = function() {
			var back_times = localStorage.getItem('back_times');

		    if(back_times) {
		    	localStorage.removeItem("back_times");
		    }
		};

		//hover logo
		function hover(element) {
		  element.setAttribute('src', 'logo4.png');
		}
		
		function unhover(element) {
		  element.setAttribute('src', 'logo3.png');
		}
		
		
	</script>

</body>
</html>
