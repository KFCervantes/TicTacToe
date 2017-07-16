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

+ (void) display:(NSString *)board;
+ (bool) game_over:(NSString *)board;
+ (NSString *) next_best_move:(NSString *)board;
+ (NSString *) select_next_move:(NSString *)board;

@end

#endif /* wrapper_h */
