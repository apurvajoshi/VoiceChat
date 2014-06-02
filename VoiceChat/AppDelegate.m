//
//  AppDelegate.m
//  VoiceChat
//
//  Created by Apurva Joshi on 5/25/14.
//  Copyright (c) 2014 SayIt. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"ctBI3x89h2jDYa4vCfSBW0YNcJQ3TpnFUhBgQHwX"
                  clientKey:@"k7dApninmD8DbkqW7WMSI2bygADvMVBZFX6W7Gov"];
    
//    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
//     UIRemoteNotificationTypeAlert|
//     UIRemoteNotificationTypeSound];
//    
    [self handleLogin];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults stringForKey:@"chatName"]) {
        // first time it's run, create a userDefault
        [defaults setObject:@"Chat Name" forKey:@"chatName"];
        [defaults synchronize];
    }

    
    return YES;
}

- (void)signUp {
    PFUser *user = [PFUser user];
    user.username = @"Sunil Kumar D M";
    user.password = @"sunil";
    
    // other fields can be set just like with PFObject
    user[@"phone"] = @"4129965318";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            // Associate the device with a user
            [self handleLogin];
        } else {
            // Show the errorString somewhere and let the user try again.
        }
    }];
}

- (void)handleLogin {
    [PFUser logInWithUsernameInBackground:@"Sunil Kumar D M" password:@"sunil"
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            PFInstallation *installation = [PFInstallation currentInstallation];
                                            installation[@"user"] = [PFUser currentUser];
                                            installation[@"phone"] = @"4129965318";
                                            [installation saveInBackground];

                                        } else {
                                            // The login failed. Check error to see why.
                                            [self signUp];
                                        }
                                    }];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
//    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
//    [currentInstallation setDeviceTokenFromData:deviceToken];
//    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //[PFPush handlePush:userInfo];
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

@end
