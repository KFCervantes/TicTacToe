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
	if (three_in_row(xo, std_board) || !number_of_spaces) return true;
	
	return false;
}

+ (int) next_best_move_index:(NSString *)board {
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
