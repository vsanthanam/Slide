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
@synthesize achievementsDictionary = _achievementsDictionary;
@synthesize leaderboards = _leaderboards;

@synthesize scoreLabel = _scoreLabel;
@synthesize highSchoreLabel;
@synthesize playAgainButton = _playAgainButton;
@synthesize endLabel = _endLabel;
@synthesize shareButton = _shareButton;
@synthesize leaderboardButton = _leaderboardButton;
@synthesize achievementsButton = _achievementsButton;
@synthesize nameLabel = _nameLabel;

#pragma mark - Property Access Methods

- (BOOL)isGameCenterEnabled {
    
    return self->_gameCenterEnabled;
    
}

- (BOOL)isBoardEnabled {
    
    return self->_boardEnabled;
    
}

- (BOOL)isiCloudEnabled {
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"iCloud"];
    
}

#pragma mark - ADBannerViewDelegate Protocol Instance Methods

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    
    [self showAds];
    
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    
    if (error != NULL) {
        
        [self hideAds];
        
    }
    
}

#pragma mark - GKGameCenterViewControllerDelegate Protocol Instance Methods

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Overridden Instance Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
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
        self.achievementsDictionary = [[NSMutableDictionary alloc] init];
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.board = [[SGBoard alloc] init];
    self->_boardEnabled = YES;
    [self updateBoardScreenWithTransition:UIViewAnimationOptionTransitionCrossDissolve];
    self.adBanner.delegate = self;
    self.nameLabel.text = @"";

}

