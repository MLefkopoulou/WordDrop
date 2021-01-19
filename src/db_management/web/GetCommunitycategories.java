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

/**
 * Servlet implementation class GetCommunitycategories
 */
@WebServlet("/GetCommunitycategories")
public class GetCommunitycategories extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetCommunitycategories() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		if(session != null){
    		
    
		DatabaseManager db_manager = new DatabaseManager();
		ArrayList<String> all_community = db_manager.getCommunityCategories((String)session.getAttribute("username"));
		session.setAttribute("all_community",all_community);
		
		String tag_filter = "AllCommunity";
		request.setAttribute("tag_filter",tag_filter);
		String special_tag = "AllCommunity";
		request.setAttribute("special_tag", special_tag);
		String url = "/community.jsp";
		getServletContext().getRequestDispatcher(url).forward(request, response);
		}
		else {
			String url = "/login.jsp";
			getServletContext().getRequestDispatcher(url).forward(request, response);
		}
	}

}
