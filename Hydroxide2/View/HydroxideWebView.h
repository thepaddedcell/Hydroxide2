//
//  HyroxideWebView.h
//  Hydroxide
//
//  Created by Craig Stanford on 3/02/12.
//  Copyright (c) 2012 MonsterBomb. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kHydroxideWebMessageInfoKey @"message"

@protocol HydroxideWebViewDelegate;

@interface HydroxideWebView : UIView <UIWebViewDelegate>

@property (assign) IBOutlet id <HydroxideWebViewDelegate> delegate;

- (void)loadURLString:(NSString*)urlString;
- (void)loadURL:(NSURL *)url;
- (void)loadRequest:(NSURLRequest *)urlRequest;

@end

@protocol HydroxideWebViewDelegate <NSObject>

@optional
- (void)webViewDidStartLoad:(HydroxideWebView *)webView;
- (void)webViewDidFinishLoad:(HydroxideWebView *)webView;
- (void)webView:(HydroxideWebView *)webView didFailLoadWithError:(NSError *)error;
- (void)webView:(HydroxideWebView *)webView messageFromWeb:(NSDictionary*)info;
@end