package db_management.web;

import java.io.IOException;

//import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db_management.dao.DatabaseManager;


/**
 * Servlet implementation class AddProduct
 */
@WebServlet("/LogInUser.do")
public class LogInUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogInUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");		
		//User newUser = new User(username, password, null);
		DatabaseManager manager = new DatabaseManager();
		String correct_password = "";
		
		
		correct_password = manager.getPassword(username);
		if(correct_password.equals("")) {
			request.setAttribute("error_message", "error_username");
            String url = "/login.jsp";
            getServletContext().getRequestDispatcher(url).forward(request, response);
        }
        else {
        	if(correct_password.equals(password)) {
        			
        			HttpSession session = request.getSession();
        			session.setAttribute("username", username);
        			
        			DatabaseManager db = new DatabaseManager();
        			int user_id = db.FindUserId(username);
        			session.setAttribute("user_id", user_id);
        			
        			Cookie username_cookie = new Cookie("username", username);
        			response.addCookie(username_cookie);
        			
        			response.sendRedirect("home.jsp");

        	}
        	else {
        		request.setAttribute("error_message", "error_password");
        		String url = "/login.jsp";
                getServletContext().getRequestDispatcher(url).forward(request, response);
        	}
            
        }
	}

}



