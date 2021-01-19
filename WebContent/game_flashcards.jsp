<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>
<!DOCTYPE html>
<html lang="en">


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

  .fa-gear {font-size:200px;
  color:teal;}
  .fa-x {
        font-size:15px;
  }
  .center {
    display: block;
    margin-left: auto;
    margin-right: auto;
    width: 50%;
  }
  
  	/* Game styles... */
  	body{
    	font-size: 20px;
    	font-family: monospace;
	}
	
	#container{
	    margin : 40px auto;
	    background-color: white;
	    height: 400px;
	    width : 900px;
	    border-radius: 5px;
	    box-shadow: 0px 5px 15px 0px;
	    position: relative;
	}
	#start{
	    font-size: 1.4em;
	    font-weight: bolder;
	    word-break: break-all;
	    width:200px;
	    height:80px;
	    border : 2px solid grey;
	    text-align: center;
	    cursor: pointer;
	    position: absolute;
	    left:350px;
	    top:160px;
	    color : grey;
	    display: flex;
		justify-content: center; /* align horizontal */
		align-items: center;
	    
	}
	#start:hover{
	    border: 3px solid teal;
	    color : teal;
	}
	
	#qImg{
	    float: left;
	    position: relative;
	    top: 60px;
	    left: 100px;
	    /* background-color: red; */
	    width : 200px;
	    height : 200px;
	    /*left : 0px;
	    top : 0px;*/
	    display: flex;
		justify-content: center; /* align horizontal */
		align-items: center;
	}
	#qImg img{
		/* position:absolute;
		center;
    	bottom:0;
   		right:0;
	    max-width : 100px;
	    max-height : 100px; */
	    max-width: 200px;
		max-height: 200px;
	}
	
	#question{
	    width : 480px;
	    position: relative;
	    float: right;
	    right : 0;
	    top : 20px;
	    padding : 5px;
	}
	
	#question p{
	    float: left;
	    display: inline-block;
	    width : 80%;
	    text-align: center;
	    border : 1px solid grey;
	    border-radius: 5px;
	    padding : 5px;
	    font-size: 1.25em;
	    background-color: green;
	    margin : 0;
	}
	
	#choices{
	    width : 480px;
	    position: absolute;
	    float: right;
	    right : 0;
	    top : 90px;
	    padding : 10px;
	    
	}
	.choice{
	    float: left;
	    display: inline-block;
	    width : 80%;
	    text-align: center;
	    border : 1px solid grey;
	    border-radius: 5px;
	    cursor: pointer;
	    padding : 5px;
	}
	.choice:hover{
	    border : 2px solid grey;
	    font-weight: bold;
	}
	
	#timer{
	    position: absolute;
	    height : 100px;
	    width : 200px;
	    bottom : 0px;
	    text-align: center;
		color : grey;
	}
	#counter{
	    font-size: 3em;
	}
	#btimeGauge{
	    width : 150px;
	    height : 10px;
	    border-radius: 10px;
	    background-color: lightgray;
	    margin-left : 25px;
	}
	#timeGauge{
	    height : 10px;
	    border-radius: 10px;
	    background-color: mediumseagreen;
	    margin-top : -10px;
	    margin-left : 25px;
	}
	#progress{
	    width : 500px;
	    position: absolute;
	    bottom : 0px;
	    right : 0px;
	    padding:5px;
	    text-align: right;
	    
	}
	.prog{
	    width : 25px;
	    height : 25px;
	    border: 1px solid #000;
	    display: inline-block;
	    border-radius: 50%;
	    margin-left : 5px;
	    margin-right : 5px;
	}
	#scoreContainer{
	    margin : 20px auto;
	    background-color: white;
	    opacity: 0.8;
	    height: 400px;
	    width : 900px;
	    border-radius: 5px;
	    box-shadow: 0px 5px 15px 0px;
	    position: relative;
	    display: none;
	}
	#scoreContainer img{
	    position: absolute;
	    top:50px;
	    left:400px;
	    width : 100px;
	    height :100px;
	}
	#scoreContainer p{
	    position: absolute;
	    display: block;
	    width : 100px;
	    height :100px;
	    top:150px;
	    left:400px;
	    font-size: 1.5em;
	    font-weight: bold;
	    text-align: center;
	}
	
	#replay_btn{
	    background-color: lightgray;
	    position: absolute;
	    width : 200px;
	    height :50px;
	    bottom:100px;
	    left:200px;
	    cursor: pointer;
	    box-shadow: 5px 6px 5px 6px #888888;
	}
	#exit_btn{
	    background-color: lightgray;
	    position: absolute;
	    width : 200px;
	    height :50px;
	    bottom:100px;
	    right:200px;
	    cursor: pointer;
	    box-shadow: 5px 6px 5px 6px #888888;
	}
	/* ...Game styles */
