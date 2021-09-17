package com.IlboSns.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class IlboBoardModifyDto {
	private String commend;
	private IlboBoardDto board;
}
