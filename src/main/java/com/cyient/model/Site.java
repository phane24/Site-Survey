package com.cyient.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Site")
public class Site implements Serializable {

	private static final long serialVersionUID = -3465813074586302847L;

	@Id
	@Column(name="siteID")
	private String siteid;	

	@Column(name="Latitude")
	private String latitude;
	
	@Column(name="Longitude")
	private String longitude;
	
	@Column(name="Region")
	private String region;	
	
	@Column(name="State")
	private String state;
	
	@Column(name="City")
	private String city;
	
	@Column(name="District")
	private String district;
	
	@Column(name="Site_Type")
	private String site_type;
	
	@Column(name="Survey_Status")
	private String surveyStatus;
	
	@Column(name="Survey_pdf", length = 16777215)
	private byte[] surveyPdf;
	
	@Column(name="Survey_Filename")
	private String surveyFilename;
	
	@Column(name="pincode")
	private int pincode;	
	
	public int getPincode() {
		return pincode;
	}

	public void setPincode(int pincode) {
		this.pincode = pincode;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getSite_type() {
		return site_type;
	}

	public void setSite_type(String site_type) {
		this.site_type = site_type;
	}

	public String getSiteid() {
		return siteid;
	}

	public void setSiteid(String siteid) {
		this.siteid = siteid;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getSurveyStatus() {
		return surveyStatus;
	}

	public void setSurveyStatus(String surveyStatus) {
		this.surveyStatus = surveyStatus;
	}

	public byte[] getSurveyPdf() {
		return surveyPdf;
	}

	public void setSurveyPdf(byte[] surveyPdf) {
		this.surveyPdf = surveyPdf;
	}

	public String getSurveyFilename() {
		return surveyFilename;
	}

	public void setSurveyFilename(String surveyFilename) {
		this.surveyFilename = surveyFilename;
	}
}