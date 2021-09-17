package com.IlboSns.dto;

import lombok.Data;

@Data
public class IlboBoardReplyDto {
	
	private String memName;
	private int reWriter;
	private String memProfile;
	private String reContent;
	private String reDate;
	private int reBoNum;
	private int reGroup;
	private int reTagId;
	private String reTagName;
	private int reSeq;

	
	public void setReContent(String reContent) {
		this.reContent = reContent.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	}
}
