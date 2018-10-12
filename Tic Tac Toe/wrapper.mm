//
//  wrapper.m
//  Tic Tac Toe
//
//  Created by Kaleb Cervantes on 7/16/17.
//  Copyright © 2017 Kaleb Cervantes. All rights reserved.
//

#import "wrapper.h"
#import "ttt_cpp.h"

@implementation wrapper

+ (bool) game_over:(NSString *)board {
	//convert makes a copy of board that is std::string
	const std::string std_board([board UTF8String]);
	const int &number_of_spaces(count(' ', std_board));
	
	char xo;
	
	//sets xo to the character that just went
	(number_of_spaces % 2) ? (xo = 'O') : (xo = 'X');
	
	//returns true if someone wins or if game is draw
	return (three_in_row(xo, std_board) || !number_of_spaces);
}

+ (int) next_easy_move_index:(NSString *)board {return next_random_move_index([board UTF8String]);}

+ (int) next_medi_move_index:(NSString *)board {
	const std::string std_board([board UTF8String]);
	const int &number_of_spaces(count(' ', std_board));
	if ((1 < number_of_spaces) && (number_of_spaces < 7)){
		const std::set<std::string> &s(next_moves(std_board));
		char xo;
		(number_of_spaces % 2) ? (xo = 'X') : (xo = 'O');
		for (const auto &e : s)
			if (three_in_row(xo, e))
				for (int i(0); i < 9; ++i)
					if (e.at(i) != std_board.at(i))
						return i;
		
		char other_xo;
		(xo == 'X') ? (other_xo = 'O') : (other_xo = 'X');
		for (const auto &e : s)
			for (const auto &f : next_moves(e))
				if (three_in_row(other_xo, f))
					for (int i(0); i < 9; ++i)
						if ((std_board.at(i) != f.at(i)) && (f.at(i) == other_xo))
							return i;
	}
	
	return next_random_move_index(std_board);
}

+ (int) next_hard_move_index:(NSString *)board {
	const std::string std_board([board UTF8String]);
	
	//selects next move using minimax algorithm
	//minimax is a pair and only the string is needed
	const std::string next_move(minimax(std_board).first);
	
	//creates a counting variable and gets to the index where the boards differ
	int ans(0);
	for (; (ans < 9) && (std_board.at(ans) == next_move.at(ans)); ++ans);
	return ans;
}

+ (NSString *) whose_turn:(NSString *)board {
	const std::string std_board([board UTF8String]);
	const int &number_of_spaces(count(' ', std_board));
	std::string xo;
	(number_of_spaces % 2) ? (xo = "X") : (xo = "O");
	return [NSString stringWithUTF8String:xo.c_str()];
}

@end
