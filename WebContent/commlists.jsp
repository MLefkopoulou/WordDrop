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
  <title>Community Lists</title>
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
 .fa-plus{
        font-size:60px;
        color :#808080;
  }
   .fa-user {
    	font-size:10px;
        color :black;
	}
    
    /* The Modal (background) */
    .modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    }

    /* Modal Content */
    .modal-content {
    position: relative;
    background-color: #fefefe;
    margin: auto;
    padding: 0;
    border: 1px solid #888;
    width: 50%;
    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
    -webkit-animation-name: animatetop;
    -webkit-animation-duration: 0.4s;
    animation-name: animatetop;
    animation-duration: 0.4s
    }

    /* Add Animation */
    @-webkit-keyframes animatetop {
    from {top:-300px; opacity:0} 
    to {top:0; opacity:1}
    }

    @keyframes animatetop {
    from {top:-300px; opacity:0}
    to {top:0; opacity:1}
    }

    /* The Close Button */
    .close {
    color: white;
    float: right;
    font-size: 28px;
    font-weight: bold;
    }

    .close:hover,
    .close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
    }

    .modal-header {
    padding: 2px 16px;
    background-color: teal;
    color: white;
    }

    .modal-body {padding: 2px 16px;}

    .modal-footer {
    padding: 2px 16px;
    background-color: teal;
    color: white;
    }
    
    
    .dropbtn {
    padding-right: 0;
    float : right;
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
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
    }

    .dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
    }

    .dropdown-content a:hover {background-color: teal;}
    .dropdown:hover .dropdown-content {display: block;}
    .dropdown:hover .dropbtn {background-color: #3e8e41;}
    
    
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
		session.setAttribute("tag_filter_comm", tag_filter);
		String special_tag = (String) request.getAttribute("special_tag");
		session.setAttribute("special_tag_comm", special_tag);
		ArrayList<String> community_tags = (ArrayList<String>) session.getAttribute("community_tags");
	%>
    <!-- Sidebar/menu -->
    <nav class="w3-sidebar w3-bar-block w3-white w3-collapse w3-top" style="z-index:3;width:250px;top:38px" id="mySidebar">
      <div class="w3-container w3-display-container w3-padding-16">
        <i onclick="w3_close()" class="fa fa-remove w3-hide-large w3-button w3-display-topright"></i>
      </div>
      	<div class="w3-padding-64 w3-large w3-text-grey"
			style="font-weight: bold">
			<%if(tag_filter.equals(special_tag)){ %>
			<a
				onclick="myAccFunc_tags()" href="javascript:void(0)"
				class="w3-button w3-block w3-white w3-left-align  w3-dark-grey"
				id="myBtn1"><i class="fa fa-caret-right w3-margin-right "></i><%=tag_filter %>: tags<i class="fa fa-caret-down"></i>
			</a>
			<%}else{ %>
				<a
				onclick="myAccFunc_tags()" href="javascript:void(0)"
				class="w3-button w3-block w3-white w3-left-align w3-light-grey"
				id="myBtn1"><%=tag_filter %>: tags<i class="fa fa-caret-down"></i>
				</a>
			<%} %>
			<div id="tag"
				class="w3-bar-block w3-hide w3-padding-large w3-medium">
				<%
					for (int i = 0; i < community_tags.size(); i++) {
							String tags = (String) community_tags.get(i);
							if(tags.equals(special_tag)){
				%>
				<form action="GetCommunityLists" method="post">
					<input type="hidden" name="tag_filter" value=<%=tag_filter %>> 
					<input type="hidden" name="special_tag" value="<%=tags%>">
					<button type="submit" class="w3-bar-item w3-button  w3-dark-grey"><i class="fa fa-caret-right w3-margin-right"></i><%=tags%></button>
				</form>
				<%
					}else{
				%>
					<form action="GetCommunityLists" method="post">
					<input type="hidden" name="tag_filter" value=<%=tag_filter %>> 
					<input type="hidden" name="special_tag" value="<%=tags%>">
					<button type="submit" class="w3-bar-item w3-button"><%=tags%></button>
					</form>
				
				<%} %>
				<%} %>
			</div>
	
      </div>
        
    </nav>
    <!-- EndOf Sidebar -->



	<!-- Navbar -->
	<div class="w3-top">
		<div class="w3-bar w3-theme-d2 w3-left-align">
		<a onclick="w3_open()" class="w3-bar-item w3-button w3-medium w3-hide-large w3-black"
        ><i class="fa fa-bars"></i></a>
		<a href="home.jsp" class="w3-bar-item w3-button"style="padding:0px ;">
			<img id="logo-img" src="logo1.png" style="height:38px;" onmouseover="hover(this);" onmouseout="unhover(this);" />
		</a>

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
					type="submit">My Lists</button>
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
    <div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>



    <!-- !MAIN PAGE CONTENT! -->
    <div class="w3-main" style="margin-left:250px;padding-top:38px">
        
    	 <section class="w3-row-padding w3-center">
    	 <%if(tag_filter.equals(special_tag)) {%>
        	<h1 style="text-align:left; padding-left:15px"><%=tag_filter %> </h1>
        <%}else{ %>
             <h1 style="text-align:left; padding-left:15px"><%=tag_filter %> & <%=special_tag %> </h1>
        <%} %>
       
       		<%
				ArrayList<UserList> community_lists = (ArrayList<UserList>) session.getAttribute("community_lists");
       			session.setAttribute("current_lists_comm", community_lists);
       			String listname = "";
				String lang1 = "";
				String lang2 = "";
				String tag = "";
				String listOwner ="";
				int list_id = -1;
				for (int j = 0; j < community_lists.size(); j++) {
					listname = community_lists.get(j).getListname();
					lang1 = community_lists.get(j).getLang1();
					lang2 = community_lists.get(j).getLang2();
					tag = community_lists.get(j).getTag();
					
					list_id = community_lists.get(j).getList_id();
					int user_id = (int) community_lists.get(j).getUser_id();
					DatabaseManager db = new DatabaseManager();
					listOwner = db.findUser(user_id);
			%>
            
            <div class = "box">
                <div class = "box2">
                <%-- <p><b><%= listname%></b></p> --%>
                <div data-title="<%=listname%>" data-type="html">
					<p style="overflow : hidden; white-space:nowrap;text-overflow: ellipsis;margin:5px;"><b><%=listname%></b></p>
				</div>
				<div data-title="<%=listOwner%>" data-type="html">
                	<div style="overflow : hidden; white-space:nowrap;text-overflow: ellipsis;"><i class="fa fa-user ">&nbsp;</i><%=listOwner%></div>
                </div>
                	<form action="GetCommunityWords" method="post">
						<input type="hidden" name="list_id" value="<%=list_id%>">
						<input type="hidden" name="listname" value="<%=listname%>">
						<input type="hidden" name="listOwner" value="<%=listOwner%>">
						<button type="submit">
			                <img src="list4.png" alt="Random Name" style="width:65%; padding-bottom:10px;cursor: pointer;">
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
            <%} %>
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
	var btn1 = document.getElementById("myBtn1");
	btn1.onclick = function myAccFunc_tags() {
		var x = document.getElementById("tag");
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
		} else {
			x.className = x.className.replace(" w3-show", "");
		}
	}
	//open by default
	document.getElementById("myBtn1").click();
      
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
        var btn = document.getElementById("myBtn2");

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