//
//  ViewController.h
//  Hydroxide2
//
//  Created by Craig Stanford on 16/02/12.
//  Copyright (c) 2012 Monsterbomb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UINavigationController* navController;
@property (nonatomic, strong) WebViewController* webViewController;
@property (nonatomic, strong) NSArray* sections;
@property (nonatomic) NSInteger currentSectionId;

- (void)showHideTableView;

@end
