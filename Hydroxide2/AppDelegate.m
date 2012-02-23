//
//  AppDelegate.m
//  Hydroxide2
//
//  Created by Craig Stanford on 16/02/12.
//  Copyright (c) 2012 Monsterbomb. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"
#import "DataManager.h"
#import "Section+Additions.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MagicalRecordHelpers setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"HydroxideModel"];

    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(appReady) 
                                                 name:kHydroxideConfigSuccess 
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(configFailure) 
                                                 name:kHydroxideConfigFailure 
                                               object:nil];
    
    [[DataManager sharedDataManager] updateSections];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if([Section hasAtLeastOneEntity])
        [self appReady];
    else
    {
        UIImageView* splashImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]];
        UIViewController* splashViewController = [[UIViewController alloc] init];
        [splashViewController.view addSubview:splashImageView];
        self.window.rootViewController = splashViewController;
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)appReady
{
    self.viewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHydroxideConfigSuccess object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHydroxideConfigFailure object:nil];
}

- (void)configFailure
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Unable to load app" 
                                                    message:@"This app requires an internet connection to function. Please check your connection & try again" 
                                                   delegate:nil 
                                          cancelButtonTitle:nil 
                                          otherButtonTitles:@"Retry", nil];
    [alert show];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
