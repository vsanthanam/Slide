//
//  SGGameViewController.h
//  Slide
//
//  Created by Varun Santhanam on 3/18/14.
//  Copyright (c) 2014 Varun Santhanam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

#import "SGBoard.h"
#import "SGBoardPiece.h"

@interface SGGameViewController : UIViewController

@property (nonatomic, strong) SGBoard *board;
@property (nonatomic, assign, readonly, getter = isGameCenterEnabled) BOOL gameCenterEnabled;
@property (nonatomic, assign, readonly, getter = isBoardEnabled) BOOL boardEnabled;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highSchoreLabel;

- (void)enableBoard;
- (void)disableBoard;

- (IBAction)userSwipeLeft:(id)sender;
- (IBAction)userSwipeRight:(id)sender;
- (IBAction)userSwipeUp:(id)sender;
- (IBAction)userSwipeDown:(id)sender;
- (IBAction)userNewGame:(id)sender;

@end
