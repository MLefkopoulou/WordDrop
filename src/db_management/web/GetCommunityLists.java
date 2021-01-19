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
 * Servlet implementation class GetAllCommunityLists
 */
@WebServlet("/GetCommunityLists")
public class GetCommunityLists extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetCommunityLists() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
				HttpSession session = request.getSession(false);
				if(session != null){
					DatabaseManager db_manager = new DatabaseManager();
					String tag_filter = request.getParameter("tag_filter");
					request.setAttribute("tag_filter",tag_filter);
					String special_tag = request.getParameter("special_tag");
					request.setAttribute("special_tag", special_tag);
					ArrayList<UserList> community_lists = db_manager.GetCategoryCommunityLists(tag_filter,special_tag,(String)session.getAttribute("username"));
					
					session.setAttribute("community_lists",community_lists);
					ArrayList<String> community_tags = db_manager.GetCommunityTags(tag_filter,(String)session.getAttribute("username"));
					session.setAttribute("community_tags", community_tags);
					
					String url = "/commlists.jsp";
					getServletContext().getRequestDispatcher(url).forward(request, response);
				}
				else {
					String url = "/login.jsp";
					getServletContext().getRequestDispatcher(url).forward(request, response);
				}
	}

}
