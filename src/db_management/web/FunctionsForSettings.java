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

/**
 * Servlet implementation class FunctionsForSettings
 */
@WebServlet("/FunctionsForSettings")
public class FunctionsForSettings extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FunctionsForSettings() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		if(session != null){
			DatabaseManager dbmng = new DatabaseManager();
			String username = (String) session.getAttribute("username");
			request.setAttribute("email", dbmng.getEmail(username));
			request.setAttribute("state", "no");
			String url = "/settings.jsp";
			getServletContext().getRequestDispatcher(url).forward(request, response);
		}
		else {
			String url = "/login.jsp";
			getServletContext().getRequestDispatcher(url).forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		if (session != null) {
			if (request.getParameter("change").equals("username")) {
				changeUsername(request, response, session);
			} else if (request.getParameter("change").equals("email")) {
				changeEmail(request, response, session);
			} else if (request.getParameter("change").equals("password")) {
				changePassword(request, response, session);
			} else if (request.getParameter("change").equals("delete-account")) {
				deleteAccount(request, response, session);
			}
		} else {
			String url = "/login.jsp";
			getServletContext().getRequestDispatcher(url).forward(request, response);
		}
	}

	private void deleteAccount(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException, ServletException {
		// TODO Auto-generated method stub
		String username = (String) session.getAttribute("username");
		String password = (String) request.getParameter("password");
		DatabaseManager dbmng = new DatabaseManager();
		if (dbmng.getPassword(username).equals(password)) {
			int success = dbmng.deleteUser(username);
			if (success == 0) {
				response.setContentType("text/html");
				Cookie[] cookies = request.getCookies();
				if (cookies != null) {
					for (Cookie cookie : cookies) {
//						if (cookie.getName().equals("JSESSIONID")) {
//						}
						cookie.setMaxAge(0);
						response.addCookie(cookie);
					}
				}
				// invalidate the session if exists
				if (session != null) {
					session.invalidate();
				}
				// no encoding because we have invalidated the session
				response.sendRedirect("first-page.html");
			} else {
				request.setAttribute("state", "delete-db_fail");
				request.setAttribute("email", dbmng.getEmail(username));
				String url = "/settings.jsp";
				getServletContext().getRequestDispatcher(url).forward(request, response);
			}
		} else {
			request.setAttribute("state", "delete-wrong-password");
			request.setAttribute("email", dbmng.getEmail(username));
			String url = "/settings.jsp";
			getServletContext().getRequestDispatcher(url).forward(request, response);
		}

	}

	private void changePassword(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = (String) session.getAttribute("username");
		String oldPassword = (String) request.getParameter("oldPassword");
		String newPassword = (String) request.getParameter("newPassword");
		DatabaseManager dbmng = new DatabaseManager();
		if (dbmng.getPassword(username).equals(oldPassword)) {
			int success = dbmng.changePassword(username, newPassword);
			if (success == 0) {
				request.setAttribute("state", "password-success");
			} else {
				request.setAttribute("state", "password-fail");
			}
		} else {
			request.setAttribute("state", "password-fail");
		}
		request.setAttribute("email", dbmng.getEmail(username));

		String url = "/settings.jsp";
		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	private void changeEmail(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = (String) session.getAttribute("username");
		String newEmail = (String) request.getParameter("newEmail");
		DatabaseManager dbmng = new DatabaseManager();
		int success = dbmng.changeEmail(username, newEmail);
		if (success == 0) {
			request.setAttribute("state", "email-success");
		} else {
			request.setAttribute("state", "email-fail");
		}
		request.setAttribute("email", dbmng.getEmail(username));

		String url = "/settings.jsp";
		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

	private void changeUsername(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String oldUsername = (String) session.getAttribute("username");
		String newUsername = (String) request.getParameter("newUsername");
		DatabaseManager dbmng = new DatabaseManager();
		int success = dbmng.changeUsername(oldUsername, newUsername);
		if (success == 0) {
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("username")) {
						cookie.setValue(newUsername);
						response.addCookie(cookie);
					}
				}
			} else {
				Cookie username_cookie = new Cookie("username", newUsername);
				response.addCookie(username_cookie);
			}
			session.setAttribute("username", newUsername);
			request.setAttribute("email", dbmng.getEmail(newUsername));
			request.setAttribute("state", "username-success");
		} else {
			request.setAttribute("email", dbmng.getEmail(oldUsername));
			request.setAttribute("state", "username-fail");
		}
		String url = "/settings.jsp";
		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

}