- (void)viewDidAppear:(BOOL)animated {
    
    [self disableGameCenter];
    
    if (!self.adBanner.isBannerLoaded) {
        
        [self hideAds];
        
    }
    
    [self authenticateLocalPlayer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Instance Methods

- (void)updateBoardScreenWithTransition:(UIViewAnimationOptions)transition {
    
    if (self.isiCloudEnabled) {
        
        NSLog(@"Yes iCloud");
        NSLog(@"%li on Device, %lli on iCloud", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"], [[NSUbiquitousKeyValueStore defaultStore] longLongForKey:@"highscore"]);
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"] || [[NSUbiquitousKeyValueStore defaultStore] longLongForKey:@"highscore"]) {
            
            NSInteger highscore = MAX([[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"], [[NSUbiquitousKeyValueStore defaultStore] longLongForKey:@"highscore"]);
            NSLog(@"Using %li", (long)highscore);
            [UIView animateWithDuration:0.5
                             animations:^{
                                
                                 self.highSchoreLabel.alpha = 1;
                                 
                             }];
            
            self.highSchoreLabel.text = [NSString stringWithFormat:@"Best: %li", (long)highscore];
            
        }
        
    } else {
        
        NSLog(@"No iCloud");
        
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"]) {
            
            [UIView animateWithDuration:0.5
                             animations:^{
                                 self.highSchoreLabel.alpha = 1;
                             }];
            
            self.highSchoreLabel.text = [NSString stringWithFormat:@"Best: %li", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"]];
            
        }
        
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
        
        if (![[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"] && ![[NSUbiquitousKeyValueStore defaultStore] longLongForKey:@"highscore"]) {
            
            [[NSUserDefaults standardUserDefaults] setInteger:self.board.score forKey:@"highscore"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            GKLeaderboard *highscoreboard = [self leaderboardForIdentifier:@"com.varunsanthanam.slide.highscoreboard"];
            [self reportScore:[[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"] forLeaderboardID:highscoreboard.identifier];
            if (self.isiCloudEnabled) {
                
                [[NSUbiquitousKeyValueStore defaultStore] setLongLong:self.board.score forKey:@"highscore"];
                
            }
            
        } else {
            
            NSInteger pastScore = MAX([[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"], [[NSUbiquitousKeyValueStore defaultStore] longLongForKey:@"highscore"]);
            if (self.board.score > pastScore) {
                
                [[NSUserDefaults standardUserDefaults] setInteger:self.board.score forKey:@"highscore"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                GKLeaderboard *highscoreboard = [self leaderboardForIdentifier:@"com.varunsanthanam.slide.highscoreboard"];
                [self reportScore:[[NSUserDefaults standardUserDefaults] integerForKey:@"highscore"] forLeaderboardID:highscoreboard.identifier];
                if (self.isiCloudEnabled) {
                    
                    [[NSUbiquitousKeyValueStore defaultStore] setLongLong:self.board.score forKey:@"highscore"];
                    
                }
                
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
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
            
            [self performSegueWithIdentifier:@"welcomeSegue" sender:self];
            
        }
        
    };
    
}

- (void)enableGameCenterWithPlayer:(GKLocalPlayer *)localPlayer {
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         
                         self.achievementsButton.alpha = 1.0;
                         self.leaderboardButton.alpha = 1.0;
                         self.nameLabel.alpha = 1.0;
                         
                     }];
    self.nameLabel.text = localPlayer.alias;
    
    [self loadAchievements];
    [self loadLeaderboardInfo];
    
}

- (void)disableGameCenter {
    
    [UIView animateWithDuration:1.0
                     animations:^{
                        
                         self.achievementsButton.alpha = 0.0;
                         self.leaderboardButton.alpha = 0.0;
                         self.nameLabel.alpha = 0.0;
                         
                     }];
    
}

- (void)loadAchievements {
    
    [GKAchievement loadAchievementsWithCompletionHandler:^(NSArray *achievements, NSError *error) {
       
        if (error == nil) {
            
            for (GKAchievement *achievement in achievements) {
        
                [self.achievementsDictionary setObject:achievement forKey:achievement.identifier];
                
            }
            
        }
        
    }];
    
}

- (GKAchievement *)achievementForIdentifier:(NSString *)identifier {
    
    GKAchievement *achievement = [self.achievementsDictionary objectForKey:identifier];
    
    if (!achievement) {
        
        achievement = [[GKAchievement alloc] initWithIdentifier:identifier];
        achievement.showsCompletionBanner = YES;
        [self.achievementsDictionary setObject:achievement forKey:identifier];
        
    }
    
    return achievement;
    
}

- (void)reportAchievement:(NSString *)identifier percentComplete:(float)percent {
    
    GKAchievement *achievement = [self achievementForIdentifier:identifier];
    if (achievement && achievement.percentComplete < percent) {
        
        achievement.percentComplete = percent;
        [GKAchievement reportAchievements:@[achievement]
                    withCompletionHandler:^(NSError *error) {
                       
                        if (error != NULL) {
                            
                            NSLog(@"Failed To Report Achievement %@ With Error: %@", identifier, error);
                            
                        } else {
                            
                            NSLog(@"Reported Achievement %@ at %f", identifier, percent);
                            
                        }
                        
                    }];
        
    }
    
}

- (void)loadLeaderboardInfo {
    
    [GKLeaderboard loadLeaderboardsWithCompletionHandler:^(NSArray *leaderboards, NSError *error) {
       
        if (!error) {
            
            self.leaderboards = leaderboards;
            
        }
        
    }];
    
}

- (GKLeaderboard *)leaderboardForIdentifier:(NSString *)identifier {
    
    for (GKLeaderboard *leaderboard in self.leaderboards) {
        
        if ([leaderboard.identifier isEqualToString:identifier]) {
            
            return leaderboard;
            
        }
        
    }
    
    NSLog(@"Leader Board With ID %@ Not Found", identifier);
    return nil;
    
}

- (void)reportScore:(int64_t)score forLeaderboardID:(NSString *)identifier {
    
    GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier:identifier];
    scoreReporter.value = score;
    [GKScore reportScores:@[scoreReporter]
    withCompletionHandler:^(NSError *error) {
       
        if (!error) {
            
            NSLog(@"Reporting Score %lli for Leaderboard ID %@", score, identifier);
            
        } else {
            
            NSLog(@"Failed To Report Score With Error: %@", error);
            
        }
        
    }];
    
}

#pragma mark - Public Instance Methods

- (void)enableBoard {
    
    if (!self.isBoardEnabled) {
        
        [UIView animateWithDuration:1.0
                         animations:^{
                            
                             self.playAgainButton.alpha = 0.0;
                             self.endLabel.alpha = 0.0;
                             self.shareButton.alpha = 0.0;
                             
                         }];
        
        for (int x = 0; x < 4; x++) {
            
            for (int y = 0; y < 4; y++) {
                
                SGBoardPiece *piece = (SGBoardPiece *)[self.view viewWithTag:self->_pieces[x][y]];
                [UIView animateWithDuration:1.0
                                 animations:^{
                                     
                                     piece.alpha = 1.0;
                                     
                                 }];
                
            }
            
        }
        self->_boardEnabled = YES;
        
    }
    
}

- (void)disableBoard {
    
    if (self.isBoardEnabled) {
        
        self->_boardEnabled = NO;
        
        [UIView animateWithDuration:1.0
                         animations:^{
                             
                             self.playAgainButton.alpha = 1.0;
                             self.endLabel.alpha = 1.0;
                             self.shareButton.alpha = 1.0;
                             
                         }];
        
        self.endLabel.text = [NSString stringWithFormat:@"Score: %li", (long)self.board.score];
        
        for (int x = 0; x < 4; x++) {
            
            for (int y = 0; y < 4; y++) {
                
                SGBoardPiece *piece = (SGBoardPiece *)[self.view viewWithTag:self->_pieces[x][y]];
                [UIView animateWithDuration:1.0
                                 animations:^{
                                     
                                     piece.alpha = 0.2;
                                     
                                 }];
                
            }
            
        }
        
    }
    
}

- (void)showAds {
    
    [UIView animateWithDuration:0.5
                     animations:^{
                        
                         self.adBanner.alpha = 1.0;
                         
                     }
                     completion:^(BOOL finished) {
                         
                         NSLog(@"Ads Hidden");
                         
                     }];
    
}

- (void)hideAds {
    
    [UIView animateWithDuration:0.5
                     animations:^{
                        
                         self.adBanner.alpha = 0.0;
                         
                     }
                     completion: ^(BOOL finished) {
                         
                         NSLog(@"Ads Visible");
                         
                     }];
    
}

- (void)checkGameAchievements:(SGBoard *)board {
    
}

- (void)checkSwipeAchievements:(SGBoard *)board {
    
    // Check 2048 Achievement
    // com.varunsanthanam.slide.2048
    SGBoardSquare tile = board.biggestTile;
    static NSString *_2048 = @"com.varunsanthanam.slide.2048";
    switch (tile) {
        case SGBoardSquare4:
            [self reportAchievement:_2048 percentComplete:10.0];
            break;

        case SGBoardSquare8:
            [self reportAchievement:_2048 percentComplete:20.0];
            break;
            
        case SGBoardSquare16:
            [self reportAchievement:_2048 percentComplete:30.0];
            break;
            
        case SGBoardSquare32:
            [self reportAchievement:_2048 percentComplete:40.0];
            break;
            
        case SGBoardSquare64:
            [self reportAchievement:_2048 percentComplete:50.0];
            break;
            
        case SGBoardSquare128:
            [self reportAchievement:_2048 percentComplete:60.0];
            break;
        
        case SGBoardSquare256:
            [self reportAchievement:_2048 percentComplete:70.0];
            break;
        
        case SGBoardSquare512:
            [self reportAchievement:_2048 percentComplete:80.0];
            break;
        
        case SGBoardSquare1024:
            [self reportAchievement:_2048 percentComplete:90.0];
            break;
        
        case SGBoardSquare2048:
            [self reportAchievement:_2048 percentComplete:100.0];
            break;
        
        default:
            NSLog(@"Unknown Biggest Tile");
            break;
            
    }
    
    // Check 4096 Achievement
    // com.varunsanthanam.slide.4096
    static NSString *_4096 = @"com.varunsanthanam.slide.4096";
    if (board.score == 4096) {
        
        [self reportAchievement:_4096 percentComplete:100.0];
        
    }
    
}

#pragma mark - Actions

- (IBAction)userSwipeLeft:(id)sender {
    
    NSLog(@"Swipe Left");
    if ([self.board slideLeft] && self.isBoardEnabled) {
        
        [self.board dropRandom];
        [self updateBoardScreenWithTransition:UIViewAnimationOptionTransitionCrossDissolve];
        if (self.isGameCenterEnabled) {
            [self checkSwipeAchievements:self.board];
        }
        
    }
    NSLog(@"%@", self.board);
    
}

- (IBAction)userSwipeRight:(id)sender {
    
    NSLog(@"Swipe Right");
    if ([self.board slideRight] && self.isBoardEnabled) {
        
        [self.board dropRandom];
        [self updateBoardScreenWithTransition:UIViewAnimationOptionTransitionCrossDissolve];
        if (self.isGameCenterEnabled) {
            [self checkSwipeAchievements:self.board];
        }
        
    }
    NSLog(@"%@", self.board);
    
}

- (IBAction)userSwipeUp:(id)sender {
    
    NSLog(@"Swipe Up");
    if ([self.board slideUp] && self.isBoardEnabled) {
        
        [self.board dropRandom];
        [self updateBoardScreenWithTransition:UIViewAnimationOptionTransitionCrossDissolve];
        if (self.isGameCenterEnabled) {
            [self checkSwipeAchievements:self.board];
        }
        
    }
    NSLog(@"%@", self.board);
    
}

- (IBAction)userSwipeDown:(id)sender {
    
    NSLog(@"Swipe Down");
    if ([self.board slideDown] && self.isBoardEnabled) {
        
        [self.board dropRandom];
        [self updateBoardScreenWithTransition:UIViewAnimationOptionTransitionCrossDissolve];
        if (self.isGameCenterEnabled) {
            [self checkSwipeAchievements:self.board];
        }
        
    }
    NSLog(@"%@", self.board);
    
}

- (IBAction)userNewGame:(id)sender {
    
    [self enableBoard];
    [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    self.board = [[SGBoard alloc] init];
    [self updateBoardScreenWithTransition:UIViewAnimationOptionTransitionCrossDissolve];
    
}

- (IBAction)userShareGame:(id)sender {

    NSString *shareMessaage = [NSString stringWithFormat:@"I just got %li score playing Slide - 2048 for iPhone! My biggest tile was %i, can you beat that?", (long)self.board.score, self.board.biggestTile];
    
    UIActivityViewController *viewController = [[UIActivityViewController alloc] initWithActivityItems:@[shareMessaage] applicationActivities:nil];
    viewController.excludedActivityTypes = @[UIActivityTypeCopyToPasteboard, UIActivityTypeAirDrop];
    viewController.completionHandler = ^(NSString *activityType, BOOL completed) {
       
        if (completed) {
            
            [self enableBoard];
            self.board = [[SGBoard alloc] init];
            [self updateBoardScreenWithTransition:UIViewAnimationOptionTransitionCrossDissolve];
            
        }
        
    };
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)userShowAchievements:(id)sender {
    
    GKGameCenterViewController *viewController = [[GKGameCenterViewController alloc] init];
    if (viewController) {
        
        viewController.gameCenterDelegate = self;
        viewController.viewState = GKGameCenterViewControllerStateAchievements;
        [self presentViewController:viewController animated:YES completion:nil];
        
    }
    
}

- (IBAction)userShowLeaderboard:(id)sender {
    
    GKLeaderboard *highscoreboard = [self leaderboardForIdentifier:@"com.varunsanthanam.slide.highscoreboard"];
    if (highscoreboard) {
        
        GKGameCenterViewController *viewController = [[GKGameCenterViewController alloc] init];
        viewController.gameCenterDelegate = self;
        viewController.view = GKGameCenterViewControllerStateLeaderboards;
        viewController.leaderboardIdentifier = highscoreboard.identifier;
        [self presentViewController:viewController animated:YES completion:nil];
        
    }
    
}

@end
