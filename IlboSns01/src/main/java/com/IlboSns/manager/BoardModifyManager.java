package com.IlboSns.manager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.IlboSns.dto.IlboBoardDto;
import com.IlboSns.dto.IlboBoardModifyDto;

@Component
public class BoardModifyManager {
	Map<Integer, ArrayList<IlboBoardModifyDto>> boards;
	
	BoardModifyManager(){
		boards = new HashMap<Integer, ArrayList<IlboBoardModifyDto>>();
	}
	
	public void standby(int memId) {
		ArrayList<IlboBoardModifyDto> log = new ArrayList<IlboBoardModifyDto>();
		System.out.println(memId);
		boards.put(memId, log);
	}
	
	public ArrayList<IlboBoardModifyDto> cancel(int memId) {
		ArrayList<IlboBoardModifyDto> result = boards.get(memId);
		boards.remove(memId);
		return result;
	}
	
	public void insertLog(String commend, IlboBoardDto board) {
		IlboBoardModifyDto log = new IlboBoardModifyDto(commend, board);
		System.out.println(board.getBoWriter());
		boards.get(board.getBoWriter()).add(log);
	}
	
	public ArrayList<IlboBoardModifyDto> accept(int memId){
		System.out.println(memId);
		System.out.println("*****************");
		System.out.println(memId);
		System.out.println("*****************");
		System.out.println(memId);
		System.out.println("*****************");
		System.out.println(memId);
		System.out.println("*****************");
		ArrayList<IlboBoardModifyDto> result = boards.get(memId);
		boards.remove(memId);
		return result;
	}
	
	public ArrayList<IlboBoardModifyDto> aaa(int memId) {
		return boards.get(memId);
	}
}
