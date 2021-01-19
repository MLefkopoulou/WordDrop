package db_management.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import db_management.model.User;
import db_management.model.UserList;
import db_management.model.UserWord;

public class DatabaseManager {

	public static String dburl;
	public static String dbuser;
	public static String dbpassword;
	public static String dbdriver;

	public DatabaseManager() {
		DatabaseManager.dburl = "jdbc:mysql://localhost:3306/project_db";
		DatabaseManager.dbuser = "project-user";
		DatabaseManager.dbpassword = "project";
		DatabaseManager.dbdriver = "com.mysql.jdbc.Driver";
	}

	public int saveUser(User user) {
		Connection con;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			String query = "INSERT INTO user" + "(username, password, email)" + "VALUES('" + user.getUsername() + "', '"
					+ user.getPassword() + "', '" + user.getEmail() + "')";
			s.executeUpdate(query);
			con.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (1);
		} catch (SQLException e) {
			e.printStackTrace();
			return (2);
		}
		return (0);
	}

	public String getPassword(String username) {
		Connection con;
		ResultSet rs;
		String correct = "";
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();

			rs = s.executeQuery("SELECT password FROM user WHERE username =" + "'" + username + "'");
			if (rs.next()) {
				correct = rs.getString("password");
			}

			con.close();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return ("");
		} catch (SQLException e) {
			e.printStackTrace();
			return ("");
		}
		return (correct);
	}

	public String getEmail(String username) {
		Connection con;
		ResultSet rs;
		String email = "";
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();

			rs = s.executeQuery("SELECT email FROM user WHERE username =" + "'" + username + "'");
			if (rs.next()) {
				email = rs.getString("email");
			}

			con.close();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return ("");
		} catch (SQLException e) {
			e.printStackTrace();
			return ("");
		}
		return (email);
	}

	public ArrayList<UserList> getAllLists(String username) {
		Connection con;
		ResultSet rs;
		int user_id = 0;
		ArrayList<UserList> all_list = new ArrayList<UserList>();
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			rs = s.executeQuery("SELECT user_id FROM user WHERE username =" + "'" + username + "'");
			if (rs.next()) {
				user_id = rs.getInt("user_id");
			}

			rs = s.executeQuery("SELECT list_id,listname,lang1,lang2,tag FROM list WHERE user_id =" + user_id
					+ " ORDER BY listname ASC");

			while (rs.next()) {
				UserList next_list = new UserList(rs.getString("listname"), rs.getString("lang1"),
						rs.getString("lang2"), rs.getString("tag"), user_id, rs.getInt("list_id"));
				all_list.add(next_list);
			}

			con.close();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (null);
		} catch (SQLException e) {
			e.printStackTrace();
			return (null);
		}

		return (all_list);
	}

	public int AddList(UserList newList) {
		Connection con;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			String query = "Select * from list where listname = '"+newList.getListname() +"' AND lang1 = '"+ newList.getLang1() +"' AND lang2 ='"+newList.getLang2() +"' AND tag = '"+newList.getTag()+"' AND user_id = "+newList.getUser_id();
			ResultSet rs =  s.executeQuery(query);
			if(rs.next()) {
				return (0);
			}
			query = "INSERT INTO list" + "(listname, lang1, lang2,tag,user_id)" + "VALUES('"
					+ newList.getListname() + "', '" + newList.getLang1() + "', '" + newList.getLang2() + "', '"
					+ newList.getTag() + "', '" + newList.getUser_id() + "');";
			s.executeUpdate(query);
			con.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (1);
		} catch (SQLException e) {
			e.printStackTrace();
			return (2);
		}
		return (0);

	}

	public int AddWord(UserWord newWord) {
		Connection con;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();

			String query = "INSERT INTO word" + "(word1, word2, im_path,list_id)" + "VALUES('" + newWord.getWord1()
					+ "', '" + newWord.getWord2() + "', '" + newWord.getIm_path() + "', " + newWord.getList_id() + ");";
			s.executeUpdate(query);
			con.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (1);
		} catch (SQLException e) {
			
			return (2);
		}
		return (0);

	}

	public int FindUserId(String username) {
		Connection con;
		ResultSet rs;
		int user_id = -1;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();

			rs = s.executeQuery("SELECT user_id FROM user WHERE username =" + "'" + username + "'");
			if (rs.next()) {
				user_id = rs.getInt("user_id");
			}

			con.close();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (-1);
		} catch (SQLException e) {
			e.printStackTrace();
			return (-1);
		}
		return (user_id);

	}
	
	public int FindWordId(UserWord word) {
		Connection con;
		ResultSet rs;
		int word_id = -1;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();

			rs = s.executeQuery("SELECT word_id FROM word WHERE (list_id = " + "'" + word.getList_id() + "' AND word1=" + "'" + word.getWord1() + "')");
			if (rs.next()) {
				word_id = rs.getInt("word_id");
			}

			con.close();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (-1);
		} catch (SQLException e) {
			e.printStackTrace();
			return (-1);
		}
		return (word_id);

	}

	public ArrayList<String> getAllTags(String username) {
		Connection con;
		ResultSet rs;
		String tag = "";
		ArrayList<String> all_tags = new ArrayList<String>();
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();

			rs = s.executeQuery("SELECT DISTINCT tag  FROM user,list WHERE username = '" + username
					+ "' AND user.user_id =list.user_id ORDER BY tag ASC");
			while (rs.next()) {
				tag = rs.getString("tag");
				all_tags.add(tag);
			}

			con.close();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (null);
		} catch (SQLException e) {
			e.printStackTrace();
			return (null);
		}
		return (all_tags);

	}

	public ArrayList<String> getAllLanguages(String username) {
		Connection con;
		ResultSet rs;
		String languages = "";
		ArrayList<String> all_languages = new ArrayList<String>();
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();

			rs = s.executeQuery("SELECT DISTINCT lang1,lang2 FROM user,list WHERE username = '" + username
					+ "' AND user.user_id =list.user_id ORDER BY lang1 ASC");
			while (rs.next()) {
				languages = rs.getString("lang1") + "-" + rs.getString("lang2");
				all_languages.add(languages);
			}

			con.close();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (null);
		} catch (SQLException e) {
			e.printStackTrace();
			return (null);
		}
		return (all_languages);

	}

	public ArrayList<UserWord> getWords(int list_id) {
		Connection con;
		ResultSet rs;
		ArrayList<UserWord> list_words = new ArrayList<UserWord>();
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			rs = s.executeQuery("SELECT * FROM word WHERE list_id =" + list_id);

			while (rs.next()) {
				UserWord next_word = new UserWord(rs.getInt("word_id"),rs.getString("word1"), rs.getString("word2"), rs.getString("im_path"),
						rs.getInt("list_id"));
				list_words.add(next_word);
			}

			con.close();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (null);
		} catch (SQLException e) {
			e.printStackTrace();
			return (null);
		}

		return (list_words);
	}
	
	public ArrayList<UserWord> getWordsbyOldest(int list_id) {
		Connection con;
		ResultSet rs;
		ArrayList<UserWord> list_words = new ArrayList<UserWord>();
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			rs = s.executeQuery("SELECT * FROM word WHERE list_id =" + list_id + " ORDER BY word_id ASC");

			while (rs.next()) {
				UserWord next_word = new UserWord(rs.getInt("word_id"),rs.getString("word1"), rs.getString("word2"), rs.getString("im_path"),
						rs.getInt("list_id"));
				list_words.add(next_word);
			}

			con.close();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (null);
		} catch (SQLException e) {
			e.printStackTrace();
			return (null);
		}

		return (list_words);
	}
	
	public ArrayList<UserWord> getWordsbyNewest(int list_id) {
		Connection con;
		ResultSet rs;
		ArrayList<UserWord> list_words = new ArrayList<UserWord>();
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			rs = s.executeQuery("SELECT * FROM word WHERE list_id =" + list_id + " ORDER BY word_id DESC");

			while (rs.next()) {
				UserWord next_word = new UserWord(rs.getInt("word_id"),rs.getString("word1"), rs.getString("word2"), rs.getString("im_path"),
						rs.getInt("list_id"));
				list_words.add(next_word);
			}

			con.close();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (null);
		} catch (SQLException e) {
			e.printStackTrace();
			return (null);
		}

		return (list_words);
	}

	public ArrayList<UserList> getSpecificLanguageLists(String username, String lang1, String lang2) {
		Connection con;
		ResultSet rs;
		int user_id = 0;
		ArrayList<UserList> laguage_lists = new ArrayList<UserList>();
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			rs = s.executeQuery("SELECT user_id FROM user WHERE username =" + "'" + username + "'");
			if (rs.next()) {
				user_id = rs.getInt("user_id");
			}
			rs = s.executeQuery("SELECT list_id,listname,lang1,lang2,tag FROM list WHERE user_id =" + user_id
					+ " AND lang1 = '" + lang1 + "' AND lang2='" + lang2 + "' ORDER BY listname ASC");
			while (rs.next()) {
				UserList next_list = new UserList(rs.getString("listname"), rs.getString("lang1"),
						rs.getString("lang2"), rs.getString("tag"), user_id, rs.getInt("list_id"));
				laguage_lists.add(next_list);
			}
			con.close();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (null);
		} catch (SQLException e) {
			e.printStackTrace();
			return (null);
		}

		return (laguage_lists);
	}

	public ArrayList<UserList> getSpecificTagLists(String username, String tag) {
		Connection con;
		ResultSet rs;
		int user_id = 0;
		ArrayList<UserList> tag_lists = new ArrayList<UserList>();
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			rs = s.executeQuery("SELECT user_id FROM user WHERE username =" + "'" + username + "'");
			if (rs.next()) {
				user_id = rs.getInt("user_id");
			}
			rs = s.executeQuery("SELECT list_id,listname,lang1,lang2,tag FROM list WHERE user_id =" + user_id
					+ " AND  tag='" + tag + "' ORDER BY listname ASC");
			while (rs.next()) {
				UserList next_list = new UserList(rs.getString("listname"), rs.getString("lang1"),
						rs.getString("lang2"), rs.getString("tag"), user_id, rs.getInt("list_id"));
				tag_lists.add(next_list);
			}
			con.close();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (null);
		} catch (SQLException e) {
			e.printStackTrace();
			return (null);
		}

		return (tag_lists);
	}

	public int changeUsername(String oldUsername, String newUsername) {
		Connection con;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();

			String query = "UPDATE user SET username = '" + newUsername + "' WHERE (username = '" + oldUsername + "');";
			s.executeUpdate(query);
			con.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (1);
		} catch (SQLException e) {
			e.printStackTrace();
			return (2);
		}
		return (0);
	}
	
	public int changeEmail(String username, String newEmail) {
		Connection con;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();

			String query = "UPDATE user SET email = '" + newEmail + "' WHERE (username = '" + username + "');";
			s.executeUpdate(query);
			con.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (1);
		} catch (SQLException e) {
			e.printStackTrace();
			return (2);
		}
		return (0);
	}
	
	public int changePassword(String username, String newPassword) {
		Connection con;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();

			String query = "UPDATE user SET password = '" + newPassword + "' WHERE (username = '" + username + "');";
			s.executeUpdate(query);
			con.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (1);
		} catch (SQLException e) {
			e.printStackTrace();
			return (2);
		}
		return (0);
	}
	
	public int deleteUser(String username) {
		Connection con;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();

			String query = "DELETE FROM user WHERE (username = '" + username + "');";
			s.executeUpdate(query);
			con.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (1);
		} catch (SQLException e) {
			e.printStackTrace();
			return (2);
		}
		return (0);
	}
	
	public int changeImagePathName(int word_id, String imPath) {
		Connection con;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();

			String query = "UPDATE word SET im_path = '" + imPath + "' WHERE word_id = "+word_id;
			s.executeUpdate(query);
			con.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (1);
		} catch (SQLException e) {
			e.printStackTrace();
			return (2);
		}
		return (0);
	}
	public ArrayList<String> getCommunityCategories(String username) {
		
		Connection con;
		ResultSet rs;
		String categories = "";
		ArrayList<String> all_community = new ArrayList<String>();
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			rs = s.executeQuery("SELECT user_id FROM user WHERE username =" + "'" + username + "'");
			int user_id =-1;
			if (rs.next()) {
				user_id = rs.getInt("user_id");
			}
			rs = s.executeQuery("SELECT DISTINCT lang1,lang2 FROM list WHERE user_id !=" +user_id +" ORDER BY lang1 ASC");
			while (rs.next()) {
				categories = rs.getString("lang1") + "-" + rs.getString("lang2");
				all_community.add(categories);
			}

			con.close();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (null);
		} catch (SQLException e) {
			e.printStackTrace();
			return (null);
		}
		return (all_community);
	}
	
	public ArrayList<UserList> GetCategoryCommunityLists(String lang,String tag,String username) {
		Connection con;
		ResultSet rs;
		ArrayList<UserList> category_lists = new ArrayList<UserList>();
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			int split = lang.indexOf('-');
			String lang1 =	(String) lang.subSequence(0,split);
			String lang2 =	(String) lang.subSequence(split+1,lang.length());
			String query;
			if(lang.equals(tag)) {
				query = "SELECT user.username ,list.* from user,list where user.username != '"+username+"' AND user.user_id=list.user_id AND  lang1 = '" + lang1 + "' AND lang2='" + lang2 + "' ORDER BY listname ASC";
				rs = s.executeQuery(query);
			}
			else {
				query = "SELECT user.username ,list.* from user,list where user.username != '"+username+"' AND user.user_id=list.user_id AND lang1 = '" + lang1 + "' AND lang2='" + lang2 + "' AND tag = '"+tag+"' ORDER BY listname ASC";
				rs = s.executeQuery(query);
				}
			while (rs.next()) {
				UserList next_list = new UserList(rs.getString("listname"), rs.getString("lang1"),
				rs.getString("lang2"), rs.getString("tag"), rs.getInt("user_id"), rs.getInt("list_id"));
				category_lists.add(next_list);
			}
			con.close();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (null);
		} catch (SQLException e) {
			e.printStackTrace();
			return (null);
		}

		return (category_lists);
		
		
	}
	
	public ArrayList<String> GetCommunityTags(String lang,String username) {
		Connection con;
		ResultSet rs;
		ArrayList<String> community_tag = new ArrayList<String>();
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			rs = s.executeQuery("SELECT user_id FROM user WHERE username =" + "'" + username + "'");
			int user_id =-1;
			if (rs.next()) {
				user_id = rs.getInt("user_id");
			}
			int split = lang.indexOf('-');
			String lang1 =	(String) lang.subSequence(0,split);
			String lang2 =	(String) lang.subSequence(split+1,lang.length());
			String query = "SELECT DISTINCT tag FROM list WHERE user_id != "+user_id+" AND lang1 = '" + lang1 + "' AND lang2='" + lang2 + "' ORDER BY tag ASC";
			rs = s.executeQuery(query);
			while (rs.next()) {
				String next_list = rs.getString("tag");
				community_tag.add(next_list);
			}
			con.close();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (null);
		} catch (SQLException e) {
			e.printStackTrace();
			return (null);
		}

		return (community_tag);
	}
	
	public  UserList  getOneList(int list_id) {
		Connection con;
		ResultSet rs;
		UserList one_list= new UserList();
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			String query = "SELECT * from list where list_id = "+list_id;
			rs = s.executeQuery(query);
			if (rs.next()) {
				one_list = new UserList((String) rs.getString("listname") , (String)  rs.getString("lang1") , (String)  rs.getString("lang2"), (String)  rs.getString("tag"), (int)  rs.getInt("user_id"), (int)rs.getInt("list_id"));
				con.close();
				return(one_list);
			}
			else {
				con.close();
			}
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			
		} catch (SQLException e) {
			e.printStackTrace();
		
			
		}
		return (one_list);
	}
	
	public int getLastList_id(int user_id) {
		Connection con;
		ResultSet rs;
		int last_list_id =-1;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			String query = "SELECT list_id FROM list WHERE user_id = "+user_id+" ORDER BY list_id DESC";
			rs = s.executeQuery(query);
			if (rs.next()) {
				last_list_id = rs.getInt("list_id");
				con.close();
				return(last_list_id);
			}
			else {
				con.close();
			}
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			
		} catch (SQLException e) {
			e.printStackTrace();
		
			
		}
		return (last_list_id);
	}
	
	public int renameList(int list_id,String new_listname) {
		Connection con;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			String query = "UPDATE list SET listname = '"+new_listname+"' where list_id = "+list_id;
		
			 s.executeUpdate(query);
			 con.close();
		     return (0);
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (-1);
			
		} catch (SQLException e) {
			e.printStackTrace();	return (-1);
		}
		
	}
	
	public int deleteList(int list_id) {
		Connection con;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			String query = "DELETE from list where list_id = "+list_id;
		
			 s.executeUpdate(query);
			 con.close();
		     return (0);
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (-1);
			
		} catch (SQLException e) {
			e.printStackTrace();	return (-1);
		}
		
	}
	
	public int deleteWord(int word_id) {
		Connection con;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			String query = "DELETE from word where word_id = "+word_id;
		
			 s.executeUpdate(query);
			 con.close();
		     return (0);
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (-1);
			
		} catch (SQLException e) {
			e.printStackTrace();	return (-1);
		}
		
	}
	
	public ArrayList<String>  getImagePathsForDelete(int list_id) {
		Connection con;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			String query = "Select im_path from word where list_id = "+list_id;
		
			 ResultSet rs= s.executeQuery(query);
			 ArrayList<String> im_paths_delete = new ArrayList<String>();
			 while(rs.next()) {
				 
				 im_paths_delete.add(rs.getString("im_path"));
			 }
			 con.close();
		     return (im_paths_delete);
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (null);
			
		} catch (SQLException e) {
			e.printStackTrace();	return (null);
		}
	}
	
	public int UpdateWord(int word_id,String word1,String word2) {
		Connection con;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			String query;
			if(!word1.equals("")) {
				query = "UPDATE word SET word1='"+word1+"' WHERE word_id='"+word_id+"'";
				s.executeUpdate(query);
			}
			if(!word2.equals("")) {
				query = "UPDATE word SET word2='"+word2+"' WHERE word_id='"+word_id+"'";
				s.executeUpdate(query);
			}
			 
			 con.close();
		     return (0);
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (-1);
			
		} catch (SQLException e) {
			e.printStackTrace();	return (-1);
		}
		
	}
	
	public String findUser(int user_id) {
		Connection con;
		ResultSet rs;
		String username = "";
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();

			rs = s.executeQuery("SELECT username FROM user WHERE user_id =" + user_id);
			if (rs.next()) {
				username = rs.getString("username");
			}

			con.close();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return ("exceptionFindingUserfromId");
		} catch (SQLException e) {
			e.printStackTrace();
			return ("exceptionFindingUserfromId");
		}
		return (username);

	}
	//////////////////////
	public ArrayList<String> getPossibleChoices(int list_id){
		Connection con;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			String query = "Select word2 from word where list_id = "+list_id;
		
			 ResultSet rs= s.executeQuery(query);
			 ArrayList<String> possible_choices = new ArrayList<String>();
			 while(rs.next()) {
				 
				 possible_choices.add(rs.getString("word2"));
			 }
			 con.close();
		     return (possible_choices);
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (null);
			
		} catch (SQLException e) {
			e.printStackTrace();	return (null);
		}
		
	}
	
	public ArrayList<String> getPossibleWord1s(int list_id){
		Connection con;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			String query = "Select word1 from word where list_id = "+list_id;
		
			 ResultSet rs= s.executeQuery(query);
			 ArrayList<String> possible_choices = new ArrayList<String>();
			 while(rs.next()) {
				 
				 possible_choices.add(rs.getString("word1"));
			 }
			 con.close();
		     return (possible_choices);
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (null);
			
		} catch (SQLException e) {
			e.printStackTrace();	return (null);
		}
		
	}
	
	public int isThereImage(int list_id){
		Connection con;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			String query = "Select im_path from word where list_id = "+list_id;
		
			 ResultSet rs= s.executeQuery(query);
			 ArrayList<String> possible_choices = new ArrayList<String>();
			 while(rs.next()) {
				 String im_path = rs.getString("im_path");
				 String ext = im_path.substring(im_path.lastIndexOf(".") + 1);
				 if( !ext.equals("empty") ) {
					 con.close();
					 return(1);
				 }
			 }
			 con.close();
			 
		     return (0);
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (-1);
			
		} catch (SQLException e) {
			e.printStackTrace();	return (-1);
		}
		
	}
	
	public int changeListTag(int list_id,String new_tag) {
		Connection con;
		try {
			Class.forName(dbdriver);

			con = DriverManager.getConnection(dburl, dbuser, dbpassword);
			Statement s = con.createStatement();
			String query = "UPDATE list SET tag = '"+new_tag+"' where list_id = "+list_id;
		
			 s.executeUpdate(query);
			 con.close();
		     return (0);
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return (-1);
			
		} catch (SQLException e) {
			e.printStackTrace();	return (-1);
		}
		
	}
	

}