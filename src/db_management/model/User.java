package db_management.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="user")
public class User {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) //this is where problem exists
    @Column(name="user_id", updatable=false, nullable=false)
    private int user_id;
	
	@Column(name="username")
	protected String username;
	
	@Column(name="password")
	protected String password;
	
	@Column(name="email")
	protected String email;
	
	public User() {
		super();
		this.username = "";
		this.password = "";
		this.email = "";		
	}
	
	public User(String username, String password, String email) {
		this.username = username;
		this.password = password;
		this.email = email;		
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
