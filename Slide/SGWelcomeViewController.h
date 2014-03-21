//
//  SGWelcomeViewController.h
//  Slide
//
//  Created by Varun Santhanam on 3/21/14.
//  Copyright (c) 2014 Varun Santhanam. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SGBoard.h"
#import "SGBoardPiece.h"

@interface SGWelcomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *helperTextLabel;

- (IBAction)userSwipeRight:(id)sender;
- (IBAction)userSwipeLeft:(id)sender;

@end
