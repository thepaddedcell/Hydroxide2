//
//  WebViewController.m
//  Hydroxide2
//
//  Created by Craig Stanford on 16/02/12.
//  Copyright (c) 2012 Monsterbomb. All rights reserved.
//

#import "WebViewController.h"
#import "Section+Additions.h"

@implementation WebViewController

@synthesize webView=_webView;
@synthesize offscreenWebView=_offscreenWebView;
@synthesize sections=_sections;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil sections:(NSArray *)sections
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        self.sections = sections;
        //force the webview to load early so we can load a URL from the Parent View Controller
        self.webView.frame = self.view.bounds;
        self.offscreenWebView.frame = self.view.bounds;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

# pragma mark - Hydroxide Webview Delegate

- (void)webView:(HydroxideWebView *)webView messageFromWeb:(NSDictionary *)info
{
    NSString* message = [info valueForKey:kHydroxideWebMessageInfoKey];
    if ([message isEqualToString:@"detail"]) 
    {
        //push a detail view onto the stack
    }
    
    if ([message isEqualToString:@"goto"])
    {
        NSString* sectionName = [info valueForKey:@"view"];
        //switch sections, with some animation
        for (Section* section in self.sections) 
        {
            if ([section.title isEqualToString:sectionName]) 
            {
                [self.offscreenWebView loadURL:section.url];
                break;
            }
        }
        
        CGRect webviewFrame = self.webView.frame;
        CGRect offscreenWebViewFrame = self.offscreenWebView.frame;
        
        [UIView animateWithDuration:0.3f animations:^{
            self.webView.frame = offscreenWebViewFrame;
            self.offscreenWebView.frame = webviewFrame;
        }
         completion:^(BOOL finished) {
             HydroxideWebView* wv = self.webView;
             self.webView = self.offscreenWebView;
             self.offscreenWebView = wv;
         }];
    }
}

- (void)webViewDidStartLoad:(HydroxideWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(HydroxideWebView *)webView
{
    
}

- (void)webView:(HydroxideWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error loading Hydroxide Webview - %@", error);
}

@end
