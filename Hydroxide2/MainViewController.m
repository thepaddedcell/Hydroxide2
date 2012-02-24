//
//  ViewController.m
//  Hydroxide2
//
//  Created by Craig Stanford on 16/02/12.
//  Copyright (c) 2012 Monsterbomb. All rights reserved.
//

#import "MainViewController.h"
#import "Section+Additions.h"
#import "Subsection+Additions.h"
#import "DataManager.h"
#import "UIBarButtonItem+Additions.h"

@implementation MainViewController

@synthesize webViewController=_webViewController;
@synthesize navController=_navController;
@synthesize tableView=_tableView;
@synthesize sections=_sections;
@synthesize currentSectionId=_currentSectionId;
@synthesize panGestureRecogniser=_panGestureRecogniser;
@synthesize tapGestureRecogniser=_tapGestureRecogniser;
@synthesize gestureCatcher=_gestureCatcher;

@synthesize expandedSectionIndex=_expandedSectionIndex;
@synthesize subsections=_subsections;

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
    self.expandedSectionIndex = -1;
    self.sections = [Section findAllSortedBy:@"position" ascending:YES];
    Section* section;
    if ([self.sections count])
        section = [self.sections objectAtIndex:self.currentSectionId];
    
    self.tableView = [[UITableView alloc] initWithFrame:(CGRect){self.view.bounds.origin.x, self.view.bounds.origin.y, 150, self.view.bounds.size.height} style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.1f alpha:1.f];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor colorWithWhite:0.3f alpha:1.f];
    [self.view addSubview:self.tableView];
    
    self.webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" 
                                                                 bundle:[NSBundle mainBundle] 
                                                               section:section];
    self.webViewController.navigationItem.leftBarButtonItem = 
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] 
                                    target:self 
                                    action:@selector(showHideTableView)];
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.webViewController];
    [self.navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header"] forBarMetrics:UIBarMetricsDefault];
    self.navController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self addChildViewController:self.navController];
    [self.view addSubview:self.navController.view];

    [self.webViewController.webView loadURL:section.url];
    NSLog(@"Section URL: %@", section.urlString);
}

- (void)configUpdate
{
    self.sections = [Section findAllSortedBy:@"position" ascending:YES];
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
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - TableView DataSource / Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.expandedSectionIndex >= 0) 
    {
        Section* navSection = [self.sections objectAtIndex:self.expandedSectionIndex];
        return [self.sections count] + [navSection.subsections count];
    }
    else
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
    
    cell.backgroundView = [[UIView alloc] initWithFrame:cell.frame];
    
    NSInteger index = indexPath.row;
    NSLog(@"Index Row: %d", index);
    NSLog(@"Expanded: %d", self.expandedSectionIndex);
    NSLog(@"Range: %d", self.expandedSectionIndex + [self.subsections count]);
    
    if (self.expandedSectionIndex >= 0 && 
        indexPath.row > self.expandedSectionIndex && 
        indexPath.row <= self.expandedSectionIndex + [self.subsections count]) 
    {
        Subsection* subsection = [self.subsections objectAtIndex:indexPath.row - self.expandedSectionIndex - 1];
        cell.textLabel.text = subsection.title;
        cell.backgroundView.backgroundColor = [UIColor orangeColor];
    }
    else
    {
        section = [self.sections objectAtIndex:indexPath.row]; 
        if (self.expandedSectionIndex >= 0 && 
            index > self.expandedSectionIndex + [self.subsections count])
            index = index - self.expandedSectionIndex + [self.subsections count];
        section = [self.sections objectAtIndex:index];
        cell.textLabel.text = section.title;
        cell.backgroundView = nil;
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:1.f alpha:0.1f];     
    }
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    if (self.expandedSectionIndex >= 0 && 
        index > self.expandedSectionIndex &&
        index <= self.expandedSectionIndex + [self.subsections count])
    {
        Subsection* subsection = [self.subsections objectAtIndex:index - self.expandedSectionIndex - 1];
        [self.webViewController transitionToSubsection:subsection];
        [self showHideTableView];
    }
    else 
    {
        if (self.expandedSectionIndex >= 0 &&
            index > self.expandedSectionIndex) 
            index = index - [self.subsections count];
        
        Section* section = [self.sections objectAtIndex:index];
        if ([section.subsections count]) 
        {
            if (self.expandedSectionIndex >= 0 && index != self.expandedSectionIndex) 
            {
                Section* expandedSection = [self.sections objectAtIndex:self.expandedSectionIndex];
//                [self showHideSubsectionsInSection:expandedSection forRow:self.expandedSectionIndex]; 
                Section* newExpandedSection = [self.sections objectAtIndex:index];
                [self showSubsectionsInSection:newExpandedSection forRow:index hidingSubsectionsInSection:expandedSection forRow:self.expandedSectionIndex];
            }
            else 
            {
                [self showHideSubsectionsInSection:section forRow:indexPath.row];
            }
            
        }
        else 
        {
            if (self.expandedSectionIndex >= 0) 
            {
                Section* expandedSection = [self.sections objectAtIndex:self.expandedSectionIndex];
                [self showHideSubsectionsInSection:expandedSection forRow:self.expandedSectionIndex];            
            }
            
            [self.webViewController transitionToSection:section];
            [self showHideTableView];

        }
    }
}

