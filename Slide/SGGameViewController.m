//
//  SGGameViewController.m
//  Slide
//
//  Created by Varun Santhanam on 3/18/14.
//  Copyright (c) 2014 Varun Santhanam. All rights reserved.
//

#import "SGGameViewController.h"

@interface SGGameViewController () {
    
    NSInteger _pieces[4][4];
    
}

@end

@implementation SGGameViewController

@synthesize board = _board;

@synthesize scoreLabel = _scoreLabel;
@synthesize highSchoreLabel;

@synthesize p00 = _p00;
@synthesize p10 = _p10;
@synthesize p20 = _p20;
@synthesize p30 = _p30;
@synthesize p01 = _p01;
@synthesize p11 = _p11;
@synthesize p21 = _p21;
@synthesize p31 = _p31;
@synthesize p02 = _p02;
@synthesize p12 = _p12;
@synthesize p22 = _p22;
@synthesize p32 = _p32;
@synthesize p03 = _p03;
@synthesize p13 = _p13;
@synthesize p23 = _p23;
@synthesize p33 = _p33;

#pragma mark - Overridden Instance Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.board = [[SGBoard alloc] init];
    self->_pieces[0][0] = self.p00.tag;
    self->_pieces[1][0] = self.p10.tag;
    self->_pieces[2][0] = self.p20.tag;
    self->_pieces[3][0] = self.p30.tag;
    self->_pieces[0][1] = self.p01.tag;
    self->_pieces[1][1] = self.p11.tag;
    self->_pieces[2][1] = self.p21.tag;
    self->_pieces[3][1] = self.p31.tag;
    self->_pieces[0][2] = self.p02.tag;
    self->_pieces[1][2] = self.p12.tag;
    self->_pieces[2][2] = self.p22.tag;
    self->_pieces[3][2] = self.p32.tag;
    self->_pieces[0][3] = self.p03.tag;
    self->_pieces[1][3] = self.p13.tag;
    self->_pieces[2][3] = self.p23.tag;
    self->_pieces[3][3] = self.p33.tag;
    
    self.title = @"2048";
    NSLog(@"%i", [self.board getSquareAtX:3 Y:1]);
    [self updateBoardScreen];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Instance Methods

- (void)updateBoardScreen {
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"]) {
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.highSchoreLabel.alpha = 1;
                         }];
        self.highSchoreLabel.text = [NSString stringWithFormat:@"Best: %li", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"]];
        
    }
    
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            SGBoardPiece *piece = (SGBoardPiece *)[self.view viewWithTag:self->_pieces[x][y]];
            [UIView transitionWithView:piece
                              duration:0.5
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                
                                piece.status = [self.board getSquareAtX:x Y:y];
                                
                            }completion:nil];
        }
        
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score %li", (long)self.board.score];
    
    if (self.board.isOver) {
        
        if (self.board.didLose) {
            
            self.scoreLabel.text = @"You Lost!";
            
        } else {
            
            self.scoreLabel.text = @"You Won!";
            
        }
        
        if (![[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"]) {
            
            [[NSUserDefaults standardUserDefaults] setInteger:self.board.score forKey:@"highscore"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        } else {
            
            NSInteger pastScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"];
            if (self.board.score > pastScore) {
                
                [[NSUserDefaults standardUserDefaults] setInteger:self.board.score forKey:@"highscore"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }
            
        }
        
    }
    
}

#pragma mark - Actions

- (IBAction)userSwipeLeft:(id)sender {
    
    NSLog(@"Swipe Left");
    [self.board slideLeft];
    [self.board dropRandom];
    [self updateBoardScreen];
    
}

- (IBAction)userSwipeRight:(id)sender {
    
    NSLog(@"Swipe Right");
    [self.board slideRight];
    [self.board dropRandom];
    [self updateBoardScreen];
}

- (IBAction)userSwipeUp:(id)sender {
    
    NSLog(@"Swipe Up");
    [self.board slideUp];
    [self.board dropRandom];
    [self updateBoardScreen];
    
}

- (IBAction)userSwipeDown:(id)sender {
    
    NSLog(@"Swipe Down");
    [self.board slideDown];
    [self.board dropRandom];
    [self updateBoardScreen];
    
}

- (IBAction)userNewGame:(id)sender {
    
    self.board = [[SGBoard alloc] init];
    [self updateBoardScreen];
    
}
@end
