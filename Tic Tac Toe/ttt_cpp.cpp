//
//  ttt_cpp.cpp
//  Tic Tac Toe
//
//  Created by Kaleb Cervantes on 7/16/17.
//  Copyright © 2017 Kaleb Cervantes. All rights reserved.
//

#include "ttt_cpp.h"

int count(const char &c, const std::string &board){
	int ans(0);
	
	for (auto &e : board) if (e == c) ++ans;
	
	return ans;
}

bool three_in_row(const char &xo, const std::string &board){
	if(count(xo, board) < 3) return false;
	
	const bool r0((board.at(0) == xo) && (board.at(1) == xo) && (board.at(2) == xo));
	const bool r1((board.at(3) == xo) && (board.at(4) == xo) && (board.at(5) == xo));
	const bool r2((board.at(6) == xo) && (board.at(7) == xo) && (board.at(8) == xo));
	const bool c0((board.at(0) == xo) && (board.at(3) == xo) && (board.at(6) == xo));
	const bool c1((board.at(1) == xo) && (board.at(4) == xo) && (board.at(7) == xo));
	const bool c2((board.at(2) == xo) && (board.at(5) == xo) && (board.at(8) == xo));
	const bool da((board.at(0) == xo) && (board.at(4) == xo) && (board.at(8) == xo));
	const bool db((board.at(2) == xo) && (board.at(4) == xo) && (board.at(6) == xo));
	
	return (r0 || r1 || r2 || c0 || c1 || c2 || da || db);
}

std::set<std::string> next_moves(const std::string &board){
	std::set<std::string> ans;
	
	const int &number_of_spaces(count(' ', board));
	
	if (!(three_in_row('X', board) || three_in_row('O', board)) && number_of_spaces){//returns empty set if board is a win or draw
		char xo;
		(number_of_spaces % 2) ? (xo = 'X') : (xo = 'O');//turn is based off of how many empty spaces are left
		
		for (int i(0); i < 9; ++i){//boards will all have length 9
			if (board.at(i) == ' '){
				std::string next_move(board);
				next_move[i] = xo;
				ans.insert(next_move);
			}
		}
	}
	
	return ans;
}

std::pair<std::string, int> minimax(const std::string &board){
	
	if (three_in_row('X', board)) return std::pair<std::string, int>(board, 1);//int is 1 if X wins
	if (three_in_row('O', board)) return std::pair<std::string, int>(board, -1);//int is -1 if O wins
	
	const int &number_of_spaces(count(' ', board));
	
	if (!number_of_spaces) return std::pair<std::string, int>(board, 0);//int is 0 if draw
	
	const std::set<std::string> &s(next_moves(board));
	
	auto i(s.begin());
	std::string move(*i);
	int min_or_max(minimax(move).second);
	++i;
	
	if (number_of_spaces % 2){
		for (; i != s.end(); ++i){
			const std::string &this_move(*i);
			const int &this_min_or_max(minimax(this_move).second);
			if (this_min_or_max > min_or_max){
				min_or_max = this_min_or_max;
				move = this_move;
			}
		}
		
		return std::pair<std::string, int>(move, min_or_max);
	}
	
	for (; i != s.end(); ++i){
		const std::string &this_move(*i);
		const int &this_min_or_max(minimax(this_move).second);
		if (this_min_or_max < min_or_max){
			min_or_max = this_min_or_max;
			move = this_move;
		}
	}
	
	return std::pair<std::string, int>(move, min_or_max);
}
