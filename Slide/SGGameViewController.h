//
//  SGGameViewController.h
//  Slide
//
//  Created by Varun Santhanam on 3/18/14.
//  Copyright (c) 2014 Varun Santhanam. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SGBoard.h"
#import "SGBoardPiece.h"

@interface SGGameViewController : UIViewController

@property (nonatomic, strong) SGBoard *board;

@property (weak, nonatomic) IBOutlet SGBoardPiece *p00;
@property (weak, nonatomic) IBOutlet SGBoardPiece *p10;
@property (weak, nonatomic) IBOutlet SGBoardPiece *p20;
@property (weak, nonatomic) IBOutlet SGBoardPiece *p30;
@property (weak, nonatomic) IBOutlet SGBoardPiece *p01;
@property (weak, nonatomic) IBOutlet SGBoardPiece *p11;
@property (weak, nonatomic) IBOutlet SGBoardPiece *p21;
@property (weak, nonatomic) IBOutlet SGBoardPiece *p31;
@property (weak, nonatomic) IBOutlet SGBoardPiece *p02;
@property (weak, nonatomic) IBOutlet SGBoardPiece *p12;
@property (weak, nonatomic) IBOutlet SGBoardPiece *p22;
@property (weak, nonatomic) IBOutlet SGBoardPiece *p32;
@property (weak, nonatomic) IBOutlet SGBoardPiece *p03;
@property (weak, nonatomic) IBOutlet SGBoardPiece *p13;
@property (weak, nonatomic) IBOutlet SGBoardPiece *p23;
@property (weak, nonatomic) IBOutlet SGBoardPiece *p33;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highSchoreLabel;

- (IBAction)userSwipeLeft:(id)sender;
- (IBAction)userSwipeRight:(id)sender;
- (IBAction)userSwipeUp:(id)sender;
- (IBAction)userSwipeDown:(id)sender;
- (IBAction)userNewGame:(id)sender;

@end
