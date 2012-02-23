//
//  ViewController.m
//  Hydroxide2
//
//  Created by Craig Stanford on 16/02/12.
//  Copyright (c) 2012 Monsterbomb. All rights reserved.
//

#import "MainViewController.h"
#import "Section+Additions.h"
#import "DataManager.h"

@implementation MainViewController

@synthesize webViewController=_webViewController;
@synthesize navController=_navController;
@synthesize tableView=_tableView;
@synthesize sections=_sections;
@synthesize currentSectionId=_currentSectionId;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(configUpdate) 
                                                 name:kHydroxideConfigSuccess 
                                               object:nil];
    
    
    self.currentSectionId = 0;
    self.sections = [Section findAllSortedBy:@"position" ascending:YES];
    Section* section;
    if ([self.sections count])
        section = [self.sections objectAtIndex:self.currentSectionId];
    
    self.tableView = [[UITableView alloc] initWithFrame:(CGRect){self.view.bounds.origin.x, self.view.bounds.origin.y, 150, self.view.bounds.size.height} style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor orangeColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" 
                                                                 bundle:[NSBundle mainBundle] 
                                                               sections:self.sections];
    self.webViewController.navigationItem.leftBarButtonItem = 
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks 
                                                  target:self 
                                                  action:@selector(showHideTableView)];
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.webViewController];
    self.navController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self addChildViewController:self.navController];
    [self.view addSubview:self.navController.view];

    [self.webViewController.webView loadURL:section.url];
}

- (void)configUpdate
{
    self.sections = [Section findAllSortedBy:@"position" ascending:YES];
    self.webViewController.sections = self.sections;
    [self.tableView reloadData];
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
    return YES;
}

#pragma mark - TableView DataSource / Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sections count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    Section* section = nil;
    NSString* cellIdentifier = @"kHydroxideSectionCell";
    
    
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    section = [self.sections objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    cell.textLabel.text = section.title;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Section* section = [self.sections objectAtIndex:indexPath.row];
    [self.webViewController.webView loadURL:section.url];
    [self showHideTableView];
}

#pragma mark - NavigationController Delegate



#pragma mark - Animation Methods

- (void)showHideTableView
{
    CGRect frame = self.navController.view.frame;
    frame.origin.x = abs(frame.origin.x - self.tableView.frame.size.width);
    [UIView animateWithDuration:0.3f animations:^{
        self.navController.view.frame = frame;
    }];
}

@end
