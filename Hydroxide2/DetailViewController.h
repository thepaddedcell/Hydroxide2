//
//  DetailViewController.h
//  Hydroxide2
//
//  Created by Craig Stanford on 24/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HydroxideWebView.h"

@interface DetailViewController : UIViewController <UIActionSheetDelegate>

@property (nonatomic, retain) IBOutlet HydroxideWebView* webView;

@end
