//
//  SGBoard.h
//  Slide
//
//  Created by Varun Santhanam on 3/18/14.
//  Copyright (c) 2014 Varun Santhanam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGBoard : NSObject

typedef enum {
    
    SGBoardSquareE = 0,
    SGBoardSquare2 = 2,
    SGBoardSquare4 = 4,
    SGBoardSquare8 = 8,
    SGBoardSquare16 = 16,
    SGBoardSquare32 = 32,
    SGBoardSquare64 = 64,
    SGBoardSquare128 = 128,
    SGBoardSquare256 = 256,
    SGBoardSquare512 = 512,
    SGBoardSquare1024 = 1024,
    SGBoardSquare2048 = 2048
    
} SGBoardSquare;

@property (nonatomic, readonly, getter = isOver) BOOL over;
@property (nonatomic, assign, readonly) NSInteger score;
@property (nonatomic, readonly) BOOL didLose;

- (id)initWithBoard:(SGBoard *)data;
- (BOOL)slideRight;
- (BOOL)slideLeft;
- (BOOL)slideUp;
- (BOOL)slideDown;
- (void)dropRandom;

- (SGBoardSquare)getSquareAtX:(NSInteger)xcoord Y:(NSInteger)ycoord;

@end
