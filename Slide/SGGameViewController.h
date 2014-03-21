//
//  SGGameViewController.h
//  Slide
//
//  Created by Varun Santhanam on 3/18/14.
//  Copyright (c) 2014 Varun Santhanam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import <iAd/iAd.h>

#import "SGBoard.h"
#import "SGBoardPiece.h"

@interface SGGameViewController : UIViewController <ADBannerViewDelegate, GKGameCenterControllerDelegate>

@property (nonatomic, strong) SGBoard *board;
@property (nonatomic, assign, readonly, getter = isGameCenterEnabled) BOOL gameCenterEnabled;
@property (nonatomic, assign, readonly, getter = isBoardEnabled) BOOL boardEnabled;
@property (nonatomic, readonly, getter = isiCloudEnabled) BOOL iCloudEnabled;
@property (nonatomic, strong) NSMutableDictionary *achievementsDictionary;
@property (nonatomic, strong) NSArray *leaderboards;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highSchoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *playAgainButton;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet ADBannerView *adBanner;
@property (weak, nonatomic) IBOutlet UIButton *achievementsButton;
@property (weak, nonatomic) IBOutlet UIButton *leaderboardButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (void)enableBoard;
- (void)disableBoard;
- (void)showAds;
- (void)hideAds;
- (void)checkSwipeAchievements:(SGBoard *)board;
- (void)checkGameAchievements:(SGBoard *)board;

- (IBAction)userSwipeLeft:(id)sender;
- (IBAction)userSwipeRight:(id)sender;
- (IBAction)userSwipeUp:(id)sender;
- (IBAction)userSwipeDown:(id)sender;
- (IBAction)userNewGame:(id)sender;
- (IBAction)userShareGame:(id)sender;
- (IBAction)userShowAchievements:(id)sender;
- (IBAction)userShowLeaderboard:(id)sender;


@end
