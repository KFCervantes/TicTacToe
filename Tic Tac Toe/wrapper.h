//
//  wrapper.h
//  Tic Tac Toe
//
//  Created by Kaleb Cervantes on 7/16/17.
//  Copyright © 2017 Kaleb Cervantes. All rights reserved.
//

#ifndef wrapper_h
#define wrapper_h

#import <Foundation/Foundation.h>
@interface wrapper : NSObject

//displays board in UTF8 using std::cout
+ (void) display:(NSString *)board;

//returns bool and says who wins in UTF8 using std::cout
+ (bool) game_over:(NSString *)board;

//returns the next move with the best results
+ (NSString *) next_best_move:(NSString *)board;

//allows the player to select the next move using cin
+ (NSString *) select_next_move:(NSString *)board;

@end

#endif /* wrapper_h */