- (void)showSubsectionsInSection:(Section*)showSection forRow:(NSInteger)showRow hidingSubsectionsInSection:(Section*)hideSection forRow:(NSInteger)hideRow
{
    NSArray* currentSubsections = self.subsections;
    NSArray* newSubsections = [showSection.subsections sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"position" ascending:YES]]];
    
    NSMutableArray* newRows = [NSMutableArray arrayWithCapacity:[newSubsections count]];
    for (int i = 0; i < [newSubsections count]; i++) 
        [newRows addObject:[NSIndexPath indexPathForRow:showRow + i + 1 inSection:0]];
    
    NSMutableArray* currentRows = [NSMutableArray arrayWithCapacity:[currentSubsections count]];
    for (int i = 0; i < [currentSubsections count]; i++) 
        [currentRows addObject:[NSIndexPath indexPathForRow:hideRow + i + 1 inSection:0]];

    self.expandedSectionIndex = showRow;
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:currentRows withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView insertRowsAtIndexPaths:newRows withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    
    self.subsections = newSubsections;
}

- (void)showHideSubsectionsInSection:(Section*)section forRow:(NSInteger)row
{
    if(!self.subsections)
        self.subsections = [section.subsections sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"position" ascending:YES]]];
    
    NSMutableArray* mutableArray = [NSMutableArray arrayWithCapacity:[self.subsections count]];
    for (int i = 0; i < [self.subsections count]; i++) 
        [mutableArray addObject:[NSIndexPath indexPathForRow:row + i + 1 inSection:0]];
    
    NSLog(@"Rows... %@", mutableArray);
    
    if (self.expandedSectionIndex < 0) 
    {
        self.expandedSectionIndex = row;
        NSLog(@"INSERTING");
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithArray:mutableArray]
                              withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
    }
    else 
    {
        self.subsections = nil;
        self.expandedSectionIndex = -1;
        NSLog(@"DELETING");
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithArray:mutableArray] 
                              withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
    }
}

#pragma mark - NavigationController Delegate


#pragma mark - Gesture Recogniser Delegates

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)tapView:(UITapGestureRecognizer*)sender
{
    CGRect frame = self.navController.view.frame;
    frame.origin.x = 0;
    
    [UIView animateWithDuration:0.3f 
                     animations:^{
                         self.navController.view.frame = frame;
                         self.gestureCatcher.frame = frame;
                         self.gestureCatcher.alpha = 0.f;
                     } 
                     completion:^(BOOL finished) {
                         [self removeGestureCatcherView];
                     }];
}

-(void)moveView:(UIPanGestureRecognizer *)sender 
{
    static CGFloat firstX = 0;
    CGPoint translatedPoint = [sender translationInView:self.view];
    
    if(sender.state == UIGestureRecognizerStateBegan) 
    {
        firstX = sender.view.frame.origin.x;
    }
    else if(sender.state == UIGestureRecognizerStateEnded)
    {
        CGRect frame = self.navController.view.frame;
        if (firstX + translatedPoint.x < self.tableView.frame.size.width / 2) 
        {
            frame.origin.x = 0;
        }
        else
        {
            frame.origin.x = self.tableView.frame.size.width;
        }
        
        [UIView animateWithDuration:0.3f 
                         animations:^{
                             self.navController.view.frame = frame;
                             self.gestureCatcher.frame = frame;
                             if (frame.origin.x == 0) 
                                 self.gestureCatcher.alpha = 0.f;
                             else
                                 self.gestureCatcher.alpha = 1.f;
                         }
                         completion:^(BOOL finished) {
                             if (frame.origin.x == 0) 
                             {
                                 [self removeGestureCatcherView];
                             }
                         }];
    }
    else if(sender.state == UIGestureRecognizerStateChanged)
    {
        if (translatedPoint.x < 0 && firstX + translatedPoint.x >= 0)
        {
            CGRect frame = self.navController.view.frame;
            frame.origin.x = firstX + translatedPoint.x;
            self.navController.view.frame = frame;
            self.gestureCatcher.frame = frame;
            self.gestureCatcher.alpha = 1 - (fabsf(translatedPoint.x) / firstX);
        }
    }
}

- (void)removeGestureCatcherView
{
    self.webViewController.webView.userInteractionEnabled = YES;
    [self.gestureCatcher removeFromSuperview];
    self.gestureCatcher = nil;
}

#pragma mark - Animation Methods

- (void)showHideTableView
{
    CGRect frame = self.navController.view.frame;
    
    if(frame.origin.x == 0)
    {
        self.webViewController.webView.userInteractionEnabled = NO;
        
        self.gestureCatcher = [[UIView alloc] initWithFrame:self.navController.view.frame];
        self.gestureCatcher.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.5f];
        self.gestureCatcher.alpha = 0.0f;
        
        self.panGestureRecogniser = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveView:)];
        [self.panGestureRecogniser setMinimumNumberOfTouches:1];
        [self.panGestureRecogniser setMaximumNumberOfTouches:1];
        self.panGestureRecogniser.delegate = self;
        [self.gestureCatcher addGestureRecognizer:self.panGestureRecogniser];
        
        self.tapGestureRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [self.tapGestureRecogniser setNumberOfTouchesRequired:1];
        [self.gestureCatcher addGestureRecognizer:self.tapGestureRecogniser];
        
        [self.view addSubview:self.gestureCatcher];
    }
    
    frame.origin.x = abs(frame.origin.x - self.tableView.frame.size.width);
    
    [UIView animateWithDuration:0.3f animations:^{
        self.navController.view.frame = frame;
        self.gestureCatcher.frame = frame;
        self.gestureCatcher.alpha = fabs(self.gestureCatcher.alpha - 1.0f);
    }];
}

@end