</style>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Flashcards</title>
    <!-- <link rel="stylesheet" href="flashcards-style.css"> -->
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-black.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
 <div class="content">
<!-- Navbar -->
	<div class="w3-top">
		<div class="w3-bar w3-theme-d2 w3-left-align">
			<a href="home.jsp"
				class="w3-bar-item w3-button"style="padding:0px ;" ><img id="logo-img" src="logo1.png" style="height:38px;" onmouseover="hover(this);" onmouseout="unhover(this);" /></a>
			<a class="w3-bar-item w3-button w3-hide-medium w3-hide-large  w3-theme-d2"
				href="javascript:void(0);" onclick="openNav()"><i
				class="fa fa-caret-down"></i></a>
			<form action="GetAllLists" method="post">
				<button class="w3-bar-item w3-button w3-hide-small "
					type="submit">My Lists</button>
			</form>
			<a href="games.html"
				class="w3-bar-item w3-button w3-hide-small   w3-teal">Games</a>
			<form action="GetCommunitycategories" method="post">
				<button class="w3-bar-item w3-button w3-hide-small "
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
				class="w3-bar-item w3-button w3-teal">Games</a>
			<form action="GetCommunitycategories" method="post">
				<button class="w3-bar-item w3-button"
					type="submit">Community</button>
			</form>

		</div>
	</div>

</div>
</head>

<body id="myPage">
<%
String listname =(String) session.getAttribute("listname");
%>

<div class="content">
    <!-- Main content -- Quiz -->
    <div class="w3-main" style="padding-top: 38px">
		<h2 id="game_title"  style="text-align:center;  font-weight: bolder; color:teal;">FLASHCARDS</h2>
 		<h4   style="text-align:center; font-weight: bolder; "><%=listname%></h4>
        <div id="container">
            <div id="start">Start Quiz!</div>
            <div id="quiz" style="display: none">
                <div id="qImg"></div>
                <div id="question" style="display: none"></div>
                <div id="choices">
                    <div class="choice" id="A" onclick="checkAnswer('A')"></div>
                    <div class="choice" id="B" onclick="checkAnswer('B')"></div>
                    <div class="choice" id="C" onclick="checkAnswer('C')"></div>
                </div>
                <div id="timer">
                    <div id="counter"></div>
                    <div id="btimeGauge"></div>
                    <div id="timeGauge"></div>
                </div>
                <div id="progress"></div>
            </div>
            <div id="scoreContainer" style="display: none"></div>
        </div>
    </div>
