package com.IlboSns.dto;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
@Data
public class IlboBoardGpDto {
	
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
	private int gpNum;
	private ArrayList<MultipartFile> boMutipleFile;
	
	
}
