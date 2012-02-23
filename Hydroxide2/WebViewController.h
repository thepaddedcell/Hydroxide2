//
//  WebViewController.h
//  Hydroxide2
//
//  Created by Craig Stanford on 16/02/12.
//  Copyright (c) 2012 Monsterbomb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HydroxideWebView.h"

@interface WebViewController : UIViewController <HydroxideWebViewDelegate>

@property (nonatomic, strong) IBOutlet HydroxideWebView* webView;
@property (nonatomic, strong) IBOutlet HydroxideWebView* offscreenWebView;
@property (nonatomic, strong) NSArray* sections;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil sections:(NSArray *)sections;

@end
