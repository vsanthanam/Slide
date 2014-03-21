//
//  SGiCloudViewController.m
//  Slide
//
//  Created by Varun Santhanam on 3/21/14.
//  Copyright (c) 2014 Varun Santhanam. All rights reserved.
//

#import "SGiCloudViewController.h"

@interface SGiCloudViewController ()

@end

@implementation SGiCloudViewController

@synthesize iCloudSwitch = _iCloudSwitch;

#pragma mark - Overridden Instance Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)userCloseTutorial:(id)sender {
    
    if ([self.iCloudSwitch isOn]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"iCloud"];
        
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}
@end
