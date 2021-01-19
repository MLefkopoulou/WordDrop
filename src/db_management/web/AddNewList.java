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
 * Servlet implementation class AddNewList
 */
@WebServlet("/AddNewList")
public class AddNewList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddNewList() {
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
		// TODO Auto-generated method stub
		int user_id =-1;
		HttpSession session = request.getSession(false);
		if(session!=null) {
			user_id = (int) session.getAttribute("user_id");
		
			String listname = request.getParameter("list_name");
			String lang1 =  request.getParameter("lang_1");
			String lang2 =request.getParameter("lang_2");
			String tag =  request.getParameter("tag");
			
	
			UserList new_list = new UserList(listname,lang1,lang2,tag,user_id,-1);
			DatabaseManager db = new DatabaseManager();
			int check = db.AddList(new_list);
			if(check == 0 ) {
				ArrayList<UserList> all_lists = db.getAllLists((String)session.getAttribute("username"));
				session.setAttribute("all_lists",all_lists);
				ArrayList<String> all_tags = db.getAllTags((String)session.getAttribute("username"));
				ArrayList<String> all_languages = db.getAllLanguages((String)session.getAttribute("username"));
				session.setAttribute("all_tags", all_tags);
				session.setAttribute("all_languages", all_languages);
				String tag_filter =(String) session.getAttribute("tag");
				request.setAttribute("tag",tag_filter);
				String url = "/mylists.jsp";
				getServletContext().getRequestDispatcher(url).forward(request, response);
			}
		}else {
			String url = "/login.jsp";
			getServletContext().getRequestDispatcher(url).forward(request, response);
		}
	}

}
