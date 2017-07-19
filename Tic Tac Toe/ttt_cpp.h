//
//  ttt_cpp.h
//  Tic Tac Toe
//
//  Created by Kaleb Cervantes on 7/16/17.
//  Copyright © 2017 Kaleb Cervantes. All rights reserved.
//

#ifndef ttt_cpp_h
#define ttt_cpp_h

#include <string>
#include <set>

//returns the number of times a character occurs in a string
int count(const char &c, const std::string &board);

//returns true of a character wins
bool three_in_row(const char &xo, const std::string &board);

//returns a set of all the moves after board
std::set<std::string> next_moves(const std::string &board);

//the string in the pair is the best possible move
//the int is the best garenteed outcome
//1 if X wins
//-1 if O wins
//0 if draw
std::pair<std::string, int> minimax(const std::string &board);

#endif /* ttt_cpp_h */
