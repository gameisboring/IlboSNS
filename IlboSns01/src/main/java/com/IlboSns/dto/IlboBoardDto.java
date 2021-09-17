package com.IlboSns.dto;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class IlboBoardDto {
	private int boNum;
	private String boVisiblity;
	private String boContent;
	private int boWriter;
	private String boWritersName;
	private String boType;	
	private String boDate;
	private String boModDate;
	private String boFile;
	private int boGroupNum;
	private ArrayList<MultipartFile> boMutipleFile;
	private MultipartFile boFileData;
	
	public void setBoContent(String boContent) {
		this.boContent = boContent.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	}
}
