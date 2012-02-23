//
//  WebViewController.h
//  Hydroxide2
//
//  Created by Craig Stanford on 16/02/12.
//  Copyright (c) 2012 Monsterbomb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HydroxideWebView.h"
#import "Section+Additions.h"

@interface WebViewController : UIViewController <HydroxideWebViewDelegate>

@property (nonatomic, strong) IBOutlet HydroxideWebView* webView;
@property (nonatomic, strong) IBOutlet HydroxideWebView* offscreenWebView;
@property (nonatomic, strong) Section* section;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil section:(Section*)section;
- (void)transitionToSection:(Section*)section;

@end
