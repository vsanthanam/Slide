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
@synthesize gameCenterEnabled = _gameCenterEnabled;
@synthesize boardEnabled = _boardEnabled;

@synthesize scoreLabel = _scoreLabel;
@synthesize highSchoreLabel;

#pragma mark - Property Access Methods

- (BOOL)isGameCenterEnabled {
    
    return self->_gameCenterEnabled;
    
}

- (BOOL)isBoardEnabled {
    
    return self->_boardEnabled;
    
}

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
    self->_pieces[0][0] = 1;
    self->_pieces[1][0] = 2;
    self->_pieces[2][0] = 3;
    self->_pieces[3][0] = 4;
    self->_pieces[0][1] = 5;
    self->_pieces[1][1] = 6;
    self->_pieces[2][1] = 7;
    self->_pieces[3][1] = 8;
    self->_pieces[0][2] = 9;
    self->_pieces[1][2] = 10;
    self->_pieces[2][2] = 11;
    self->_pieces[3][2] = 12;
    self->_pieces[0][3] = 13;
    self->_pieces[1][3] = 14;
    self->_pieces[2][3] = 15;
    self->_pieces[3][3] = 16;
    
    self.title = @"Slide";
    [self updateBoardScreenWithTransition:UIViewAnimationOptionTransitionCrossDissolve];

}

- (void)viewDidAppear:(BOOL)animated {
    
    [self authenticateLocalPlayer];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Instance Methods

- (void)updateBoardScreenWithTransition:(UIViewAnimationOptions)transition {
    
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
                               options:transition
                            animations:^{
                                
                                piece.status = [self.board getSquareAtX:x Y:y];
                                
                            }completion:nil];
        }
        
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score %li", (long)self.board.score];
    
    if (self.board.isOver) {
        
        [self disableBoard];
        
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

- (void)authenticateLocalPlayer {
    
    __weak GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error) {
      
        if (viewController) {
            
            [self presentViewController:viewController animated:YES completion:^{
               
                NSLog(@"Displayed Login Screen");
                
            }];
            
        } else if (localPlayer.isAuthenticated) {
            
            [self enableGameCenterWithPlayer:localPlayer];
            NSLog(@"Local Player Authenticated");
            self->_gameCenterEnabled = YES;
            
        } else {
            
            [self disableGameCenter];
            NSLog(@"Failed To Authenticate Local Player");
            self->_gameCenterEnabled = NO;
        }
        
    };
    
}

- (void)enableGameCenterWithPlayer:(GKLocalPlayer *)localPlayer {
    
}

- (void)disableGameCenter {
    
}

#pragma mark - Public Instance Methods

- (void)enableBoard {
    
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            SGBoardPiece *piece = (SGBoardPiece *)[self.view viewWithTag:self->_pieces[x][y]];
            [UIView animateWithDuration:1.0
                             animations:^{
                                 
                                 piece.alpha = 1.0;
                                 
                             }
                             completion:^(BOOL finished) {
                                 
                                 NSLog(@"Board Enabled");
                                 
                             }];
            
        }
        
    }
    self->_boardEnabled = YES;
    
}

- (void)disableBoard {
    
    for (int x = 0; x < 4; x++) {
        
        for (int y = 0; y < 4; y++) {
            
            SGBoardPiece *piece = (SGBoardPiece *)[self.view viewWithTag:self->_pieces[x][y]];
            [UIView animateWithDuration:1.0
                             animations:^{
                                 
                                 piece.alpha = 0.3;
                                 
                             }completion:^(BOOL finished) {
                                 
                                 NSLog(@"Board Disabled");
                                 
                             }];
            
        }
        
    }
    self->_boardEnabled = NO;
    
}

#pragma mark - Actions

- (IBAction)userSwipeLeft:(id)sender {
    
    NSLog(@"Swipe Left");
    if ([self.board slideLeft] && self.isBoardEnabled) {
        
        [self.board dropRandom];
        [self updateBoardScreenWithTransition:UIViewAnimationOptionTransitionCrossDissolve];
        
    }
    NSLog(@"%@", self.board);
    
}

- (IBAction)userSwipeRight:(id)sender {
    
    NSLog(@"Swipe Right");
    if ([self.board slideRight] && self.isBoardEnabled) {
        
        [self.board dropRandom];
        [self updateBoardScreenWithTransition:UIViewAnimationOptionTransitionCrossDissolve];
        
    }
    NSLog(@"%@", self.board);
    
}

- (IBAction)userSwipeUp:(id)sender {
    
    NSLog(@"Swipe Up");
    if ([self.board slideUp] && self.isBoardEnabled) {
        
        [self.board dropRandom];
        [self updateBoardScreenWithTransition:UIViewAnimationOptionTransitionCrossDissolve];
        
    }
    NSLog(@"%@", self.board);
    
}

- (IBAction)userSwipeDown:(id)sender {
    
    NSLog(@"Swipe Down");
    if ([self.board slideDown] && self.isBoardEnabled) {
        
        [self.board dropRandom];
        [self updateBoardScreenWithTransition:UIViewAnimationOptionTransitionCrossDissolve];
        
    }
    NSLog(@"%@", self.board);
    
}

- (IBAction)userNewGame:(id)sender {
    
    [self enableBoard];
    self.board = [[SGBoard alloc] init];
    [self updateBoardScreenWithTransition:UIViewAnimationOptionTransitionCrossDissolve];
    
}
@end
