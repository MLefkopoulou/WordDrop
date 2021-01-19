package db_management.model;

public class CommunityList {
	protected String listname;
	protected String lang1;
	protected String lang2;
	protected String tag;
	protected String username;
	protected int user_id;
	protected int list_id;
	
	public CommunityList(){
		this.listname = "";
		this.lang1 = "";
		this.lang2 = "";
		this.tag = "";
		username="";
		this.user_id = 0;
		this.list_id = 0;
	}
	public CommunityList(String listname, String lang1, String lang2, String tag,String username, int user_id, int list_id) {
		super();
		this.listname = listname;
		this.lang1 = lang1;
		this.lang2 = lang2;
		this.tag = tag;
		this.username = username;
		this.user_id = user_id;
		this.list_id = list_id;
	}
	public String getListname() {
		return listname;
	}
	public void setListname(String listname) {
		this.listname = listname;
	}
	public String getLang1() {
		return lang1;
	}
	public void setLang1(String lang1) {
		this.lang1 = lang1;
	}
	public String getLang2() {
		return lang2;
	}
	public void setLang2(String lang2) {
		this.lang2 = lang2;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int use_id) {
		this.user_id = use_id;
	}
	public int getList_id() {
		return list_id;
	}
	public void setList_id(int list_id) {
		this.list_id = list_id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	
	
}