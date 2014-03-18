//
//  SGBoard.m
//  Slide
//
//  Created by Varun Santhanam on 3/18/14.
//  Copyright (c) 2014 Varun Santhanam. All rights reserved.
//

#import "SGBoard.h"

@implementation SGBoard {
    
    SGBoardSquare _board[4][4];
    BOOL _lost;
    BOOL _canAdd[4][4];
    
}

@synthesize score = _score;

#pragma mark - Overridden Instance Methods

- (id)init {
    
    if (self = [super init]) {
        
        self->_lost = NO;
        for (int x = 0; x < 4; x++) {
            
            for (int y = 0; y < 4; y++) {
                
                self->_board[x][y] = SGBoardSquareE;
                
            }
            
        }
        
        for (int x = 0; x < 4; x++) {
            
            for (int y = 0; y < 4; y++) {
                
                self->_canAdd[x][y] = YES;
                
            }
            
        }
        
    }
    
    NSInteger x1 = arc4random() % 4;
    NSInteger y1 = arc4random() % 4;
    NSInteger x2 = arc4random() % 4;
    NSInteger y2 = arc4random() % 4;
    
    self->_board[x1][y1] = SGBoardSquare2;
    self->_board[x2][y2] = SGBoardSquare2;
    
    return self;
    
}

#pragma mark - Property Access Methods

- (BOOL)isOver {
    
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            if (self->_board[x][y] == SGBoardSquareE) {
                
                return NO;
                
            }
            
        }
        
    }
    
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            if (self->_board[x][y] == SGBoardSquare2048) {
                
                return YES;
                
            }
            
        }
        
    }
    
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            SGBoardSquare type = self->_board[x][y];
            
            for (int i = x-1; i <= x+1 ; i+=2) {
                    
                if ([self checkValidX:i Y:y]) {
                        
                    if (self->_board[i][y] == type) {
                        
                        return NO;
                            
                    }
                        
                }
            }
                    
            for (int j = y-1; j <= y+1; j+=2) {
                
                if ([self checkValidX:x Y:j]) {
                    
                    if (self->_board[x][j] == type) {
                        
                        return NO;
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    self->_lost = YES;
    return YES;
    
}

- (BOOL)didLose {
    
    return self->_lost;
    
}

#pragma mark - Private Instance Methods

- (BOOL)checkValidX:(NSInteger)x Y:(NSInteger)y {
    
    if (x >= 0 && x < 4 && y >= 0 && y < 4) {
        
        return true;
        
    }
    
    return false;
    
}

- (void)moveUpX:(NSInteger)x Y:(NSInteger)y {
    
    if (y == 0) {
        
        return;
        
    } else if (self->_board[x][y-1] == self->_board[x][y] && self->_canAdd[x][y-1]) {
        
        self->_board[x][y-1] = (SGBoardSquare)(self->_board[x][y] + self->_board[x][y-1]);
        self->_board[x][y] = SGBoardSquareE;
        self->_score = self->_score + (NSInteger)(self->_board[x][y-1]);
        self->_canAdd[x][y-1] = NO;
        
        return;
        
    } else if (self->_board[x][y-1] == SGBoardSquareE) {
        
        self->_board[x][y-1] = self->_board[x][y];
        self->_board[x][y] = SGBoardSquareE;
        [self moveUpX:x Y:y-1];
        
    } else {
        
        return;
    }
    
}

- (void)moveDownX:(NSInteger)x Y:(NSInteger)y {
    
    if (y == 3) {
        
        return;
        
    } else if (self->_board[x][y+1] == self->_board[x][y] && self->_canAdd[x][y+1]) {
        
        self->_board[x][y+1] = (SGBoardSquare)(self->_board[x][y] + self->_board[x][y+1]);
        self->_board[x][y] = SGBoardSquareE;
        self->_score = self->_score + (NSInteger)(self->_board[x][y+1]);
        self->_canAdd[x][y+1] = NO;
        
        return;
        
    } else if (self->_board[x][y+1] == SGBoardSquareE) {
        
        self->_board[x][y+1] = self->_board[x][y];
        self->_board[x][y] = SGBoardSquareE;
        [self moveDownX:x Y:y+1];
        
    } else {
        
        return;
        
    }
    
}

- (void)moveRightX:(NSInteger)x Y:(NSInteger)y {
    
    if (x == 3) {
        
        return;
        
    } else if (self->_board[x+1][y] == self->_board[x][y] && self->_canAdd[x+1][y]) {
        
        self->_board[x+1][y] = (SGBoardSquare)(self->_board[x][y] + self->_board[x+1][y]);
        self->_board[x][y] = SGBoardSquareE;
        self->_score = self->_score + (NSInteger)(self->_board[x+1][y]);
        self->_canAdd[x+1][y] = NO;
        
        return;
        
    } else if (self->_board[x+1][y] == SGBoardSquareE) {
        
        self->_board[x+1][y] = self->_board[x][y];
        self->_board[x][y] = SGBoardSquareE;
        [self moveRightX:x+1 Y:y];
        
    } else {
        
        return;
        
    }
    
}

- (void)moveLeftX:(NSInteger)x Y:(NSInteger)y {
    
    if (x == 0) {
        
        return;
        
    } else if (self->_board[x-1][y] == self->_board[x][y] && self->_canAdd[x-1][y]) {
        
        self->_board[x-1][y] = (SGBoardSquare)(self->_board[x][y] + self->_board[x-1][y]);
        self->_board[x][y] = SGBoardSquareE;
        self->_score = self->_score + (NSInteger)(self->_board[x-1][y]);
        self->_canAdd[x-1][y] = NO;
        
        return;
        
    } else if (self->_board[x-1][y] == SGBoardSquareE) {
        
        self->_board[x-1][y] = self->_board[x][y];
        self->_board[x][y] = SGBoardSquareE;
        [self moveLeftX:x-1 Y:y];
        
    } else {
        
        return;
        
    }
    
}

- (void)resetCanAdd {
 
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            self->_canAdd[x][y] = YES;
            
        }
        
    }
    
}

