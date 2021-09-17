package com.IlboSns.dto;

import java.util.ArrayList;

import lombok.Data;

@Data
public class IlboMemberRecommendationDto {
	private ArrayList<IlboMemberDto> relationFollow;
	private ArrayList<IlboMemberDto> relationSchool;
	private ArrayList<IlboMemberDto> relationCompany;
	private ArrayList<IlboMemberDto> relationAddr;
}
