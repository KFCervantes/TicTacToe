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

//returns bool and says who wins in UTF8 using std::cout
+ (bool) game_over:(NSString *)board;

//returns the index of where the next move should be
+ (int) next_best_move_index:(NSString *)board;

@end

#endif /* wrapper_h */
