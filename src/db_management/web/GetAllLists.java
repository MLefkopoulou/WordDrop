package db_management.web;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db_management.dao.DatabaseManager;
import db_management.model.UserList;


@WebServlet("/GetAllLists")
public class GetAllLists extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetAllLists() {
		super();
		// TODO Auto-generated constructor stub
	}


	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		if (session != null) {

			String listOwner = (String) request.getParameter("listOwner");
			
			if (listOwner == null) {
				listOwner = (String) session.getAttribute("username");
			}
			DatabaseManager db_manager = new DatabaseManager();
			ArrayList<UserList> all_lists = db_manager.getAllLists(listOwner);

			
			String url;
			if (listOwner.equals((String) session.getAttribute("username"))) {
				session.setAttribute("all_lists", all_lists);
				ArrayList<String> all_tags = db_manager.getAllTags(listOwner);
				ArrayList<String> all_languages = db_manager.getAllLanguages(listOwner);
				session.setAttribute("all_tags", all_tags);
				session.setAttribute("all_languages", all_languages);
				String tag_filter = "All";
				request.setAttribute("tag_filter", tag_filter);
				String special_tag = "All";
				request.setAttribute("special_tag", special_tag);
				url = "/mylists.jsp";
			} else {
				session.setAttribute("all_lists_his", all_lists);
				ArrayList<String> all_tags = db_manager.getAllTags(listOwner);
				ArrayList<String> all_languages = db_manager.getAllLanguages(listOwner);
				session.setAttribute("all_tags_his", all_tags);
				session.setAttribute("all_languages_his", all_languages);
				String tag_filter = "All";
				request.setAttribute("tag_filter_his", tag_filter);
				String special_tag = "All";
				request.setAttribute("special_tag_his", special_tag);
				request.setAttribute("listOwner", listOwner);
				url = "/othuserlists.jsp";
			}
			getServletContext().getRequestDispatcher(url).forward(request, response);
			
		} else {
			String url = "/login.jsp";
			getServletContext().getRequestDispatcher(url).forward(request, response);
		}
	}

}
