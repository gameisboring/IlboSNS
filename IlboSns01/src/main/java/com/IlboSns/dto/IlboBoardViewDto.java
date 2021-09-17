package com.IlboSns.dto;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class IlboBoardViewDto {
	private int memId;
	private String memProfile;
	private String memName;
	private int boNum;
	private String boContent;
	private String boVisiblity;
	private String boType;	
	private String boDate;
	private String boModDate;
	private String boFile;
	private int boGroupNum;
	private int boGpNum;
	private String gpName;
	private ArrayList<IlboBoardReplyDto> reply;
	private int numOfInteraction;
	
	public void setBoContent(String boContent) {
		this.boContent = boContent.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	}
	
	public void setBoContentWithTag(String boContent) {
		this.boContent = boContent;
	}
}
