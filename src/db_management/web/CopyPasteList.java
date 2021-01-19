package db_management.web;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db_management.dao.DatabaseManager;
import db_management.model.UserList;
import db_management.model.UserWord;

/**
 * Servlet implementation class CopyPasteList
 */
@WebServlet("/CopyPasteList")
public class CopyPasteList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CopyPasteList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if(session != null){
			DatabaseManager db_manager = new DatabaseManager();
			@SuppressWarnings("unchecked")
			ArrayList<UserWord> copy_words =(ArrayList<UserWord> )session.getAttribute("current_words");
			int list_id = Integer.parseInt(request.getParameter("current_list_id"));
			UserList copy_list =db_manager.getOneList(list_id);
			String username = request.getParameter("username");
			int user_id = db_manager.FindUserId(username);
			copy_list.setUser_id(user_id);
			copy_list.setList_id(-1);
			
			String new_list_name = request.getParameter("rename-list");
			if(!new_list_name.equals("")) {
				copy_list.setListname(new_list_name);
			}
			String new_tag_name = request.getParameter("rename-tag");
			if(!new_tag_name.equals("")) {
				copy_list.setTag(new_tag_name);
			}
			
			db_manager.AddList(copy_list);
			int new_list_id = db_manager.getLastList_id(user_id);
			System.out.println(new_list_id);
			//<img src="http://localhost:8080/UserData/<%=im_path %>"
			for(int i=0; i< copy_words.size(); i++) {
				UserWord new_word = new UserWord(copy_words.get(i).getWord1(),copy_words.get(i).getWord2(),"temp",new_list_id);
				int check = db_manager.AddWord(new_word);
				if(check == 0 ) {
					int word_id = db_manager.FindWordId(new_word);
					new_word.setWord_id(word_id);
					String exte = copy_words.get(i).getIm_path().substring(copy_words.get(i).getIm_path().lastIndexOf(".")+1);
                	if(exte.equals("empty")) {
                		String ext = ".empty";
						String im_file_name = String.valueOf(word_id) + ext;
						db_manager.changeImagePathName(new_word.getWord_id(), im_file_name);
                		
                	}
                	else {
                		String separator = System.getProperty("file.separator");
                		String path_to = getServletContext().getInitParameter("image-upload");
                		String old_im_path = path_to+separator+copy_words.get(i).getIm_path();
                		String new_im_path = path_to+separator+String.valueOf(word_id)+exte;
                		File oldFile =new File(old_im_path);
            	        File newFile =new File(new_im_path);
            	        Files.copy(oldFile.toPath(), newFile.toPath());
            	        db_manager.changeImagePathName(new_word.getWord_id(), String.valueOf(word_id)+exte);

                	}
             
				}
			}
					
					

			
			
			session.setAttribute("list_words",copy_words);
			session.setAttribute("list_id",list_id);
			session.setAttribute("usernameforlist", request.getParameter("usernameforlist"));
			String listname = request.getParameter("listname");
			request.setAttribute("listname", listname);
			
			String page_name = request.getParameter("page");
			if(page_name.equals("comm")) {
				String tag_filter = (String)session.getAttribute("tag_filter_comm");
				request.setAttribute("tag_filter", tag_filter);
				String special_tag = (String)session.getAttribute("special_tag_comm");
				request.setAttribute("special_tag", special_tag);
				String url = "/othimlist.jsp";
				getServletContext().getRequestDispatcher(url).forward(request, response);
			}else if(page_name.equals("his")){
				String listOwner = request.getParameter("listOwner");
				request.setAttribute("listOwner", listOwner);
				String tag_filter = (String)session.getAttribute("tag_filter_his");
				request.setAttribute("tag_filter_his", tag_filter);
				String special_tag = (String)session.getAttribute("special_tag_his");
				request.setAttribute("special_tag_his", special_tag);
				String url = "/othimlistFromHisProfile.jsp";
				getServletContext().getRequestDispatcher(url).forward(request, response);
			}
			
		} else {
			String url = "/login.jsp";
			getServletContext().getRequestDispatcher(url).forward(request, response);
		}
	}

}