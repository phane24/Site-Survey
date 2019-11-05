package com.cyient.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name = "Users")
public class User implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;

	@Id
	@Column(name="Username")
	private String username;
	
	@Column(name="Name")
	private String name;
	
	@Column(name="Email_Id")
	private String emailId;
	
	@Column(name="Mobile_Number")
	private String mobileNumber;

	@Column(name="Password")
	private String password;
		
	@Column(name="Role")
	private String role;
	
	@Column(name="Region")
	private String region;
	
	@Column(name="City")
	private String city;
	
	@Column(name="Created_Date")
	@Temporal(TemporalType.DATE)
	private Date createdDate;

	
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getMobileNumber() {
		return mobileNumber;
	}

	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

}