package db_management.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.simple.JSONArray;

import db_management.model.UserWord;

/**
 * Servlet implementation class Classic_review_servlet
 */
@WebServlet("/Classic_review_servlet")
public class Classic_review_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Classic_review_servlet() {
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
		HttpSession session = request.getSession(false);
		if(session != null){
			String listname =request.getParameter("listname");
			session.setAttribute("listname", listname);
			@SuppressWarnings("unchecked")
			ArrayList<UserWord> list_words = (ArrayList<UserWord>) session.getAttribute("list_words");
			Collections.shuffle(list_words);
			
			ArrayList<JSONObject> game_list = new ArrayList<JSONObject>();
			ArrayList<JSONObject> game_list_reverse = new ArrayList<JSONObject>();
			String word1 = "";
			String word2 = "";
			
			for (int j = 0; j < list_words.size(); j++) {
				word1 = list_words.get(j).getWord1();
				word2 = list_words.get(j).getWord2();

				JSONObject json = new JSONObject();
				JSONObject json_reverse = new JSONObject();
				try {
					json.put("question", word1);
					json.put("correct", word2);	
					json.put("imgSrc",  "img/que.jpg");
					json_reverse.put("question", word2);
					json_reverse.put("correct", word1);	
					json_reverse.put("imgSrc",  "img/que.jpg");
					
				}catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				game_list.add(json);
				game_list_reverse.add(json_reverse);
				
			}
		
			
			String game_questions = JSONArray.toJSONString(game_list);
			session.setAttribute("game_questions",game_questions);
			String game_questions_reverse = JSONArray.toJSONString(game_list_reverse);
			session.setAttribute("game_questions_reverse",game_questions_reverse);
			String url = "/Classic_review.jsp";
			
			getServletContext().getRequestDispatcher(url).forward(request, response);
		}
		else {
			String url = "/login.jsp";
			getServletContext().getRequestDispatcher(url).forward(request, response);
		}
		
		
		
	}

}
