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
        
        // Initialize Boolean
        self->_lost = NO;
        for (int x = 0; x < 4; x++) {
            
            for (int y = 0; y < 4; y++) {
                
                // Populated Board For New Game With Empty Squares
                self->_board[x][y] = SGBoardSquareE;
                
            }
            
        }
        
        for (int x = 0; x < 4; x++) {
            
            for (int y = 0; y < 4; y++) {
                
                // Create All Boolean Table For Valid Combinations
                self->_canAdd[x][y] = YES;
                
            }
            
        }
        
    }
    
    // Pick 4 Random Coordinates For Starting Pieces
    NSInteger x1 = arc4random() % 4;
    NSInteger y1 = arc4random() % 4;
    NSInteger x2 = arc4random() % 4;
    NSInteger y2 = arc4random() % 4;
    
    // Remove Duplicates
    while (x1 == x2 && y1 == y2) {
        
        x2 = arc4random() % 4;
        y2 = arc4random() % 3;
        
    }
    
    // Add Two "2s" to New Board
    self->_board[x1][y1] = SGBoardSquare2;
    self->_board[x2][y2] = SGBoardSquare2;
    
    return self;
    
}

- (NSString *)description {
    
    NSString *rv = @"\n";
    
    for (int y = 0; y < 4; y++) {
        
        for (int x = 0; x < 4; x++) {
            
            rv = [NSString stringWithFormat:@"%@ V: %i", rv, self->_board[x][y]];
            
        }
        
        rv = [NSString stringWithFormat:@"%@\n", rv];
        
    }
    
    return rv;
    
}

#pragma mark - Property Access Methods

- (BOOL)isOver {
    
    // Check for 2048 Pieces On Board (Game Ends)
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            if (self->_board[x][y] == SGBoardSquare2048) {
                
                return YES;
                
            }
            
        }
        
    }
    
    // Check For Empty Squares (Game Does Not End)
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            if (self->_board[x][y] == SGBoardSquareE) {
                
                return NO;
                
            }
            
        }
        
    }
    
    // Check For Adjacent Squares
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
    
    // Game Ends, Player Loses
    self->_lost = YES;
    return YES;
    
}

- (BOOL)didLose {
    
    return self->_lost;
    
}

#pragma mark - Private Instance Methods

// Checks That XY Coordinate Pair Lies On Board
- (BOOL)checkValidX:(NSInteger)x Y:(NSInteger)y {
    
    if (x >= 0 && x < 4 && y >= 0 && y < 4) {
        
        return true;
        
    }
    
    return false;
    
}

// Move Single Piece High Up As Possible
- (void)moveUpX:(NSInteger)x Y:(NSInteger)y {
    
    if (y == 0) {
        
        // Edge of Board, Can't Move
        return;
        
    } else if (self->_board[x][y] == SGBoardSquareE) {
        
        // Empty Square, Can't Move
        return;
        
    } else if (self->_board[x][y-1] == self->_board[x][y] && self->_canAdd[x][y-1]) {
        
        // Add Squares And Clear. End Move.
        self->_board[x][y-1] = (SGBoardSquare)(self->_board[x][y] + self->_board[x][y-1]);
        self->_board[x][y] = SGBoardSquareE;
        self->_score = self->_score + (NSInteger)(self->_board[x][y-1]);
        self->_canAdd[x][y-1] = NO;
        
        return;
        
    } else if (self->_board[x][y-1] == SGBoardSquareE) {
        
        // Slide Up, Keep Moving
        self->_board[x][y-1] = self->_board[x][y];
        self->_board[x][y] = SGBoardSquareE;
        [self moveUpX:x Y:y-1];
        
    } else {
        
        // Move Finished
        return;
    }
    
}

