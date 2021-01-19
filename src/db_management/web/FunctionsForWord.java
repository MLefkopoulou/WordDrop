package db_management.web;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import db_management.dao.DatabaseManager;
import db_management.model.UserWord;

/**
 * Servlet implementation class FunctionsForWord
 */
@WebServlet("/FunctionsForWord")
@MultipartConfig
public class FunctionsForWord extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FunctionsForWord() {
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
		int list_id =-1;
		HttpSession session = request.getSession(false);
		if(session!=null) {
			list_id = Integer.parseInt(request.getParameter("list_id"));
			if(request.getParameter("action_to_do").equals("add")){	
				addNewWord(request,response,list_id,session);	
			}else if (request.getParameter("action_to_do").equals("delete")) {
				deleteWord(request,response,list_id,session);
				
			}else if (request.getParameter("action_to_do").equals("change")) {
				updateWord(request,response,list_id,session);
			}
			DatabaseManager db = new DatabaseManager();
			ArrayList<UserWord> list_words = db.getWords(list_id);
			session.setAttribute("list_words",list_words);
			
			String listname = request.getParameter("listname");
			request.setAttribute("listname", listname);
			String special_tag = (String)session.getAttribute("special_tag");
			request.setAttribute("special_tag", special_tag);
			String url = "/ownimlist.jsp";
			getServletContext().getRequestDispatcher(url).forward(request, response);
		
		} else {
			String url = "/login.jsp";
			getServletContext().getRequestDispatcher(url).forward(request, response);
		}
	}
	
	
	public void addNewWord(HttpServletRequest request, HttpServletResponse response,int list_id,HttpSession session) throws ServletException, IOException {
		String word1 = (String)request.getParameter("word1");
		String word2 = (String) request.getParameter("word2");
		
		
		UserWord new_word = new UserWord(word1,word2,"temp",list_id);
		DatabaseManager db = new DatabaseManager();
		int check = db.AddWord(new_word);
		if(check == 0 ) {
			int word_id = db.FindWordId(new_word);
			new_word.setWord_id(word_id);
			if (word_id != -1) {
				
				Part filePart =request.getPart("image");
				if (filePart.getSize()>0) {
					
					String ext=filePart.getContentType();
					ext="."+ext.substring(ext.lastIndexOf("/")+1);
					String im_file_name = String.valueOf(word_id) + ext;
					//InputStream fileContent = filePart.getInputStream();
					File realPath = new File(getServletContext().getInitParameter("image-upload"));
					File newFile = new File(realPath, im_file_name);

					try (InputStream input = filePart.getInputStream()) {
						Files.copy(input, newFile.toPath());
					}
					db.changeImagePathName(new_word.getWord_id(), im_file_name);
				} else {
					String ext = ".empty";
					String im_file_name = String.valueOf(word_id) + ext;
					db.changeImagePathName(new_word.getWord_id(),im_file_name);
				}
			}
		}

	}
	public void deleteWord(HttpServletRequest request, HttpServletResponse response,int list_id,HttpSession session) throws ServletException, IOException {
		String word_id_string = request.getParameter("word_id");
		word_id_string = word_id_string.substring(0, word_id_string.lastIndexOf('-'));
		int word_id = Integer.parseInt(word_id_string);
		String im_path = (String) request.getParameter("im_path");
		DatabaseManager db = new DatabaseManager();
		int check = db.deleteWord(word_id);
		if(check == 0 ) {
			String exte = im_path.substring(im_path.lastIndexOf(".")+1);
        	if(exte.equals("empty")) {
        		//no file to delete
        	}
        	else {
        		String separator = System.getProperty("file.separator");
        		String path_to = getServletContext().getInitParameter("image-upload");
        		String real_im_path = path_to+separator+im_path;
        		File deleteFile =new File(real_im_path);
        		deleteFile.delete();
        	}
			
		}
	}
	
	public void updateWord(HttpServletRequest request, HttpServletResponse response,int list_id,HttpSession session) throws ServletException, IOException {
		String word1 = (String)request.getParameter("word1");
		String word2 = (String) request.getParameter("word2");
		int word_id = Integer.parseInt(request.getParameter("word_id"));
		String im_path = (String) request.getParameter("im_path");
		
		DatabaseManager db = new DatabaseManager();
		db.UpdateWord(word_id, word1, word2);
		Part filePart = request.getPart("image");
		if(!im_path.substring(im_path.lastIndexOf('.')+1).equals("empty")){
			if (filePart.getSize()>0) {
					String separator = System.getProperty("file.separator");
	        		String path_to = getServletContext().getInitParameter("image-upload");
	        		String real_im_path = path_to+separator+im_path;
	        		File deleteFile =new File(real_im_path);
	        		deleteFile.delete();
			}
		}
		
		if (filePart.getSize()>0) {
			String ext=filePart.getContentType();
			ext="."+ext.substring(ext.lastIndexOf("/")+1);
			String im_file_name = word_id + ext;
			//InputStream fileContent = filePart.getInputStream();
			File realPath = new File(getServletContext().getInitParameter("image-upload"));
			File newFile = new File(realPath, im_file_name);

			try (InputStream input = filePart.getInputStream()) {
				Files.copy(input, newFile.toPath());
			}
			if(!im_file_name.equals(im_path)) {
				db.changeImagePathName(word_id, im_file_name);
			}
		}
	}

}