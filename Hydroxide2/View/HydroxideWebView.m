//
//  HyroxideWebView.m
//  Hydroxide
//
//  Created by Craig Stanford on 3/02/12.
//  Copyright (c) 2012 MonsterBomb. All rights reserved.
//

#import "HydroxideWebView.h"

@interface HydroxideWebView ()

@property (nonatomic, strong) UIWebView* webView;

- (NSDictionary *)_stripMessage:(NSURL *)url;

@end

@implementation HydroxideWebView

@synthesize webView=_webView;
@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.webView = [[UIWebView alloc] initWithFrame:(CGRect){0, 0, self.frame.size.width, self.frame.size.height}];
        self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.webView.delegate = self;
        [self addSubview:self.webView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{    
    self = [super initWithCoder:aDecoder];
    if (self) 
    {
        self.webView = [[UIWebView alloc] initWithFrame:(CGRect){0, 0, self.frame.size.width, self.frame.size.height}];
        self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.webView.delegate = self;
        [self addSubview:self.webView];
    }

    return self;
}

- (void)loadURLString:(NSString*)urlString
{
    [self loadURL:[NSURL URLWithString:urlString]];
}

- (void)loadURL:(NSURL *)url
{
    [self loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)loadRequest:(NSURLRequest *)urlRequest
{
    [self.webView loadRequest:urlRequest];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(webViewDidStartLoad:)])
        [self.delegate webViewDidStartLoad:self];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)])
        [self.delegate webViewDidFinishLoad:self];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)])
        [self.delegate webView:self didFailLoadWithError:error];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL shouldLoad = YES;
    // This is where we hijack web requests to decide what to do with them
    switch (navigationType) 
    {
        case UIWebViewNavigationTypeLinkClicked:
        case UIWebViewNavigationTypeOther:
        {    
            // LinkClicked: When an <a href> tag is clicked
            // Other: When you generate a load URL Request or change an Anchor tag
            NSDictionary* info = [self _stripMessage:request.URL];
            if (info) 
            {
                // This is a message directed at us
                if (self.delegate && [self.delegate respondsToSelector:@selector(webView:messageFromWeb:)])
                    [self.delegate webView:self messageFromWeb:info];
                shouldLoad = NO;
            }
            break;
        }   
        case UIWebViewNavigationTypeReload:
            // When you call reload - These are generally not used
            NSLog(@"Reload");
            break;
            
        case UIWebViewNavigationTypeBackForward:
            // Override here to prevent Javascript events forcing the Webview Back/Forward
            NSLog(@"Back Forward");
            break;
            
        case UIWebViewNavigationTypeFormSubmitted:
        case UIWebViewNavigationTypeFormResubmitted:
            // When a user submits an HTML Form
            NSLog(@"Form submission");
            break;
            
        default:
            break;
    }
    return shouldLoad; 
}

- (NSDictionary *)_stripMessage:(NSURL *)url
{
    NSMutableDictionary* info = nil;
    if ([url.scheme isEqualToString:@"native"]) 
    {
        info = [NSMutableDictionary dictionaryWithObject:[url host] forKey:kHydroxideWebMessageInfoKey];
        if ([url query])            
        {
            [info setObject:[url query] forKey:@"query"];
            NSArray* args = [[url query] componentsSeparatedByString:@"&"];
            for (NSString* arg in args) 
            {
                NSArray* argParts = [arg componentsSeparatedByString:@"="];
                [info setObject:[argParts objectAtIndex:1] forKey:[argParts objectAtIndex:0]];
            }
        }
    }
    return info ? [NSDictionary dictionaryWithDictionary:info] : nil;
}

@end
