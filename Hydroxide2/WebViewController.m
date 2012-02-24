//
//  WebViewController.m
//  Hydroxide2
//
//  Created by Craig Stanford on 16/02/12.
//  Copyright (c) 2012 Monsterbomb. All rights reserved.
//

#import "WebViewController.h"
#import "Section+Additions.h"
#import "DataManager.h"
#import "UIBarButtonItem+Additions.h"
#import "DetailViewController.h"

@implementation WebViewController

@synthesize webView=_webView;
@synthesize offscreenWebView=_offscreenWebView;
@synthesize section=_section;
@synthesize subsection=_subsection;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil section:(Section*)section
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        self.section = section;
        self.title = self.section.title;
        //force the webview to load early so we can load a URL from the Parent View Controller
        self.webView.frame = self.view.bounds;
        self.offscreenWebView.frame = self.webView.frame;
        
        
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
    [self.webView loadURL:self.section.url];
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

- (void)transitionToSection:(Section*)section
{
    self.section = section;
    self.subsection = nil;
    self.title = self.section.title;
    [self.offscreenWebView loadURL:self.section.url];
    
    [UIView animateWithDuration:1.f 
                     animations:^{
                         self.webView.alpha = 0.f;
                         self.offscreenWebView.alpha = 1.f;
                     }
                     completion:^(BOOL finished) {
                         HydroxideWebView* wv = self.webView;
                         self.webView = self.offscreenWebView;
                         self.offscreenWebView = wv; 
                         self.webView.userInteractionEnabled = YES;
                         self.offscreenWebView.userInteractionEnabled = YES;
                     }];
}

- (void)transitionToSubsection:(Subsection *)subsection
{
    self.subsection = subsection;
    self.section = nil;
    self.title = self.subsection.title;
    [self.offscreenWebView loadURL:self.subsection.url];
    
    [UIView animateWithDuration:1.f 
                     animations:^{
                         self.webView.alpha = 0.f;
                         self.offscreenWebView.alpha = 1.f;
                     }
                     completion:^(BOOL finished) {
                         HydroxideWebView* wv = self.webView;
                         self.webView = self.offscreenWebView;
                         self.offscreenWebView = wv; 
                         self.webView.userInteractionEnabled = YES;
                         self.offscreenWebView.userInteractionEnabled = YES;
                     }];
}

# pragma mark - Hydroxide Webview Delegate

- (void)webView:(HydroxideWebView *)webView messageFromWeb:(NSDictionary *)info
{
    NSString* message = [info valueForKey:kHydroxideWebMessageInfoKey];
    if ([message isEqualToString:@"detail"]) 
    {
        //push a detail view onto the stack
        DetailViewController* viewController = [[DetailViewController alloc] init];
        NSString* type = [info valueForKey:@"type"];
        viewController.title = [type capitalizedString];
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@&%@", [DataManager sharedDataManager].detailURLString, [info valueForKey:@"query"]]];
        [viewController.webView loadURL:url];
        [self.navigationController pushViewController:viewController animated:YES];
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