#pragma mark - Public Instance Methods

- (void)dropRandom {
    
    NSInteger empty[16];
    NSInteger numEmpty = 0;
    
    for (int i = 0; i < 16; i++) {
        
        if (self->_board[i%4][i/4] == SGBoardSquareE) {
            
            empty[numEmpty] = i;
            numEmpty++;
            
        }
        
    }
    
    if (numEmpty > 0) {
        
        NSInteger randomIndex = arc4random() % numEmpty;
        NSInteger coords = empty[randomIndex];
        
        SGBoardSquare pieceToDrop;
        NSInteger piece = arc4random() % 2;
        
        if (piece == 0) {
            
            pieceToDrop = SGBoardSquare2;
            
        } else {
            
            pieceToDrop = SGBoardSquare4;
            
        }
        
        self->_board[coords%4][coords/4] = pieceToDrop;
        
    }
    
}

- (BOOL)slideUp {
    
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            [self moveUpX:x Y:y];
            
        }
        
    }
    
    [self resetCanAdd];
    
    return YES;
}

- (BOOL)slideDown {
    
    for (int x = 0; x < 4; x++) {
        
        for (int y = 3; y >= 0; y--) {
            
            [self moveDownX:x Y:y];
            
        }
        
    }
    
    [self resetCanAdd];
    
    return YES;
    
}

- (BOOL)slideLeft {
    
    for (int y = 0; y < 4; y++) {
        
        for (int x = 0; x < 4; x++) {
            
            [self moveLeftX:x Y:y];
            
        }
        
    }
    
    [self resetCanAdd];
    
    return YES;
    
}

- (BOOL)slideRight {
    
    for (int y = 0; y < 4; y++) {
        
        for (int x = 3; x >= 0; x--) {
            
            [self moveRightX:x Y:y];
            
        }
        
    }
    
    [self resetCanAdd];
    
    return YES;
    
}

- (SGBoardSquare)getSquareAtX:(NSInteger)xcoord Y:(NSInteger)ycoord {
    
    return self->_board[xcoord][ycoord];
    
}



@end