// Move Single Piece Down As Possible
- (void)moveDownX:(NSInteger)x Y:(NSInteger)y {
    
    if (y == 3) {
        
        // Edge of Board, Can't Move
        return;
        
    } else if (self->_board[x][y] == SGBoardSquareE) {
        
        // Empty Square, Can't Move
        return;
        
    } else if (self->_board[x][y+1] == self->_board[x][y] && self->_canAdd[x][y+1]) {
        
        // Add Squares And Clear. End Move.
        self->_board[x][y+1] = (SGBoardSquare)(self->_board[x][y] + self->_board[x][y+1]);
        self->_board[x][y] = SGBoardSquareE;
        self->_score = self->_score + (NSInteger)(self->_board[x][y+1]);
        self->_canAdd[x][y+1] = NO;
        
        return;
        
    } else if (self->_board[x][y+1] == SGBoardSquareE) {
        
        // Slide Down, Keep Moving
        self->_board[x][y+1] = self->_board[x][y];
        self->_board[x][y] = SGBoardSquareE;
        [self moveDownX:x Y:y+1];
        
    } else {
        
        // Move Finished
        return;
        
    }
    
}

// Move Single Piece Right As Possible
- (void)moveRightX:(NSInteger)x Y:(NSInteger)y {

    if (x == 3) {
        
        // Edge of Board, Can't Move
        return;
        
    } else if (self->_board[x][y] == SGBoardSquareE) {
        
        // Empty Square, Can't Move
        return;
    
    } else if (self->_board[x+1][y] == self->_board[x][y] && self->_canAdd[x+1][y]) {
        
        // Add Squares And Clear. End Move
        self->_board[x+1][y] = (SGBoardSquare)(self->_board[x][y] + self->_board[x+1][y]);
        self->_board[x][y] = SGBoardSquareE;
        self->_score = self->_score + (NSInteger)(self->_board[x+1][y]);
        self->_canAdd[x+1][y] = NO;
        
        return;
        
    } else if (self->_board[x+1][y] == SGBoardSquareE) {
        
        // Side Right, Keep Moving
        self->_board[x+1][y] = self->_board[x][y];
        self->_board[x][y] = SGBoardSquareE;
        [self moveRightX:x+1 Y:y];
        
    } else {
        
        // Move Finished
        return;
        
    }
    
}

- (void)moveLeftX:(NSInteger)x Y:(NSInteger)y {
    
    if (x == 0) {
        
        // Edge of Board, Can't Move
        return;
        
    } else if (self->_board[x][y] == SGBoardSquareE) {
        
        // Empty Square, Can't Move
        return;
        
    } else if (self->_board[x-1][y] == self->_board[x][y] && self->_canAdd[x-1][y]) {
        
        // Add Squares And Clear. End Move.
        self->_board[x-1][y] = (SGBoardSquare)(self->_board[x][y] + self->_board[x-1][y]);
        self->_board[x][y] = SGBoardSquareE;
        self->_score = self->_score + (NSInteger)(self->_board[x-1][y]);
        self->_canAdd[x-1][y] = NO;
        
        return;
        
    } else if (self->_board[x-1][y] == SGBoardSquareE) {
        
        // Slide Right, Keep Moving
        self->_board[x-1][y] = self->_board[x][y];
        self->_board[x][y] = SGBoardSquareE;
        [self moveLeftX:x-1 Y:y];
        
    } else {
        
        // Move Finished
        return;
        
    }
    
}

- (void)resetCanAdd {
 
    // Create All Boolean Table For Valid Combinations
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            self->_canAdd[x][y] = YES;
            
        }
        
    }
    
}

#pragma mark - Public Instance Methods

- (id)initWithBoard:(SGBoard *)data {
    
    if (self = [super init]) {
        
        for (int x = 0; x < 4; x++) {
            
            for (int y = 0; y < 4; y++) {
                
                // Copies data from other board, not for new game.
                self->_board[x][y] = data->_board[x][y];
                
            }
            
        }
        
    }
    
    return self;
    
}

