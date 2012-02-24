//
//  SectionTableViewCell.m
//  TheBlock
//
//  Created by Craig Stanford on 17/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SectionTableViewCell.h"
#import "AFImageRequestOperation.h"

@implementation SectionTableViewCell

@synthesize titleLabel=_titleLabel;
@synthesize iconImageView=_iconImageView;
@synthesize section=_section;

- (id)initWithSection:(Section*)section reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super init];
    if (self) 
    {
        self.section = section;
        self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
        UIImageView* backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg"]];
        [self.backgroundView addSubview:backgroundImageView];
        
        //        self.selectedBackgroundView = [[[UIView alloc] initWithFrame:self.frame] autorelease];
        //        UIImageView* selectedBackgroundImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_selected_bg"]] autorelease];
        //        [self.selectedBackgroundView addSubview:selectedBackgroundImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:(CGRect){55, 0, self.frame.size.width - 55, 50}];
        self.titleLabel.textColor = [UIColor colorWithWhite:1.f alpha:0.8f];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17.f];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.text = self.section.title;
        [self addSubview:self.titleLabel];
        
        if([self.section.subsections count])
            self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_down"]];
        else
            self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:(CGRect){0, 0, 45, 40}];
        self.iconImageView.contentMode = UIViewContentModeCenter;
        self.iconImageView.alpha = 0.f;
        [self addSubview:self.iconImageView];
        
//        UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        spinner.center = self.iconImageView.center;
//        [spinner startAnimating];
//        [self addSubview:spinner];
//        
//        AFImageRequestOperation* imageOperation = [AFImageRequestOperation imageRequestOperationWithRequest:section.iconURLRequest 
//                                                                                                    success:^(UIImage *image) {
//                                                                                                        self.iconImageView.image = image;
//                                                                                                        [UIView animateWithDuration:0.3f 
//                                                                                                                         animations:^{
//                                                                                                                             self.iconImageView.alpha = 1.f;
//                                                                                                                             spinner.alpha = 0.f;
//                                                                                                                         }
//                                                                                                                         completion:^(BOOL finished) {
//                                                                                                                             [spinner removeFromSuperview];
//                                                                                                                         }];
//                                                                                                    }];
//        NSOperationQueue* imageQueue = [NSOperationQueue mainQueue];
//        [imageQueue addOperation:imageOperation];
    }
    return self;
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//    if ([self.section.subsections count]) 
//    {
//        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_down"]];
//    }
//}

@end
