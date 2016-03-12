//
//  AppDelegate.m
//  IOS_TestTune
//
//  Created by François K on 12/03/2016.
//  Copyright © 2016 François K. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

@import Tune;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Account Configuration info - must be set
    [Tune initializeWithTuneAdvertiserId:@"your_advertiser_ID"
                       tuneConversionKey:@"your_conversion_key"];
    
    // Check if a deferred deeplink is available and handle opening of the deeplink as appropriate in the success tuneDidReceiveDeeplink: callback.
    // Uncomment this line if your TUNE account has enabled deferred deeplinks
    //[Tune checkForDeferredDeeplink:self];
    
    // Uncomment this line to enable auto-measurement of successful in-app-purchase (IAP) transactions as "purchase" events
    //[Tune automateIapEventMeasurement:YES];
    
    // If your app already has a pre-existing user base before you implement the Tune SDK, then
    // identify the pre-existing users with this code snippet.
    // Otherwise, TUNE counts your pre-existing users as new installs the first time they run your app.
    // Omit this section if you're upgrading to a newer version of the Tune SDK.
    // This section only applies to NEW implementations of the Tune SDK.
    //BOOL isExistingUser = ...
    //if (isExistingUser) {
    //    [Tune setExistingUser:YES];
    //}
    
    //For Facebook Deferred Deeplink
    [FBSDKAppLinkUtility fetchDeferredAppLink:^(NSURL *url, NSError *error) {
        if (error) {
            NSLog(@"Received error while fetching deferred app link %@", error);
        }
        if (url) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    // Attribution will not function without the measureSession call included
    [Tune measureSession];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // when the app is opened due to a deep link, call the Tune deep link setter
    [Tune applicationDidOpenURL:[url absoluteString] sourceApplication:sourceApplication];
    
    return YES;
}

@end
