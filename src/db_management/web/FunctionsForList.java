package db_management.web;

import java.io.File;
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
@WebServlet("/FunctionsForList")
public class FunctionsForList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FunctionsForList() {
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
				
			
			if(request.getParameter("action_to_do").equals("add")){
				addNewList(request,response,user_id,session);
			}
			else {
				int check = -1;
				if(request.getParameter("action_to_do").equals("rename")){
					check = RenameList(request,response,session);
				}else if(request.getParameter("action_to_do").equals("change")){
					check = changeTagList(request,response,session);
				}
				else if(request.getParameter("action_to_do").equals("delete")){
					check = DeleteList(request,response,session);
				}
				if(check == 0 ) {
					DatabaseManager db = new DatabaseManager();
					String username = (String)session.getAttribute("username");
					String tag_filter = (String)session.getAttribute("tag_filter");				
					String special_tag = (String)session.getAttribute("special_tag");
					
					ArrayList<String> all_tags = db.getAllTags((String)session.getAttribute("username"));
					ArrayList<String> all_languages = db.getAllLanguages((String)session.getAttribute("username"));
					session.setAttribute("all_tags", all_tags);
					session.setAttribute("all_languages", all_languages);
					if(tag_filter.equals("Languages")){
						if(all_languages.contains(special_tag)) {
							request.setAttribute("tag_filter", tag_filter);
							request.setAttribute("special_tag", special_tag);
						}
						else {
							tag_filter="All";
							special_tag ="All";
							request.setAttribute("tag_filter", tag_filter);
							request.setAttribute("special_tag", special_tag);
						}
					}
					else if(tag_filter.equals("Tag")){
						if(all_tags.contains(special_tag)) {
							request.setAttribute("tag_filter", tag_filter);
							request.setAttribute("special_tag", special_tag);
						}
						else {
							tag_filter="All";
							special_tag ="All";
							request.setAttribute("tag_filter", tag_filter);
							request.setAttribute("special_tag", special_tag);
						}
					}else {
						request.setAttribute("tag_filter", tag_filter);
						request.setAttribute("special_tag", special_tag);
						
					}
					
					if(tag_filter.equals("Languages")){
						int split = special_tag.indexOf('-');
						String lang1 =	(String) special_tag.subSequence(0,split);
						String lang2 =	(String) special_tag.subSequence(split+1,special_tag.length());
						ArrayList<UserList> all_lists = db.getSpecificLanguageLists(username,lang1,lang2);
						session.setAttribute("all_lists",all_lists);
						
					}else if(tag_filter.equals("Tag")){
						ArrayList<UserList> all_lists = db.getSpecificTagLists(username,special_tag);
						session.setAttribute("all_lists",all_lists);
					}else if (tag_filter.equals("All")) {
						ArrayList<UserList> all_lists = db.getAllLists((String)session.getAttribute("username"));
						session.setAttribute("all_lists",all_lists);
						
					}
					
					String url = "/mylists.jsp";
					getServletContext().getRequestDispatcher(url).forward(request, response);
				}
			}
		}else {
			String url = "/login.jsp";
			getServletContext().getRequestDispatcher(url).forward(request, response);
		}
	}

	public void addNewList(HttpServletRequest request, HttpServletResponse response,int user_id,HttpSession session) throws ServletException, IOException {
		String listname = (String)request.getParameter("list_name");
		String lang1 = (String) request.getParameter("lang_1");
		String lang2 = (String)request.getParameter("lang_2");
		String tag = (String) request.getParameter("tag");

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
			request.setAttribute("tag_filter","All");
			request.setAttribute("special_tag","All");
			
			String url = "/mylists.jsp";
			getServletContext().getRequestDispatcher(url).forward(request, response);
		}
	}
	public int RenameList(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws ServletException, IOException {
		int list_id = Integer.parseInt(request.getParameter("list_id"));
		String new_listname = (String) request.getParameter("new_listname");
		DatabaseManager db = new DatabaseManager();
		int check = db.renameList(list_id, new_listname);
		return(check);
	}
	public int changeTagList(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws ServletException, IOException {
		String list_id_string = request.getParameter("list_id");
		list_id_string = list_id_string.substring(0, list_id_string.lastIndexOf('+'));
		int list_id = Integer.parseInt(list_id_string);
		String new_tag = (String) request.getParameter("new_tag");
		DatabaseManager db = new DatabaseManager();
		int check = db.changeListTag(list_id, new_tag);
		return(check);
	}
	public int DeleteList(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws ServletException, IOException {
		String list_id_string = request.getParameter("list_id");
		list_id_string = list_id_string.substring(0, list_id_string.lastIndexOf('-'));
		int list_id = Integer.parseInt(list_id_string);
		DatabaseManager db = new DatabaseManager();
		ArrayList<String> im_paths_delete = db.getImagePathsForDelete(list_id);
		if(im_paths_delete != null) {
			for(int i =0; i< im_paths_delete.size(); i++) {
				String exte = im_paths_delete.get(i).substring(im_paths_delete.get(i).lastIndexOf(".")+1);
	        	if(exte.equals("empty")) {
	        		//no file to delete
	        	}
	        	else {
	        		String separator = System.getProperty("file.separator");
	        		String path_to = getServletContext().getInitParameter("image-upload");
	        		String real_im_path = path_to+separator+im_paths_delete.get(i);
	        		File deleteFile =new File(real_im_path);
	        		deleteFile.delete();
	        	}
				
			}
			
			im_paths_delete.removeAll(im_paths_delete);
		}
		int check = db.deleteList(list_id);
		return(check);
	}
}
