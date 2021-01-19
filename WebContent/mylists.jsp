<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="db_management.dao.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="db_management.model.UserList"%>

<%@ page import="javax.servlet.http.HttpServletResponse"%>
<!DOCTYPE html>
<html>
<title>MyLists</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
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
.box {
	float: left;
	width: 210px;
	height: 260px;
	padding: 10px;
}

.box2 {
	width: 90%;
	height: 90%;
	padding: 2% 8%;
	background-color: #dddddd;
	border: 2px solid darkgrey;
}

.center {
	display: block;
	margin-left: auto;
	margin-right: auto;
	width: 50%;
}

.fa-plus {
	font-size: 60px;
	color: #808080;
}

.fa-user {
	font-size: 15px;
	color: black;
}

/* The Modal (background) */
.modal, .rename_modal, .delete_modal, .change_modal{
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
.modal-content, .rename_modal-content, .delete_modal-content , .change_modal-content{
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
.close, .rename_close,.delete_close, .change_close {
	color: white;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus, .change_close:hover, .change_close:focus, .rename_close:hover, .rename_close:focus ,.delete_close:hover, .delete_close:focus{
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

.modal-header, .rename_modal-header , .delete_modal-header, .change_modal-header{
	padding: 2px 16px;
	background-color: teal;
	color: white;
}

.modal-body, .rename_modal-body, .delete_modal-body, .change_modal-body{
	padding: 2px 16px;
}

.modal-footer, .rename_modal-footer, .delete_modal-footer, .change_modal-footer{
	padding: 2px 16px;
	background-color: teal;
	color: white;
}

.dropbtn {
	padding-right: 0;
	float: right;
	border: none;
	cursor: pointer;
}

.dropdown {
	position: relative;
}

.dropdown-content {
	display: none;
	position: absolute;
	right: 0;
	background-color: #f9f9f9;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.dropdown-content a:hover {
	background-color: teal;
}

.dropdown:hover .dropdown-content {
	display: block;
}

.dropdown:hover .dropbtn {
	background-color: #3e8e41;
}

/* TEXT OVERFLOW HUNNDLING for dynamic boxes... */
[data-title] {
	/* font-size: 18px; */
	position: relative;
	cursor: text;
	
}
/* style for hover window */
[data-title]:hover::before {
	content: attr(data-title);
	position: absolute;
  	margin-top:33px;
  	margin-left : -125px;
	padding: 10px;
	background: #000;
	color: #fff;
	font-size: 14px;
  	width: 250px;
	white-space: wrap;
	opacity: 0.7;
}
/* style for arrow */
[data-title]:hover::after {
	content: '';
	position: absolute;
	bottom: -12px;
	left: 60px;
	border: 8px solid transparent;	
	border-bottom: 8px solid #000;
	opacity: 0.4;
}
/* ...TEXT OVERFLOW HUNNDLING for dynamic boxes */


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
		String tag_filter = (String) request.getAttribute("tag_filter");
		session.setAttribute("tag_filter", tag_filter);
		String special_tag = (String) request.getAttribute("special_tag");
		session.setAttribute("special_tag", special_tag);
		ArrayList<String> all_tags = (ArrayList<String>) session.getAttribute("all_tags");
		ArrayList<String> all_languages = (ArrayList<String>) session.getAttribute("all_languages");
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
			<%
				if (tag_filter.equals("All")) {
			%>

			<a href="#" class="w3-bar-item w3-button w3-dark-grey"><i
				class="fa fa-caret-right w3-margin-right"></i><%=tag_filter%></a> <a
				onclick="myAccFunc_langs()" href="javascript:void(0)"
				class="w3-button w3-block w3-white w3-left-align w3-light-grey"
				id="myBtn2"> Languages<i class="fa fa-caret-down"></i>
			</a>
			<div id="languages"
				class="w3-bar-block w3-hide w3-padding-large w3-medium">
				<%
					for (int i = 0; i < all_languages.size(); i++) {
							String langs = (String) all_languages.get(i);
				%>
				<form action="GetSpecificLists" method="post">
					<input type="hidden" name="tag_filter" value="Languages"> <input
						type="hidden" name="special_tag" autocomplete="off" value="<%=langs%>">
					<button type="submit" class="w3-bar-item w3-button""><%=langs%></button>
				</form>
				<%
					}
				%>
			</div>
			<a onclick="myAccFunc_tags()" href="javascript:void(0)"
				class="w3-button w3-block w3-white w3-left-align w3-light-grey"
				id="myBtn3"> Tags<i class="fa fa-caret-down"></i>
			</a>
			<div id="tags"
				class="w3-bar-block w3-hide w3-padding-large w3-medium">
				<%
					for (int i = 0; i < all_tags.size(); i++) {
							String tags = (String) all_tags.get(i);
				%>
				<form action="GetSpecificLists" method="post">
					<input type="hidden" name="tag_filter" value="Tag"> <input
						type="hidden" name="special_tag" autocomplete="off" value="<%=tags%>">
					<button type="submit" class="w3-bar-item w3-button"><%=tags%></button>
				</form>
				<%
					}
				%>
			</div>
			<%
				} else if (tag_filter.equals("Languages")) {
			%>
			<form action="GetAllLists" method="post">
				<input type="hidden" name="tag_filter" value="All"> 
				<input type="hidden" name="special_tag" value="All">
				<button class="w3-bar-item w3-button w3-light-grey" type="submit">All</button>
			</form>
			<a onclick="myAccFunc_langs()" href="javascript:void(0)"
				class="w3-button w3-block w3-white w3-left-align w3-light-grey"
				id="myBtn2"> Languages<i class="fa fa-caret-down"></i>
			</a>
			<div id="languages"
				class="w3-bar-block w3-hide w3-padding-large w3-medium">
				<%
					for (int i = 0; i < all_languages.size(); i++) {
							String langs = (String) all_languages.get(i);

							if (langs.equals(special_tag)) {
				%>
				<form action="GetSpecificLists" method="post">
					<input type="hidden" name="tag_filter" value="Languages"> <input
						type="hidden" name="special_tag" value="<%=langs%>">
					<button type="submit" class="w3-bar-item w3-button w3-dark-grey">
						<i class="fa fa-caret-right w3-margin-right"></i><%=langs%></button>
				</form>
				<%
					} else {
				%>
				<form action="GetSpecificLists" method="post">
					<input type="hidden" name="tag_filter" value="Languages"> <input
						type="hidden" name="special_tag" value="<%=langs%>">
					<button type="submit" class="w3-bar-item w3-button"><%=langs%></button>
				</form>
				<%
					}
				%>
				<%
					}
				%>
			</div>
			<a onclick="myAccFunc_tags()" href="javascript:void(0)"
				class="w3-button w3-block w3-white w3-left-align w3-light-grey"
				id="myBtn3"> Tags<i class="fa fa-caret-down"></i>
			</a>
			<div id="tags"
				class="w3-bar-block w3-hide w3-padding-large w3-medium">
				<%
					for (int i = 0; i < all_tags.size(); i++) {
							String tags = (String) all_tags.get(i);
				%>
				<form action="GetSpecificLists" method="post">
					<input type="hidden" name="tag_filter" value="Tag"> <input
						type="hidden" name="special_tag" value="<%=tags%>">
					<button type="submit" class="w3-bar-item w3-button"><%=tags%></button>
				</form>
				<%
					}
				%>
			</div>
			<%
				} else {
			%>

			<form action="GetAllLists" method="post">
				<input type="hidden" name="tag_filter" value="All"> <input
					type="hidden" name="special_tag" value="All">
				<button class="w3-bar-item w3-button w3-light-grey" type="submit">All</button>
			</form>
			<a onclick="myAccFunc_langs()" href="javascript:void(0)"
				class="w3-button w3-block w3-white w3-left-align w3-light-grey"
				id="myBtn2"> Languages<i class="fa fa-caret-down"></i>
			</a>
			<div id="languages"
				class="w3-bar-block w3-hide w3-padding-large w3-medium">
				<%
					for (int i = 0; i < all_languages.size(); i++) {
							String langs = (String) all_languages.get(i);
				%>
				<form action="GetSpecificLists" method="post">
					<input type="hidden" name="tag_filter" value="Languages"> <input
						type="hidden" name="special_tag" value="<%=langs%>">
					<button type="submit" class="w3-bar-item w3-button"><%=langs%></button>
				</form>
				<%
					}
				%>
			</div>
			<a onclick="myAccFunc_tags()" href="javascript:void(0)"
				class="w3-button w3-block w3-white w3-left-align w3-light-grey"
				id="myBtn3"> Tags<i class="fa fa-caret-down"></i>
			</a>
			<div id="tags"
				class="w3-bar-block w3-hide w3-padding-large w3-medium">
				<%
					for (int i = 0; i < all_tags.size(); i++) {
							String tags = (String) all_tags.get(i);
							if (tags.equals(special_tag)) {
				%>
				<form action="GetSpecificLists" method="post">
					<input type="hidden" name="tag_filter" value="Tag"> <input
						type="hidden" name="special_tag" value="<%=tags%>">
					<button type="submit" class="w3-bar-item w3-button w3-dark-grey">
						<i class="fa fa-caret-right w3-margin-right"></i><%=tags%></button>
				</form>

				<%
					} else {
				%>
				<form action="GetSpecificLists" method="post">
					<input type="hidden" name="tag_filter" value="Tag"> <input
						type="hidden" name="special_tag" value="<%=tags%>">
					<button type="submit" class="w3-bar-item w3-button"><%=tags%></button>
				</form>

				<%
					}
				%>
				<%
					}
				%>
			</div>

			<%
				}
			%>
		</div>
	</nav>
	<!-- EndOf Sidebar -->


	<!-- Navbar -->
	<div class="w3-top">
		<div class="w3-bar w3-theme-d2 w3-left-align">
			<a onclick="w3_open()" class="w3-bar-item w3-button w3-medium w3-hide-large w3-black"
        ><i class="fa fa-bars"></i></a>
				<a href="home.jsp"
				class="w3-bar-item w3-button"style="padding:0px ;" ><img id="logo-img" src="logo1.png" style="height:38px;" onmouseover="hover(this);" onmouseout="unhover(this);" /></a>

			<a class="w3-bar-item w3-button w3-hide-medium w3-hide-large   w3-theme-d2"
				href="javascript:void(0);" onclick="openNav()"><i
				class="fa fa-caret-down"></i></a>
			<form action="GetAllLists" method="post">
				<button class="w3-bar-item w3-button w3-hide-small    w3-teal"
					type="submit">My Lists</button>
			</form>
			<a href="games.html"
				class="w3-bar-item w3-button w3-hide-small  ">Games</a>
			<form action="GetCommunitycategories" method="post">
				<button class="w3-bar-item w3-button w3-hide-small  "
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
				<button class="w3-bar-item w3-button w3-teal"
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





	<!-- Overlay effect when opening sidebar on small screens -->
	<div class="w3-overlay w3-hide-large" onclick="w3_close()"
		style="cursor: pointer" title="close side menu" id="myOverlay"></div>



	<!-- !MAIN PAGE CONTENT! -->
	<div class="w3-main" style="margin-left: 250px; padding-top: 38px">

		<section class="w3-row-padding w3-center">
			<%
				if (tag_filter.equals("All")) {
			%>
			<h1 style="text-align: left; padding-left: 15px"><%=tag_filter%></h1>
			<%
				} else {
			%>
			<h1 style="text-align: left; padding-left: 15px"><%=tag_filter%>: <%=special_tag%></h1>
			<%
				}
			%>
			<div style="text-align: left; padding-left: 15px">
				<i class="fa fa-user ">&nbsp;</i><%=userName%></div>

			<!-- The Modal -->
			<div id="myModal" class="modal">

				<!-- Modal content -->
				<div class="modal-content">
					<div class="modal-header">
						<span class="close">&times;</span>
						<h2>Add new list</h2>
					</div>
					<div class="modal-body">
						<form class="w3-container w3-card-4 w3-padding-16 w3-white"
							action="FunctionsForList" method="post">
							<div class="w3-section">
								<label>List name: </label> <input class="w3-input" type="text"
									name="list_name" autocomplete="off" required>
							</div>
							<div class="w3-section">
								<label>Language 1: </label> 
									<select class="w3-select" name="lang_1"  required>
										<option  value="" disabled selected >Choose Language 1</option>
										<option value="Arabic">Arabic</option>
										<option value="Bulgarian">Bulgarian</option>
										<option value="Czech">Czech</option>
										<option value="Danish">Danish</option>
										<option value="Dutch">Dutch</option>
										<option value="English">English</option>
										<option value="Finnish">Finnish</option>
										<option value="French">French</option>
										<option value="German">German</option>
										<option value="Greek">Greek</option>
										<option value="Italian">Italian</option>
										<option value="Japanese">Japanese</option>
										<option value="Korean">Korean</option>
										<option value="Mandarin">Mandarin Chinese</option>
										<option value="Hindi">Hindi (Modern Standard)</option>
										<option value="Norwegian">Norwegian</option>
										<option value="Portuguese">Portuguese</option>
										<option value="Russian">Russian</option>
										<option value="Spanish">Spanish</option>
										<option value="Swedish">Swedish</option>
										<option value="Thai">Thai</option>
										<option value="Turkish">Turkish</option>
										<option value="Ukrainian">Ukrainian</option>
									</select>
									
							</div>
							<div class="w3-section">
								<label>Language 2: </label> 
									<select class="w3-select" name="lang_2"  required>
									  <option  value="" disabled selected >Choose Language 2</option>
										<option value="Arabic">Arabic</option>
										<option value="Bulgarian">Bulgarian</option>
										<option value="Czech">Czech</option>
										<option value="Danish">Danish</option>
										<option value="Dutch">Dutch</option>
										<option value="English">English</option>
										<option value="Finnish">Finnish</option>
										<option value="French">French</option>
										<option value="German">German</option>
										<option value="Greek">Greek</option>
										<option value="Italian">Italian</option>
										<option value="Japanese">Japanese</option>
										<option value="Korean">Korean</option>
										<option value="Mandarin">Mandarin Chinese</option>
										<option value="Hindi">Hindi (Modern Standard)</option>
										<option value="Norwegian">Norwegian</option>
										<option value="Portuguese">Portuguese</option>
										<option value="Russian">Russian</option>
										<option value="Spanish">Spanish</option>
										<option value="Swedish">Swedish</option>
										<option value="Thai">Thai</option>
										<option value="Turkish">Turkish</option>
										<option value="Ukrainian">Ukrainian</option>
									</select>
									
							</div>
							<div class="w3-section">
								<label>Tag: </label> <input class="w3-input" type="text"
									name="tag" autocomplete="off" required>
							</div>
							<input type="hidden" name="action_to_do" value="add">
							<button type="submit" class="w3-button center w3-theme ">Create</button>
						</form>
					</div>
					<div class="modal-footer">
						<br> <br> <br>
					</div>
				</div>
			</div>
			<!-- end of modal content-->
			<div class="box">
				<div class="box2">
					<p><b>New List</b></p>
					<!-- Trigger/Open The Modal -->
					<p id="myBtn" class=" w3-xlarge center"
						style="width: 90%; padding-bottom: 10px">
						<i class="fa fa-plus"></i>
					</p>
				</div>
			</div>

			<%
				ArrayList<UserList> all_lists = (ArrayList<UserList>) session.getAttribute("all_lists");
				session.setAttribute("current_lists", all_lists);
				String listname = "";
				String lang1 = "";
				String lang2 = "";
				String tag = "";
				int list_id = -1;
				for (int j = 0; j < all_lists.size(); j++) {
					listname = all_lists.get(j).getListname();
					lang1 = all_lists.get(j).getLang1();
					lang2 = all_lists.get(j).getLang2();
					tag = all_lists.get(j).getTag();
					list_id = all_lists.get(j).getList_id();
			%>
			<div class="box">

				<div class="box2">
					<div class="dropdown">
						<i class="fa fa-ellipsis-v dropbtn"></i>
						<div class="dropdown-content" style="left: 0;">

							<a onclick="reply_click(this.id,'<%=listname%>')"
								href="javascript:void(0)" id="<%=list_id%>">Rename</a> 
							<a onclick="delete_click(this.id,'<%=listname%>')"
								href="javascript:void(0)" id="<%=list_id%>-">Delete</a>
								<a onclick="change_click(this.id,'<%=tag%>')"
								href="javascript:void(0)" id="<%=list_id%>+">Change Tag</a>
						</div>
					</div>
					<%-- <p style="overflow:auto; "><b><%=listname%></b></p> --%>
					<div data-title="<%=listname%>" data-type="html">
						<p style="overflow : hidden; white-space:nowrap;text-overflow: ellipsis;"><b><%=listname%></b></p>
					</div>
					<form action="GetWords.do" method="post">
						<input type="hidden" name="list_id" value="<%=list_id%>">
						<input type="hidden" name="listname" value="<%=listname%>">
						<button type="submit">
							<img src="list4.png" alt="Random Name"
								style="width: 70%; padding-bottom: 10pxl;cursor: pointer;">
						</button>
					</form>
					<div data-title="<%=lang1%>-<%=lang2%>" data-type="html">
						<div  style="overflow : hidden; white-space:nowrap;text-overflow: ellipsis;font-style: italic;padding-top:10px;">
							<%=lang1%>-<%=lang2%>
						</div>
					</div>
					<div data-title="#<%=tag%>" data-type="html">
						<div  style="overflow : hidden; white-space:nowrap;text-overflow: ellipsis">
							#<%=tag%>
						</div>
					</div>

				</div>
			</div>
			<%
				}
			%>
			<!-- The Modal -->
			<div id="rename_modal" class="modal">

				<!-- Modal content -->
				<div class="rename_modal-content">
					<div class="rename_modal-header">
						<span class="rename_close">&times;</span>
						<h2>Give another name</h2>
					</div>
					<div class="rename_modal-body">
						<form name = "form" class="w3-container w3-card-4 w3-padding-16 w3-white"
							action="FunctionsForList" method="post">
							<div class="w3-section">
								<label>List name: </label> <input class="w3-input" type="text"
									name="new_listname" placeholder="" required>
							</div>

							<input type="hidden" name="action_to_do" value="rename">
							<input type="hidden" name="list_id" value="">
							<button type="submit" class="w3-button center w3-theme ">Rename</button>
						</form>
					</div>
					<div class="rename_modal-footer">
						<br> <br> <br>
					</div>
				</div>
			</div>

			<div id="delete_modal" class="modal">

				<!-- Modal content -->
				<div class="delete_modal-content">
					<div class="delete_modal-header">
						<span class="delete_close">&times;</span>
						<h2>Are you sure?</h2>
					</div>
					<div class="delete_modal-body">
						<form name = "form_delete" class="w3-container w3-card-4 w3-padding-16 w3-white"
							action="FunctionsForList" method="post">
							<div class="w3-section">
								<label id = "delete_warning">The list: will be deleted</label> 
							</div>

							<input type="hidden" name="action_to_do" value="delete">
							<input type="hidden" name="list_id" value="">
							<button type="submit" class="w3-button center w3-theme ">Delete</button>
							
						</form>
					</div>
					<div class="delete_modal-footer">
						<br> <br> <br>
					</div>
				</div>
			</div>
			
						<!-- The Modal -->
			<div id="change_modal" class="modal">

				<!-- Modal content -->
				<div class="change_modal-content">
					<div class="change_modal-header">
						<span class="change_close">&times;</span>
						<h2>Give another tag</h2>
					</div>
					<div class="change_modal-body">
						<form name = "form2" class="w3-container w3-card-4 w3-padding-16 w3-white"
							action="FunctionsForList" method="post">
							<div class="w3-section">
								<label>List tag: </label> <input class="w3-input" type="text"
									name="new_tag" placeholder="" required>
							</div>

							<input type="hidden" name="action_to_do" value="change">
							<input type="hidden" name="list_id" value="">
							<button type="submit" class="w3-button center w3-theme ">Change</button>
						</form>
					</div>
					<div class="change_modal-footer">
						<br> <br> <br>
					</div>
				</div>
			</div>
		</section>



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
		// Accordion 
		var btn2 = document.getElementById("myBtn2");
		btn2.onclick = function myAccFunc_langs() {
			var x = document.getElementById("languages");
			if (x.className.indexOf("w3-show") == -1) {
				x.className += " w3-show";
			} else {
				x.className = x.className.replace(" w3-show", "");
			}
		}
		//open by default
		document.getElementById("myBtn2").click();

		var btn3 = document.getElementById("myBtn3");
		btn3.onclick = function myAccFunc_tags() {
			var x = document.getElementById("tags");
			if (x.className.indexOf("w3-show") == -1) {
				x.className += " w3-show";
			} else {
				x.className = x.className.replace(" w3-show", "");
			}
		}
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
		var btn = document.getElementById("myBtn");
		// Get the button that opens the modal

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
		
	
		//////////modal for rename///////
	
   		 function reply_click(clicked_id,listname)
	   {
		      document.form.new_listname.placeholder = listname;
		      document.form.list_id.value = clicked_id;
		      rename_modal.style.display ='block';
	    }
		var rename_modal = document.getElementById("rename_modal");
		var rename_btn = document.getElementById("rename_btn");
		// Get the button that opens the modal

		// Get the <span> element that closes the modal
		var rename_span = document.getElementsByClassName("rename_close")[0];

		// When the user clicks on <span> (x), close the modal
		rename_span.onclick = function() {
			rename_modal.style.display = "none";
		}

		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
			if (event.target == rename_modal) {
				rename_modal.style.display = "none";
			}
		}
		
		//////////modal for rename///////
		
  		 function change_click(clicked_id,tag)
	   {
		      document.form2.new_tag.placeholder = tag;
		      document.form2.list_id.value = clicked_id;
		      change_modal.style.display ='block';
	    }
		var change_modal = document.getElementById("change_modal");
		var change_btn = document.getElementById("change_btn");
		// Get the button that opens the modal

		// Get the <span> element that closes the modal
		var change_span = document.getElementsByClassName("change_close")[0];

		// When the user clicks on <span> (x), close the modal
		change_span.onclick = function() {
			change_modal.style.display = "none";
		}

		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
			if (event.target == rename_modal) {
				change_modal.style.display = "none";
			}
		} 
		//////////modal for delete///////
		
  		 function delete_click(clicked_id,listname)
	   {
  			  document.getElementById('delete_warning').innerHTML = 'The list : <b>'+listname+'</b> will be deleted';
		      document.form_delete.list_id.value = clicked_id;
		      delete_modal.style.display ='block';
	    }
		var delete_modal = document.getElementById("delete_modal");
		var delete_btn = document.getElementById("delete_btn");
		// Get the button that opens the modal

		// Get the <span> element that closes the modal
		var delete_span = document.getElementsByClassName("delete_close")[0];

		// When the user clicks on <span> (x), close the modal
		delete_span.onclick = function() {
			delete_modal.style.display = "none";
		}

		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
			if (event.target == delete_modal) {
				delete_modal.style.display = "none";
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
		  element.setAttribute('src', 'logo2.png');
		}
		
		function unhover(element) {
		  element.setAttribute('src', 'logo1.png');
		}
	</script>

</body>
</html>