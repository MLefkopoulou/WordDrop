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

/**
 * Servlet implementation class GetSpecificLists
 */
@WebServlet("/GetSpecificLists")
public class GetSpecificLists extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetSpecificLists() {
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
		response.getWriter().append("Served at: ").append(request.getContextPath());
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
			String listOwner = (String) request.getParameter("listOwner");
			if (listOwner == null) {
				listOwner = (String) session.getAttribute("username");
			}
			
			DatabaseManager db_manager = new DatabaseManager();

			
			String url;
			if (listOwner.equals((String) session.getAttribute("username"))) {
				String tag_filter = (String) request.getParameter("tag_filter");
				request.setAttribute("tag_filter", tag_filter);
				String special_tag = (String) request.getParameter("special_tag");
				request.setAttribute("special_tag", special_tag);

				if (tag_filter.equals("Languages")) {
					int split = special_tag.indexOf('-');
					String lang1 = (String) special_tag.subSequence(0, split);
					String lang2 = (String) special_tag.subSequence(split + 1, special_tag.length());
					ArrayList<UserList> all_lists = db_manager.getSpecificLanguageLists(listOwner, lang1, lang2);
					session.setAttribute("all_lists", all_lists);

				} else if (tag_filter.equals("Tag")) {
					ArrayList<UserList> all_lists = db_manager.getSpecificTagLists(listOwner, special_tag);
					session.setAttribute("all_lists", all_lists);
				}

				ArrayList<String> all_tags = db_manager.getAllTags(listOwner);
				ArrayList<String> all_languages = db_manager.getAllLanguages(listOwner);
				session.setAttribute("all_tags", all_tags);
				session.setAttribute("all_languages", all_languages);
				url = "/mylists.jsp";
			} else {
				String tag_filter = (String) request.getParameter("tag_filter");
				request.setAttribute("tag_filter_his", tag_filter);
				String special_tag = (String) request.getParameter("special_tag");
				request.setAttribute("special_tag_his", special_tag);

				if (tag_filter.equals("Languages")) {
					int split = special_tag.indexOf('-');
					String lang1 = (String) special_tag.subSequence(0, split);
					String lang2 = (String) special_tag.subSequence(split + 1, special_tag.length());
					ArrayList<UserList> all_lists = db_manager.getSpecificLanguageLists(listOwner, lang1, lang2);
					session.setAttribute("all_lists_his", all_lists);

				} else if (tag_filter.equals("Tag")) {
					ArrayList<UserList> all_lists = db_manager.getSpecificTagLists(listOwner, special_tag);
					session.setAttribute("all_lists_his", all_lists);
				}

				ArrayList<String> all_tags = db_manager.getAllTags(listOwner);
				ArrayList<String> all_languages = db_manager.getAllLanguages(listOwner);
				session.setAttribute("all_tags_his", all_tags);
				session.setAttribute("all_languages_his", all_languages);
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
