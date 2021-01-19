package db_management.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.simple.JSONArray;

//import com.google.gson.Gson;

import db_management.dao.DatabaseManager;
//import db_management.model.FlashQuestion;
import db_management.model.UserWord;

/**
 * Servlet implementation class FlashcardsInit
 */
@WebServlet("/FlashcardsInit")
public class FlashcardsInit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FlashcardsInit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession(false);
		if (session != null) {
			int list_id = (int) session.getAttribute("list_id");
			DatabaseManager db_manager = new DatabaseManager();
			ArrayList<String> possible_choises  = db_manager.getPossibleWord1s(list_id);
			ArrayList<String> letter_choises = new ArrayList<String>() ;
			letter_choises.add("A");
			letter_choises.add("B");
			letter_choises.add("C");
			ArrayList<JSONObject> game_list = new ArrayList<JSONObject>();
			int random_element_number_1;
			int random_element_number_2;
			int main_choice;
			int right_choice;
			String word1 = "";
			String word2 = "";
			String choice_1 = "";
			String choice_2 = "";
			Random rand = new Random();
			@SuppressWarnings("unchecked")
			ArrayList<UserWord> list_words = (ArrayList<UserWord>) session.getAttribute("list_words");
			Collections.shuffle(list_words);
			for (int j = 0; j < list_words.size(); j++) {
				String imPath = list_words.get(j).getIm_path();
				String ext = imPath.substring(imPath.lastIndexOf(".") + 1);
				if( !ext.equals("empty") ) {
					word1 = list_words.get(j).getWord1();
					word2 = list_words.get(j).getWord2();
					main_choice = possible_choises.indexOf(word1);
					
					random_element_number_1 = rand.nextInt(possible_choises.size());
					random_element_number_2 =rand.nextInt(possible_choises.size());
					while((main_choice == random_element_number_1) || (main_choice == random_element_number_2) || (random_element_number_2 == random_element_number_1)) {
						random_element_number_1 = rand.nextInt(possible_choises.size());
						random_element_number_2 =rand.nextInt(possible_choises.size());
					}
					choice_1 = possible_choises.get(random_element_number_1);
					choice_2 = possible_choises.get(random_element_number_2);
					right_choice = rand.nextInt(letter_choises.size());
					JSONObject json = new JSONObject();
					try {
						json.put("question", word2);
						json.put("imgSrc",  "/UserData/" + imPath);
						if(right_choice == 0) {
							json.put("choiceA", word1);
							json.put("choiceB", choice_1);
							json.put("choiceC", choice_2);
							json.put("correct", "A");
						}else if(right_choice == 1){
							json.put("choiceA", choice_1);
							json.put("choiceB", word1);
							json.put("choiceC", choice_2);
							json.put("correct", "B");
						}else if(right_choice == 2){
							json.put("choiceA", choice_1);
							json.put("choiceB", choice_2);
							json.put("choiceC", word1);
							json.put("correct", "C");
						}
					}catch (JSONException e) {
						e.printStackTrace();
					}
					
					game_list.add(json);
				}
			}
			
			if (game_list.size() == 0) {
				String url = "/home.jsp";
				getServletContext().getRequestDispatcher(url).forward(request, response);
			}else {
				String game_questions = JSONArray.toJSONString(game_list);
	
			    response.setContentType("application/json");
			    response.setCharacterEncoding("UTF-8");
			    response.getWriter().write(game_questions);
			}
			
		} else {
			String url = "/login.html";
			getServletContext().getRequestDispatcher(url).forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		if (session != null) {
			String listname =request.getParameter("listname");
			session.setAttribute("listname", listname);
			
			String url = "/game_flashcards.jsp";
			getServletContext().getRequestDispatcher(url).forward(request, response);
			
		} else {
			String url = "/login.html";
			getServletContext().getRequestDispatcher(url).forward(request, response);
		}
	}

}
