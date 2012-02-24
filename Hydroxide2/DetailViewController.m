//
//  DetailViewController.m
//  Hydroxide2
//
//  Created by Craig Stanford on 24/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "UIBarButtonItem+Additions.h"
#import <Twitter/Twitter.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize webView=_webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        self.webView.frame = self.view.bounds;
        self.navigationItem.leftBarButtonItem =
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] target:self.navigationController action:@selector(popViewControllerAnimated:)];
        self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] target:self action:@selector(shareArticle:)];
    }
    return self;
}

- (void)shareArticle:(id)sender
{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"Share Link" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook", @"Twitter", @"Email", nil];
    [actionSheet showInView:self.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Twitter"]) 
    {
        TWTweetComposeViewController* tweetViewController = [[TWTweetComposeViewController alloc] init];
        [tweetViewController setInitialText:[NSString stringWithFormat:@"Just read this awesome article <Short URL Here> (via ninemsn news app)"]];
        [self presentModalViewController:tweetViewController animated:YES];
    }
}

@end
