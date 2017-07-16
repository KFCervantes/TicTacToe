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

+ (void) display:(NSString *)board {
	const std::string std_board([board UTF8String]);
	std::cout << "  0 1 2\n";
	for (int i(0); i < 3; ++i){
		std::cout << i << ' ';
		for (int j(0); j < 3; ++j) std::cout << std_board.at((3 * i) + j) <<' ';
		std::cout << std::endl;
	}
	std::cout << std::endl;
}

+ (bool) game_over:(NSString *)board {
	const std::string std_board([board UTF8String]);
	const int &number_of_spaces(count(' ', std_board));
	
	char xo;
	(number_of_spaces % 2) ? (xo = 'O') : (xo = 'X');
	
	if (three_in_row(xo, std_board)){
		std::cout << "Player " << xo << " wins" << std::endl;
		return true;
	}
	
	if (!number_of_spaces){
		std::cout << "draw" << std::endl;
		return true;
	}
	
	return false;
}

+ (NSString *) next_best_move:(NSString *)board {
	const std::string next_move(minimax([board UTF8String]).first);
	return [NSString stringWithUTF8String:next_move.c_str()];
}

+ (NSString *) select_next_move:(NSString *)board {
	std::string std_board([board UTF8String]);
	const int &number_of_spaces(count(' ', std_board));
	char xo;
	(number_of_spaces % 2) ? (xo = 'X') : (xo = 'O');
	
	int row, column;
	std::cout << "Player " << xo << std::endl;
	while (true){
		std::cout << "Enter row ";
		std::cin >> row;
		std::cout << "Enter column ";
		std::cin >> column;
		if (std_board.at((3 * row) + column) == ' '){
			std_board[(3 * row) + column] = xo;
			break;
		}
		else std::cout << "That space is taken\n";
	}
	return [NSString stringWithUTF8String:std_board.c_str()];
}

@end
