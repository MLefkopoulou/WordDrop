package db_management.model;

public class UserWord {
	protected int word_id;
	protected String word1;
	protected String word2;
	protected String im_path;
	protected int list_id;
	
	
	public UserWord() {
		super();
		word_id =-1;
		this.word1 = "";
		this.word2 = "";
		this.im_path = "";
		this.list_id = -1;
		
	}
	public UserWord(String word1, String word2, String im_path,int list_id) {
		super();
		this.word_id=-1;
		this.word1 = word1;
		this.word2 = word2;
		this.im_path = im_path;
		this.list_id = list_id;
	}
	public UserWord(int word_id,String word1, String word2, String im_path,int list_id) {
		super();
		this.word_id=word_id;
		this.word1 = word1;
		this.word2 = word2;
		this.im_path = im_path;
		this.list_id = list_id;
	}
	public String getWord1() {
		return word1;
	}
	public void setWord1(String word1) {
		this.word1 = word1;
	}
	public String getWord2() {
		return word2;
	}
	public void setWord2(String word2) {
		this.word2 = word2;
	}
	public String getIm_path() {
		return im_path;
	}
	public void setIm_path(String im_path) {
		this.im_path = im_path;
	}

	public int getList_id() {
		return list_id;
	}
	public void setList_id(int list_id) {
		this.list_id = list_id;
	}
	public int getWord_id() {
		return word_id;
	}
	public void setWord_id(int word_id) {
		this.word_id = word_id;
	}
	
	
}

