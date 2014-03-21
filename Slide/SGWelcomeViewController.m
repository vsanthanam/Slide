//
//  SGWelcomeViewController.m
//  Slide
//
//  Created by Varun Santhanam on 3/21/14.
//  Copyright (c) 2014 Varun Santhanam. All rights reserved.
//

#import "SGWelcomeViewController.h"

@interface SGWelcomeViewController ()

@end

@implementation SGWelcomeViewController {
    
    NSInteger _pieces[4];
    SGBoardSquare _values[4];
    NSInteger _tutorialStep;
    
}

@synthesize helperTextLabel = _helperTextLabel;

#pragma mark - Overridden Instance Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self->_pieces[0] = 1;
        self->_pieces[1] = 2;
        self->_pieces[2] = 3;
        self->_pieces[3] = 4;
        self->_values[0] = SGBoardSquare2;
        self->_values[1] = SGBoardSquare2;
        self->_values[2] = SGBoardSquareE;
        self->_values[3] = SGBoardSquareE;
        self->_tutorialStep = 0;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateBoard];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Instance Methods

- (void)updateBoard {
    
    for (int x = 0; x < 4; x++) {
        
        SGBoardPiece *piece = (SGBoardPiece *)[self.view viewWithTag:self->_pieces[x]];
        [UIView transitionWithView:piece
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            
                            piece.status = self->_values[x];
                            
                        }completion:nil];
        
    }
    
}

#pragma mark - Actions

- (IBAction)userSwipeRight:(id)sender {
    
    if (self->_tutorialStep == 0) {
        
        self->_values[0] = SGBoardSquare4;
        self->_values[1] = SGBoardSquareE;
        self->_values[2] = SGBoardSquareE;
        self->_values[3] = SGBoardSquare4;
        [self updateBoard];
        self->_tutorialStep++;
        self.helperTextLabel.text = @"< < < now, swipe left.";
        
    } else if (self->_tutorialStep == 2) {
        
        self->_values[0] = SGBoardSquareE;
        self->_values[1] = SGBoardSquare4;
        self->_values[2] = SGBoardSquare8;
        self->_values[3] = SGBoardSquare2;
        [self updateBoard];
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"iCloudToken"]) {
            
            [self performSegueWithIdentifier:@"iCloudSegue" sender:sender];
            
        } else {
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
            [self.presentingViewController dismissViewControllerAnimated:YES completion:NO];
            
        }
        
    }
    
}

- (IBAction)userSwipeLeft:(id)sender {
    
    if (self->_tutorialStep == 1) {
        
        self->_values[0] = SGBoardSquare8;
        self->_values[1] = SGBoardSquareE;
        self->_values[2] = SGBoardSquare2;
        self->_values[3] = SGBoardSquareE;
        [self updateBoard];
        self->_tutorialStep++;
        
    }
    
    self.helperTextLabel.text = @"get the idea?";
    
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.helperTextLabel.alpha = 0.0;
                         
                     }completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.5
                                          animations:^{
                                             
                                              self.helperTextLabel.alpha = 1.0;
                                              
                                          }];
                         self.helperTextLabel.text = @"now, swipe right again. > > >";
                         
                     }];
    
}
@end
