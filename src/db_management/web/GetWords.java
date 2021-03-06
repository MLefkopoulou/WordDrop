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

import db_management.model.UserWord;

/**
 * Servlet implementation class GetWords
 */
@WebServlet("/GetWords.do")
public class GetWords extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetWords() {
        super();
        // TODO Auto-generated constructor stub
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		HttpSession session = request.getSession(false);
		if(session != null){
    		
		String listOwner = (String) request.getParameter("listOwner");
		
		DatabaseManager db_manager = new DatabaseManager();
		
		int list_id = Integer.parseInt( request.getParameter("list_id"));
		
		String sort = (String) request.getParameter("sort");
		ArrayList<UserWord> list_words;
		if (sort != null) {
			if (sort.equals("old")) {
				list_words = db_manager.getWordsbyOldest(list_id);
			} else if (sort.equals("new")) {
				list_words = db_manager.getWordsbyNewest(list_id);
			} else {
				list_words = db_manager.getWords(list_id);
			}
		} else {
			list_words = db_manager.getWords(list_id);
		}
		
		session.setAttribute("list_words",list_words);
		session.setAttribute("list_id",list_id);
		String listname = request.getParameter("listname");
		request.setAttribute("listname", listname);
		
		String url;
		if (listOwner != null ) {

			String special_tag = (String)session.getAttribute("special_tag_his");
			request.setAttribute("special_tag_his", special_tag);
			request.setAttribute("listOwner", listOwner);
			url = "/othimlistFromHisProfile.jsp";
		} else {

			String special_tag = (String)session.getAttribute("special_tag");
			request.setAttribute("special_tag", special_tag);
			url = "/ownimlist.jsp";
		}
		getServletContext().getRequestDispatcher(url).forward(request, response);
		}
		else {
			String url = "/login.jsp";
			getServletContext().getRequestDispatcher(url).forward(request, response);
		}
		
	}

}