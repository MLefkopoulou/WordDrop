package db_management.web;



import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db_management.dao.DatabaseManager;

import db_management.model.User;


/**
 * Servlet implementation class AddProduct
 */
@WebServlet("/SignUpUser.do")
public class SignUpUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignUpUser() {
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
		String email = request.getParameter("email");
		User newUser = new User(username, password, email);
		DatabaseManager manager = new DatabaseManager();
		int check = 0;
		check = manager.saveUser(newUser);
		if(check == 1 || check ==2) {
			request.setAttribute("error_message_sign_up", "error_username");
            String url = "/signup.jsp";
            getServletContext().getRequestDispatcher(url).forward(request, response);
        }
        else {
        	HttpSession session = request.getSession();
			session.setAttribute("username", username);
			
			DatabaseManager db = new DatabaseManager();
			int user_id = db.FindUserId(username);
			session.setAttribute("user_id", user_id);
			
			Cookie username_cookie = new Cookie("username", username);
			response.addCookie(username_cookie);
			response.sendRedirect("home.jsp");
        }
	}

}