// Add Two Random Pieces to Board
- (void)dropRandom {
    
    NSInteger empty[16]; // Empty Square Array
    NSInteger numEmpty = 0; // Number Of Available Moves
    
    // Populate
    for (int i = 0; i < 16; i++) {
        
        if (self->_board[i%4][i/4] == SGBoardSquareE) {
            
            empty[numEmpty] = i;
            numEmpty++;
            
        }
        
    }
    
    // Check For Empty Board
    if (numEmpty > 0) {
        
        NSInteger randomIndex = arc4random() % numEmpty; // Pick Random Index
        NSInteger coords = empty[randomIndex]; // Get coordinates
        
        SGBoardSquare pieceToDrop;
        NSInteger piece = arc4random() % 2;
        
        // Choose Randomly Between SGBoardSquare2 and SGBoardSquare4
        if (piece == 0) {
            
            pieceToDrop = SGBoardSquare2;
            
        } else {
            
            pieceToDrop = SGBoardSquare4;
            
        }
        
        // Calculate X & Y, Add Piece To Board
        self->_board[coords%4][coords/4] = pieceToDrop;
        
    }
    
}

- (BOOL)slideUp {
    
    // Freeze Board State
    SGBoardSquare copy[4][4];
    for (int x = 0; x < 4; x++) {
    
        for (int y = 0; y < 4; y++) {
            
            copy[x][y] = self->_board[x][y];
            
        }
        
    }
    
    // Move Up Eligible Pieces (IN ORDER)
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            [self moveUpX:x Y:y];
            
        }
        
    }
    
    // Reset Valid Moves Table
    [self resetCanAdd];
    
    // See If Move Was Legal
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            if (copy[x][y] != self->_board[x][y]) {
                
                return YES;
                
            }
            
        }
        
    }
    
    return NO;
    
}

- (BOOL)slideDown {
    
    // Freeze Board State
    SGBoardSquare copy[4][4];
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            copy[x][y] = self->_board[x][y];
            
        }
        
    }
    
    // Move Down Eligible Pieces (IN ORDER)
    for (int x = 0; x < 4; x++) {
        
        for (int y = 3; y >= 0; y--) {
            
            [self moveDownX:x Y:y];
            
        }
        
    }
    
    // Reset Valid Moves Table
    [self resetCanAdd];
    
    // See If Move Was Valid
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            if (copy[x][y] != self->_board[x][y]) {
                
                return YES;
                
            }
            
        }
        
    }
    
    return NO;
    
}

- (BOOL)slideLeft {
    
    // Freeze Board State
    SGBoardSquare copy[4][4];
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            copy[x][y] = self->_board[x][y];
            
        }
        
    }
    
    // Move Eligible Pieces Left
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            [self moveLeftX:x Y:y];
            
        }
        
    }
    
    // Reset Valid Moves Table
    [self resetCanAdd];
    
    // See If Move Was Valid
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            if (copy[x][y] != self->_board[x][y]) {
                
                return YES;
                
            }
            
        }
        
    }
    
    return NO;
    
}

- (BOOL)slideRight {
    
    // Freeze Board State
    SGBoardSquare copy[4][4];
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            copy[x][y] = self->_board[x][y];
            
        }
        
    }
    
    // Move Eligible Pieces Right
    for (int y = 0; y < 4; y++) {
        
        for (int x = 3; x >= 0; x--) {
            
            [self moveRightX:x Y:y];
            
        }
        
    }
    
    // Reset Valid Moves Table
    [self resetCanAdd];
    
    // See If Move Was Valid
    for (int y = 0; y < 4; y++) {
        
        for (int x = 0; x < 4; x++) {
            
            if (copy[x][y] != self->_board[x][y]) {
                
                return YES;
                
            }
            
        }
        
    }
    
    return NO;
    
}

- (SGBoardSquare)getSquareAtX:(NSInteger)xcoord Y:(NSInteger)ycoord {
    
    return self->_board[xcoord][ycoord];
    
}



@end
