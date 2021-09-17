package com.IlboSns.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class IlboMemberDto {
	private int memId;
	private String memPw;
	private String memEmail;
	private String memTel;
	private String memName;
	private String memProfile;
	private String memAddr;
	private String memBirth;
	private String memCompany;
	private String memSchool;
	private String memLife;
	private String memGender;
	private String memDate;
	private MultipartFile memProfileFile;
	
	
	public void setMemName(String memName) {
		this.memName = memName.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	}
	
	
	public void setMemAddr(String memAddr) {
		this.memAddr = memAddr.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	}
	
	public void setMemCompany(String memCompany) {
		this.memCompany = memCompany.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	}
	
	public void setMemSchool(String memSchool) {
		this.memSchool = memSchool.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	}
	
	
	
}
