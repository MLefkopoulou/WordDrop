<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="db_management.dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="db_management.model.UserWord"%>
<%@ page import="db_management.model.UserList"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>
<!DOCTYPE html>
<html>
<title>User's List (Community)</title>
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
table {
	font-family: arial, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

td {
	border: 1px solid #dddddd;
	text-align: center;
	padding: 8px;
}

th {
	border: 1px solid #dddddd;
	padding: 8px;
}

tr:nth-child(even) {
	background-color: #dddddd;
}
/* The Modal (background) */
/* The Modal (background) */
.modal, .modal2 {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 100px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content, .modal-content2 {
	position: relative;
	background-color: #fefefe;
	margin: auto;
	padding: 0;
	border: 1px solid #888;
	width: 50%;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
	-webkit-animation-name: animatetop;
	-webkit-animation-duration: 0.4s;
	animation-name: animatetop;
	animation-duration: 0.4s
}

/* Add Animation */
@
-webkit-keyframes animatetop {
	from {top: -300px;
	opacity: 0
}

to {
	top: 0;
	opacity: 1
}

}
@
keyframes animatetop {
	from {top: -300px;
	opacity: 0
}

to {
	top: 0;
	opacity: 1
}

}

/* The Close Button */
.close, .close2 {
	color: white;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus, .close2:hover, .close2:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

.modal-header, .modal-header2 {
	padding: 2px 16px;
	background-color: teal;
	color: white;
}

.modal-body, .modal-body2 {
	padding: 2px 16px;
}

.modal-footer, .modal-footer2 {
	padding: 2px 16px;
	background-color: teal;
	color: white;
}

.center {
	display: block;
	margin-left: auto;
	margin-right: auto;
	width: 50%;
}

.fa-user {
	font-size: 15px;
	color: black;
}

    /* image dropdown-scale up... */
.w3-dropdown-hover{position:relative;display:inline-block;cursor:pointer}
.image-hover:hover .image-content{display:block}
.image-hover.w3-mobile .image-content {position:relative}
.image-hover.w3-mobile {width:100%}

/* .image-content{			//scale above original img position
	cursor:auto;
	display:none;
	position:absolute;
	min-width:160px;
	max-width:300px;
	margin-top:-20%;
	margin-left:-5%;
	padding:0;
	z-index:1;
} */
   /* ^^ OR \/ */
.image-content {			/* scale on a fixed point no matter the scrolling */
	cursor:auto;
	display:none;
	position: fixed;
    left: 50%;
    top: 50%;
    z-index: 100;
    max-width: 300px;
    margin-top: -185px;
    margin-left: -200px;
}
/* ...image dropdown-scale up */

/* Sidebar TEXT OVERFLOW HUNNDLING... 
[data-title] {
	
	position: relative;
	cursor: text;
}

[data-title]:hover::before {
	content: attr(data-title);
	position: absolute;
  	margin-top:50px;		
  	margin-left : -0px;		
	padding: 10px;
	background: teal;
	color: #fff;
	font-size: 14px;
  	width: 250px;
	white-space: wrap;
	
	z-index: 99 !important; 	
}

[data-title]:hover::after {
	content: '';
	position: absolute;
	bottom: -12px;
	left: 60px;
	border: 8px solid transparent;	
	border-bottom: 8px solid teal;
	opacity: 0.7;
}
 ...SidebarTEXT OVERFLOW HUNNDLING */

</style>
<body id="myPage">
<div class="content">
	<%
		String username = null;
		if (session.getAttribute("username") == null) {
			response.sendRedirect("login.html");
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
		String listname = (String) request.getAttribute("listname");
		if (listname == null) {
			listname = request.getParameter("listname");
		}
		String tag_filter = (String) request.getAttribute("tag_filter");
		session.setAttribute("tag_filter_comm", tag_filter);
		String special_tag;
		special_tag = (String) request.getAttribute("special_tag");
		session.setAttribute("special_tag_comm", special_tag);
		String listOwner = (String) session.getAttribute("listOwner");
		int current_list_id = (int) session.getAttribute("list_id");
		session.setAttribute("list_id", current_list_id);
		DatabaseManager db = new DatabaseManager();
		int imageExists = db.isThereImage(current_list_id);
		ArrayList<UserWord> list_words = (ArrayList<UserWord>) session.getAttribute("list_words");

	%>
	<!-- Sidebar/menu -->
	<nav class="w3-sidebar w3-bar-block w3-white w3-collapse w3-top"
		style="z-index: 3; width: 250px; top: 38px" id="mySidebar">
		<div class="w3-container w3-display-container w3-padding-16">
			<i onclick="w3_close()"
				class="fa fa-remove w3-hide-large w3-button w3-display-topright"></i>
		</div>
		<div class="w3-padding-64 w3-large w3-text-grey"
			style="font-weight: bold">

			<a onclick="myAccFunc()" href="javascript:void(0)"
				class="w3-button w3-block w3-white w3-left-align" id="myBtn3"> <%=special_tag%>
				<i class="fa fa-caret-down"></i>
			</a>
			<div id="demoAcc"
				class="w3-bar-block w3-hide w3-padding-large w3-medium">
				<%
					ArrayList<UserList> current_lists = (ArrayList<UserList>) session.getAttribute("current_lists_comm");
					session.setAttribute("current_lists_comm", current_lists);
					for (int i = 0; i < current_lists.size(); i++) {
						String this_listname = (String) current_lists.get(i).getListname();
						int list_id = (int) current_lists.get(i).getList_id();
						int user_id = (int) current_lists.get(i).getUser_id();
						
						String currSbarUser = db.findUser(user_id);
						if ((this_listname.equals(listname)) && (current_list_id == list_id)) {
				%>

				<div data-title="<%=this_listname%>" data-type="html">
					<a href="#" class="w3-bar-item w3-button w3-dark-grey" style="overflow : hidden; white-space:nowrap;text-overflow: ellipsis;">
						<i class="fa fa-caret-right w3-margin-right"></i><%=this_listname%>
					</a>
				</div>
				<%
					} else {
				%>
				<form action="GetCommunityWords" method="post">
					<input type="hidden" name="list_id" value="<%=list_id%>"> 
					<input type="hidden" name="listname" value="<%=this_listname%>">
					<input type="hidden" name="listOwner" value="<%=currSbarUser%>">
					<div data-title="<%=this_listname%>" data-type="html">
						<button type="submit" class="w3-bar-item w3-button" style="overflow : hidden; white-space:nowrap;text-overflow: ellipsis;"><%=this_listname%></button>
					</div>
					</button>
				</form>

				<%
					}
					}
				%>
			</div>

		</div>
	</nav>
	<!-- EndOf Sidebar -->



	<!-- Navbar -->
	<div class="w3-top">
		<div class="w3-bar w3-theme-d2 w3-left-align">
			<a onclick="w3_open()" class="w3-bar-item w3-button w3-medium w3-hide-large w3-black"><i class="fa fa-bars"></i></a>
            <a href="home.jsp" 	class="w3-bar-item w3-button " style="padding:0px ;"><img id="logo-img" src="logo1.png" style="height:38px;" onmouseover="hover(this);" onmouseout="unhover(this);" /></a> 
  
			<a class="w3-bar-item w3-button w3-hide-medium w3-hide-large  w3-theme-d2"
				href="javascript:void(0);" onclick="openNav()"><i
				class="fa fa-caret-down"></i></a>
			<form action="GetAllLists" method="post">
				<button class="w3-bar-item w3-button w3-hide-small "
					type="submit">My Lists</button>
			</form>
			<a href="games.html"
				class="w3-bar-item w3-button w3-hide-small ">Games</a>
			<form action="GetCommunitycategories" method="post">
				<button class="w3-bar-item w3-button w3-hide-small  w3-teal"
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
					type="submit"> MyLists</button>
			</form>
			<a href="games.html"
				class="w3-bar-item w3-button">Games</a>
			<form action="GetCommunitycategories" method="post">
				<button class="w3-bar-item w3-button w3-teal"
					type="submit">Community</button>
			</form>

		</div>
	</div>



	<!-- Overlay effect when opening sidebar on small screens -->
	<div class="w3-overlay w3-hide-large" onclick="w3_close()"
		style="cursor: pointer" title="close side menu" id="myOverlay"></div>



	<!-- !MAIN PAGE CONTENT! -->
	<div class="w3-main" style="margin-left: 250px; padding-top: 38px">

		<%
			if (tag_filter.equals(special_tag)) {
		%>
		<h2 style="padding-left: 20px"><%=tag_filter%>
			>
			<%=listname%></h2>
		<%
			} else {
		%>
		<h2 style="padding-left: 20px"><%=tag_filter%>
			&
			<%=special_tag%>
			>
			<%=listname%></h2>
		<%
			}
		%>



		<form action="GetAllLists" method="post"
			style="text-align: left; padding-left: 25px">
			<input type="hidden" name="listOwner" value="<%=listOwner%>">
			<button type="submit" class="w3-button">
				<i class="fa fa-user"></i>
				<%=listOwner%>
			</button>
		</form>

		<!-- Trigger/Open The Modal -->
		<div style="padding-right: 20px; float: right">
			<button id="myBtn2" style = "cursor:pointer">Play Game</button>
		</div>
		<div style="padding-right: 20px; float: right">
			<button id="myBtn" style = "cursor:pointer">Copy List</button>
		</div>
		<!-- The Modal for Copy List-->
		<div id="myModal" class="modal">

			<!-- Modal content -->
			<div class="modal-content">
				<div class="modal-header">
					<span class="close">&times;</span>
					<h2>Copy List to your Lists</h2>
				</div>
				<div class="modal-body">
					<form class="w3-container w3-card-4 w3-padding-16 w3-white"
						action="CopyPasteList" method="post">
						<div class="w3-section">
							<label>Rename List(optional)</label> 
							<input class="w3-input" type="text" name="rename-list" placeholder="" autocomplete="off" notrequired>
						</div>
						<div class="w3-section">
							<label>Change Tag(optional)</label> 
							<input class="w3-input" type="text" name="rename-tag" placeholder="" autocomplete="off" notrequired>
						</div>
						<input type="hidden" name="current_list_id" value=<%=current_list_id%>> 
						<input type="hidden" name="username" value=<%=userName%>> 
						<input type="hidden" name="listOwner" value="<%=listOwner%>"> 
						<input type="hidden" name="listname" value="<%=listname%>">
                        <input type="hidden" name="page" value="comm">
						<button type="submit" class="w3-button center w3-theme ">Save</button>
					</form>
				</div>
				<div class="modal-footer"><br><br><br></div>
			</div>

		</div>

		<!-- The Modal for New Game-->
		<div id="myModal2" class="modal2">

							<!-- Modal content -->
				<div class="modal-content2">
					<div class="modal-header2">
						<span class="close2">&times;</span>
						<h2>Play a Game</h2>
					</div>
					<div class="modal-body2">
						<div class="w3-container w3-card-4 w3-padding-16 w3-white">
							<%if(list_words.size() <= 0 ){ %>
								<button onclick="alert_game1()" class="w3-button center w3-theme ">
									<i class="fa fa-play"></i> Classic Review
								</button>
							<%}else{ %>
						<form action="Classic_review_servlet" method = "post">
						<input type="hidden" name="listname" value="<%=listname%>">
							<button type="submit" class="w3-button center w3-theme ">
								<i class="fa fa-play"></i> Classic Review
							</button>
							</form>
							<%} %>
							<%if(list_words.size() < 3 || imageExists == 0){ %>
								<button  class="w3-button center w3-theme " onclick="alert_game2()" >
									<i class="fa fa-play"></i> Flashcards
								</button>
							<%}else{ %>
								<form action="FlashcardsInit" method = "post">
									<input type="hidden" name="listname" value="<%=listname%>">
									<input type="hidden" name="list_id" value="<%=current_list_id%>">
									<button type="submit" class="w3-button center w3-theme ">
										<i class="fa fa-play"></i> Flashcards
									</button>
								</form>
							<%} %>
							<%if(list_words.size() < 3){ %>
								<button onclick="alert_game3()" class="w3-button center w3-theme ">
									<i class="fa fa-play"></i> Multiple Choice
								</button>
							<%}else{ %>
								<form action="Multiple_choice_servlet" method = "post">
									<input type="hidden" name="listname" value="<%=listname%>">
									<button type="submit" class="w3-button center w3-theme ">
										<i class="fa fa-play"></i> Multiple Choice
									</button>
								</form>
							<%} %>
						</div>
					</div>
				<div class="modal-footer2">
					<br><br><br>
				</div>
			</div>

		</div>


		<div style="padding: 20px">
			<table>
				<tr class="w3-teal">
					<th style="width:25%;">WORD
						<div class="w3-dropdown-click" style="float: right;height:1%">
						    <button onclick="myOrderFunction()" class="w3-button" style="font-size:12px;padding:0%;margin:0%"><i class="fa fa-sort"></i></button>
						    <div id="sort" class="w3-dropdown-content w3-bar-block w3-border">
								<form action="GetCommunityWords" method="post">
									<input type="hidden" name="sort" value="abc">
									<input type="hidden" name="list_id" value="<%=current_list_id%>">
									<input type="hidden" name="listname" value="<%=listname%>">
									<input type="hidden" name="listOwner" value="<%=listOwner%>">
									<button class="w3-bar-item w3-button" type="submit">Alphabetical</button>
								</form>
							    <form action="GetCommunityWords" method="post">
							      	<input type="hidden" name="sort" value="old">
							      	<input type="hidden" name="list_id" value="<%=current_list_id%>">
							        <input type="hidden" name="listname" value="<%=listname%>">
									<input type="hidden" name="listOwner" value="<%=listOwner%>">
									<button class="w3-bar-item w3-button" type="submit">oldest first</button>
							    </form>
							    <form action="GetCommunityWords" method="post">
							      	<input type="hidden" name="sort" value="new">
							      	<input type="hidden" name="list_id" value="<%=current_list_id%>">
							        <input type="hidden" name="listname" value="<%=listname%>">
									<input type="hidden" name="listOwner" value="<%=listOwner%>">
									<button class="w3-bar-item w3-button" type="submit">newest first</button>
							    </form>
						    </div>
						</div>
					</th>
					<th style="width:28%;">TRANSLATION</th>
					<th style="width:44%;">IMAGE</th>
				</tr>
				<%
					session.setAttribute("current_words", list_words);
					String word1 = "";
					String word2 = "";
					String im_path = "";
					int list_id = -1;
					for (int j = 0; j < list_words.size(); j++) {
						word1 = list_words.get(j).getWord1();
						word2 = list_words.get(j).getWord2();
						im_path = list_words.get(j).getIm_path();
						list_id = list_words.get(j).getList_id();
				%>
				<tr>
					<th><%=word1%></th>
					<th><%=word2%></th>
					<%
						String exte = im_path.substring(im_path.lastIndexOf(".") + 1);
							if (exte.equals("empty")) {
					%>
					<td><img src="no_image.png" alt="no image yet" style="width: 30%;"></td>
					<%
						} else {
					%>
					<td style="display: flex;justify-content: center;align-items: center;">
               				<div class="image-hover" style="width:30%; text-align: center;">
               					<img src="/UserData/<%=im_path%>" alt="no image yet" style="width:100%; text-align: center;">
	    						<div class="image-content"><br>
	      							<img src="/UserData/<%=im_path%>" alt="no image yet" style="width:100%;border: 5px solid lightgrey;">
	    						</div>
	  						</div>
  						</td>
					<%
						}
					%>
				</tr>
				<%
					}
				%>
			</table>
		</div>
	</div>
	<!-- EndOf Main Page Content -->

	<br>
	<br>
	<br>
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
		// Accordion 
		function myAccFunc() {
			var x = document.getElementById("demoAcc");
			if (x.className.indexOf("w3-show") == -1) {
				x.className += " w3-show";
			} else {
				x.className = x.className.replace(" w3-show", "");
			}
		}

		// Click on the "Jeans" link on page load to open the accordion for demo purposes
		document.getElementById("myBtn3").click();

		// Open and close sidebar
		function w3_open() {
			document.getElementById("mySidebar").style.display = "block";
			document.getElementById("myOverlay").style.display = "block";
		}

		function w3_close() {
			document.getElementById("mySidebar").style.display = "none";
			document.getElementById("myOverlay").style.display = "none";
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

		// Get the modal
		var modal = document.getElementById("myModal");

		// Get the button that opens the modal
		var btn = document.getElementById("myBtn");

		// Get the <span> element that closes the modal
		var span = document.getElementsByClassName("close")[0];

		// When the user clicks the button, open the modal 
		btn.onclick = function() {
			modal.style.display = "block";
		}

		// When the user clicks on <span> (x), close the modal
		span.onclick = function() {
			modal.style.display = "none";
		}

		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
			if (event.target == modal) {
				modal.style.display = "none";
			}
		}

		// Get the modal2
		var modal2 = document.getElementById("myModal2");

		// Get the button that opens the modal
		var btn2 = document.getElementById("myBtn2");

		// Get the <span> element that closes the modal
		var span2 = document.getElementsByClassName("close2")[0];

		// When the user clicks the button, open the modal 
		btn2.onclick = function() {
			modal2.style.display = "block";
		}

		// When the user clicks on <span> (x), close the modal
		span2.onclick = function() {
			modal2.style.display = "none";
		}

		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
			if (event.target == modal2) {
				modal2.style.display = "none";
			}
		}
		
	     function alert_game1(){
				alert("This list is empty,so you can not play classic review game. Νeed at least 1.\n Sorry 😢")
			}
	     function alert_game2(){
				alert("You need at least 3 words and 1 image in order to play the flashcards game.\n Sorry! 😢")
			}
	    	function alert_game3(){
				alert("This list has not enought words ,so you can not play multiple choice game. Νeed at least 3 words.\n Sorry 😢")
			}
	    	
	    	
			//hover logo
			function hover(element) {
			  element.setAttribute('src', 'logo2.png');
			}
			
			function unhover(element) {
			  element.setAttribute('src', 'logo1.png');
			}
			
			//for word sorting
			function myOrderFunction() {
				  var x = document.getElementById("sort");
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
	</script>

</body>
</html>