</div>

    <!-- Footer -->
    <footer class="footer w3-container w3-padding-32 w3-theme-d1 w3-center">
        <h4 class="center">Follow Us</h4>
        <div class="center">
            <a class="w3-button w3-large w3-teal" href="javascript:void(0)"
                title="Facebook"><i class="fa fa-facebook"></i></a> <a
                class="w3-button w3-large w3-teal" href="javascript:void(0)"
                title="Twitter"><i class="fa fa-twitter"></i></a> <a
                class="w3-button w3-large w3-teal" href="javascript:void(0)"
                title="Google +"><i class="fa fa-google-plus"></i></a> <a
                class="w3-button w3-large w3-teal" href="javascript:void(0)"
                title="Google +"><i class="fa fa-instagram"></i></a> <a
                class="w3-button w3-large w3-teal w3-hide-small"
                href="javascript:void(0)" title="Linkedin"><i
                class="fa fa-linkedin"></i></a>
        </div>

        <div style="position: relative; bottom: 100px; z-index: 1;"
            class="w3-tooltip w3-right">
            <span class="w3-text w3-padding w3-teal w3-hide-small">Go To
                Top</span> <a class="w3-button w3-theme" href="#myPage"><span
                class="w3-xlarge"> <i class="fa fa-chevron-circle-up"></i></span></a>
        </div>
    </footer>

	
	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	
    <!-- <script src="flashcards.js"></script> -->
    
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
        
        
        
        
        
        //Js for the Quiz...
        		// select all elements
		const start = document.getElementById("start");
		const quiz = document.getElementById("quiz");
		const question = document.getElementById("question");
		const qImg = document.getElementById("qImg");
		const choiceA = document.getElementById("A");
		const choiceB = document.getElementById("B");
		const choiceC = document.getElementById("C");
		const counter = document.getElementById("counter");
		const timeGauge = document.getElementById("timeGauge");
		const progress = document.getElementById("progress");
		const scoreDiv = document.getElementById("scoreContainer");
		
		
		var questions = function () {
		    var tmp = null;
		    $.ajax({
		        'async': false,
		        'type': "GET",
		        'global': false,
		        'dataType': 'json',
		        'url': "FlashcardsInit",
		        'data': { 'request': "", 'target': 'arrange_url', 'method': 'method_target' },
		        'success': function (data) {
		            tmp = data;
		        }
		    });
			//alert("return value--" + JSON.stringify(tmp));
			console.log("return value--" + JSON.stringify(tmp));
		    return tmp;
		}();
		
		// create some variables
		
		const lastQuestion = questions.length - 1;
		let runningQuestion = 0;
		let count = 0;
		const questionTime = 20; // 10s
		const gaugeWidth = 150; // 150px
		const gaugeUnit = gaugeWidth / questionTime;
		let TIMER;
		let score = 0;
		
		// render a question
		function renderQuestion(){
		    let q = questions[runningQuestion];
		    
		    question.innerHTML = "<p>"+ q.question +"</p>";
		
		    qImg.innerHTML = "<img src="+ q.imgSrc +">";
		    choiceA.innerHTML = q.choiceA;
		    choiceB.innerHTML = q.choiceB;
		    choiceC.innerHTML = q.choiceC;
		}
		
		start.addEventListener("click",startQuiz);
		
		// start quiz
		function startQuiz(){
		    start.style.display = "none";
		    renderQuestion();
		    quiz.style.display = "block";
		    renderProgress();
		    renderCounter();
		    TIMER = setInterval(renderCounter,1000); // 1000ms = 1s
		}
		
		// render progress
		function renderProgress(){
		    for(let qIndex = 0; qIndex <= lastQuestion; qIndex++){
		        progress.innerHTML += "<div class='prog' id="+ qIndex +"></div>";
		    }
		}14
		
		// counter render
		
		function renderCounter(){
		    if(count <= questionTime){
		        counter.innerHTML = count;
		        timeGauge.style.width = count * gaugeUnit + "px";
		        count++
		    }else{
		        count = 0;
		        // change progress color to red
		        answerIsWrong();
		        if(runningQuestion < lastQuestion){
		            runningQuestion++;
		            renderQuestion();
		        }else{
		            // end the quiz and show the score
		            clearInterval(TIMER);
		            scoreRender();
		        }
		    }
		}
		
		// checkAnwer
		
		function checkAnswer(answer){
		    if( answer == questions[runningQuestion].correct){
		        // answer is correct
		        score++;
		        // change progress color to green
		        answerIsCorrect();
		    }else{
		        // answer is wrong
		        // change progress color to red
		        answerIsWrong();
		    }
		    count = 0;
		    if(runningQuestion < lastQuestion){
		        runningQuestion++;
		        renderQuestion();
		    }else{
		        // end the quiz and show the score
		        clearInterval(TIMER);
		        scoreRender();
		    }
		}
		
		// answer is correct
		function answerIsCorrect(){
		    document.getElementById(runningQuestion).style.backgroundColor = "#0f0";
		}
		
		// answer is Wrong
		function answerIsWrong(){
		    document.getElementById(runningQuestion).style.backgroundColor = "#f00";
		}
		
		// score render
		function scoreRender(){
		    scoreDiv.style.display = "block";
		    
		    // calculate the amount of question percent answered by the user
		    const scorePerCent = Math.round(100 * score/questions.length);
		    
		    // choose the image based on the scorePerCent
		    let img = (scorePerCent >= 80) ? "img/5.png" :
		              (scorePerCent >= 60) ? "img/4.png" :
		              (scorePerCent >= 40) ? "img/3.png" :
		              (scorePerCent >= 20) ? "img/2.png" :
		              "img/1.png";
		    
		    scoreDiv.innerHTML = "<img src="+ img +">";
		    scoreDiv.innerHTML += "<p>"+ scorePerCent +"%</p>";
	        scoreDiv.innerHTML += '<button id = "replay_btn" onclick="increase_times();"  style="font-size:24px">Play Again <i class="material-icons"></i></button>';
	        var html_exit = '<button  id = "exit_btn" style="font-size:24px" onclick="exit_game();" >Exit Game <i class="fa fa-times"></i></button>';
           
	        scoreDiv.innerHTML += html_exit;
	        }

        
     //hover logo
	function hover(element) {
	  element.setAttribute('src', 'logo2.png');
	}
	
	function unhover(element) {
	  element.setAttribute('src', 'logo1.png');
	}
	
	//onload
    var back_times = localStorage.getItem('back_times');

    if(!back_times) {
    	back_times = 1;
    }
   
    //increase value
    function increase_times(){
    	
   	  localStorage.setItem('back_times', ++back_times);
    	location.reload();
    }
    //exit game
    function exit_game(){
    	localStorage.removeItem("back_times"); 
    	history.go(-back_times);
    	
    }
    </script>
</body>
</html>