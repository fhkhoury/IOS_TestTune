# IOS_TestTune

## Project Creation

1. Open Xcode and create an iPhone  Swift project and save it 

2. Close Xcode

## Tune SDK Installation

1. In project root directory, create the Podfile

	pod init		
		
2. Add Tune pod in the Podfile
	
	pod 'Tune'

3. Install the Tune pod
	
	pod install

4. Reopen Xcode and add, in 'Linking', the $(inherited) flag to "Other Linker Flags" in the Xcode project Build Settings.

## Tune SDK Init

1. First, in 'Apple LLVM 7.0 - Language - Modules', make sure your app has Enable Modules (C and Objective-C) set to YES in your Build Settings.

2. In 'AppDelegate.m' file, import Tune and Initialize it

	@import Tune;
 
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
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

    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Attribution will not function without the measureSession call included
    [Tune measureSession];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // when the app is opened due to a deep link, call the Tune deep link setter
    [Tune applicationDidOpenURL:[url absoluteString] sourceApplication:sourceApplication];

    return YES;
}

3. Fill the 'AdvertizerId' and the 'TuneConversionKey' given in the app interface. You can find more info to retrieve these data [here](http://developers.mobileapptracking.com/finding-advertiser-id-conversion-key/)


## Create the Facebook App

1. [Create your app](https://developers.facebook.com/quickstarts/)

2. Link [Ad Accounts](https://developers.facebook.com/apps/)


## Install Facebook SDK (to measure App Install)

1. Download the SDK at https://developers.facebook.com/docs/ios or via CocoaPods by adding the 'FBSDKCoreKit', 'FBSDKLoginKit', and 'FBSDKShareKit' pods.

2. Test your install: build and run the project at ~/Documents/FacebookSDK/Samples/Scrumptious/Scrumptious.xcodeproj


3. To measure App install in Facebook, add the code below in 'AppDelegate.m', in the 'ApplicationDidBecomeActive' function :

	[FBSDKAppEvents activateApp];
	
4. Verify Setup [here](https://developers.facebook.com/tools/app-ads-helper/)
	
## Facebook Deep Linking in App Ads

1. Enable deeplink in the app by following [this tutorial](http://blog.originate.com/blog/2014/04/22/deeplinking-in-ios/)

* To enable deep linking, go to the Info tab in the Xcode project. In the URL Types section, click on the + button, and then add an identifier and a URL scheme. Ensure that the identifier and URL scheme you select are unique. Take note of the URL scheme you enter, as this is how iOS knows to open a link in your app. The sample app registers the following url scheme:

	dlapp

* To confirm that your URL scheme has been registered, check Info.plist for an entry named ‘URL Types’. Expanding it will show you the new URL scheme you just registered. You can check that this is working by typing the following url into Safari Mobile: your-url-scheme:// ( For the sample app, it would be: dlapp://). This should open up your app. If not, please go through this section again before moving on.

2. Create few deeplinks to differetns screens if you want (optionnal)

3. Facebook App Settings

* Once you completed the initial Facebook SDK Setup you need to add deep linking information in your Facebook app settings.

	* URL Scheme Suffix: Add your URL scheme without ://, e.g. mytravelapp if your URL scheme is mytravelapp://.

	* App Store ID: You can get your App Store ID for example from your [App Store URL:](https://itunes.apple.com/us/app/my-app/APP_STORE_ID).

4. Enable Deffered Deeplink 

* Deferred deep linking allows you to send people to a custom view after they installed your app via the app store.

* You must add deferred deep linking to an ad using deep linking, if you target people who did not install your app yet. If you are only targeting people who already installed your app, you do not need to add deferred deep linking.

* Add this code in 'didFinishLaunchWithOptions' func in 'AppDelegate.m' file : 

	[FBSDKAppLinkUtility fetchDeferredAppLink:^(NSURL *url, NSError *error) {
      if (error) {
        NSLog(@"Received error while fetching deferred app link %@", error);
      }
      if (url) {
        [[UIApplication sharedApplication] openURL:url];
      }
    }];


5. Verify Deep Link Setup

* You can verify your Facebook SDK and deep link setup within our App Ads Helper in the tools & support section. We recommend to verify your setup before you start running deep link ads.

* [Verify Deep Link Setup](https://developers.facebook.com/tools/app-ads-helper/)


6. Add your app deeplink to your Ad

* When creating your ad pay attention to the following settings:

	* Target Platform: In "Who do you want your ads to reach?" use:
		* iOS: iOS only for the setting platform.
		* Android: Android only for the setting platform.

	* Add Deep Link: In "What text and links do you want to use?" add your deep link, e.g. mytravelapp://tripId=SF as shown in the screenshot below.





