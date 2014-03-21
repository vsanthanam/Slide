//
//  SGAppDelegate.m
//  Slide
//
//  Created by Varun Santhanam on 3/18/14.
//  Copyright (c) 2014 Varun Santhanam. All rights reserved.
//

#import "SGAppDelegate.h"

@implementation SGAppDelegate

static NSString *tokenKey = @"iCloudToken";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // Handle iCloud Setup
    id currentiCloudToken = [[NSFileManager defaultManager] ubiquityIdentityToken];
    if (currentiCloudToken) {
        
        NSData *newTokenData = [NSKeyedArchiver archivedDataWithRootObject:currentiCloudToken];
        [[NSUserDefaults standardUserDefaults] setObject:newTokenData forKey:tokenKey];
        
    } else {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:tokenKey];
        
    }
    
    // iCloud Availability Changed
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iCloudAvailabilityChanged) name:NSUbiquityIdentityDidChangeNotification object:nil];
    
    // iCloud Data Push While Active
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storeDidChange:) name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification object:[NSUbiquitousKeyValueStore defaultStore]];
    
    // iCloud Data Change While Inactive
    [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// Handle Changes in iCloud Availability
- (void)iCloudAvailabilityChanged {
    
    NSLog(@"iCloud Account Aviliability Changed");
    
    id currentiCloudToken = [[NSFileManager defaultManager] ubiquityIdentityToken];
    if (!currentiCloudToken) {
        
        NSLog(@"iCloud Signed Out");
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:tokenKey];
        [[NSUserDefaults standardUserDefaults] setBool:@"iCloud" forKey:NO];
        
    } else {
        
        NSLog(@"New iCloud Account");
        
        if (![currentiCloudToken isEqual:[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:tokenKey]]]) {
            
            NSData *newTokenData = [NSKeyedArchiver archivedDataWithRootObject:currentiCloudToken];
            [[NSUserDefaults standardUserDefaults] setObject:newTokenData forKey:tokenKey];
            // Refresh UI -- New iCloud Account
            
            if ([[NSUbiquitousKeyValueStore defaultStore] longLongForKey:@"highscore"]) {
                
                [[NSUserDefaults standardUserDefaults] setInteger:[[NSUbiquitousKeyValueStore defaultStore] longLongForKey:@"highscore"] forKey:@"highscore"];
                
            }
            
        } else {
            
            NSLog(@"Same iCloud Account");
            
        }
        
    }
    
}

// Handle Changes In iCloud KV Data
- (void)storeDidChange:(NSUbiquitousKeyValueStore *)store {
    
    NSLog(@"Recieved New iCloud Data From Push");
    
    if ([[NSUbiquitousKeyValueStore defaultStore] longLongForKey:@"highscore"]) {
        
        [[NSUserDefaults standardUserDefaults] setInteger:[[NSUbiquitousKeyValueStore defaultStore] longLongForKey:@"highscore"] forKey:@"highscore"];
        
    }
    
}

@end
