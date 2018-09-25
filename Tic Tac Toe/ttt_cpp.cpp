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
	
	//bools are true if that winning condition is met
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
	
	//returns empty set if board is a win or draw
	if (!(three_in_row('X', board) || three_in_row('O', board)) && number_of_spaces){
		//turn is based off of how many empty spaces are left
		char xo;
		(number_of_spaces % 2) ? (xo = 'X') : (xo = 'O');
		
		//boards will all have length 9
		for (int i(0); i < 9; ++i){
			if (board.at(i) == ' '){
				std::string next_move(board);
				next_move[i] = xo;
				ans.insert(next_move);
			}
		}
	}
	
	return ans;
}

int next_random_move_index(const std::string &board){
	int ans;
	std::vector<int> v;
	for (ans = 0; ans < 9; ++ans)
		if (board.at(ans) == ' ')
			v.push_back(ans);
	const int upper(int(v.size()) - 1);
	if (v.empty())
		return ans;
	if (v.size() == 1)
		return v.at(0);
	std::random_device rd;
	std::mt19937 gen(rd());
	std::uniform_int_distribution<> dis(0, upper);
	return v.at(dis(gen));
}

std::pair<std::string, int> minimax(const std::string &board){
	
	//int is 1 if X wins
	if (three_in_row('X', board)) return std::pair<std::string, int>(board, 1);
	
	//int is -1 if O wins
	if (three_in_row('O', board)) return std::pair<std::string, int>(board, -1);
	
	const int &number_of_spaces(count(' ', board));
	
	//draw if no spaces are left
	if (!number_of_spaces) return std::pair<std::string, int>(board, 0);//int is 0 if draw
	
	//if base conditions are not met the set will have 1-9 moves in it
	const std::set<std::string> &s(next_moves(board));
	
	//recursively finds the next best move through 1-9 branches each time
	
	//i is an iterator to the first item
	auto i(s.begin());
	//sets move equal to the value of the first item
	std::string move(*i);
	//sets the int equal to the best garenteed outcome from that move
	int min_or_max(minimax(move).second);
	//if the is only 1 move next i becomes equal to s.end() and for loops will not run
	++i;
	
	//if the number of spaces is odd assumes the next best move will be in X's favor
	if (number_of_spaces % 2){
		//i was already initialized
		for (; i != s.end(); ++i){
			const std::string &this_move(*i);
			const int &this_min_or_max(minimax(this_move).second);
			//max comparison
			if (this_min_or_max > min_or_max){
				min_or_max = this_min_or_max;
				move = this_move;
			}
		}
		
		return std::pair<std::string, int>(move, min_or_max);
	}
	
	//if the number of spaces is even assumes the next best move will be in O's favor
	for (; i != s.end(); ++i){
		const std::string &this_move(*i);
		const int &this_min_or_max(minimax(this_move).second);
		//min comparison
		if (this_min_or_max < min_or_max){
			min_or_max = this_min_or_max;
			move = this_move;
		}
	}
	
	return std::pair<std::string, int>(move, min_or_max);
}
