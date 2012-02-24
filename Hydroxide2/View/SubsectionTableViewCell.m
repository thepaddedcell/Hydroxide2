//
//  SubsectionTableViewCell.m
//  Hydroxide2
//
//  Created by Craig Stanford on 24/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SubsectionTableViewCell.h"
#import "AFImageRequestOperation.h"

@implementation SubsectionTableViewCell

@synthesize subsection=_subsection;
@synthesize titleLabel=_titleLabel;
@synthesize iconImageView=_iconImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier subsection:(Subsection*)subsection
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.subsection = subsection;
        
        self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
        UIImageView* backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"subsection_cell_bg"]];
        [self.backgroundView addSubview:backgroundImageView];
        
        //        self.selectedBackgroundView = [[[UIView alloc] initWithFrame:self.frame] autorelease];
        //        UIImageView* selectedBackgroundImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_selected_bg"]] autorelease];
        //        [self.selectedBackgroundView addSubview:selectedBackgroundImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:(CGRect){62, 0, self.frame.size.width - 62, 50}];
        self.titleLabel.textColor = [UIColor colorWithWhite:1.f alpha:0.8f];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:15.f];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.text = self.subsection.title;
        [self addSubview:self.titleLabel];
        
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
//        AFImageRequestOperation* imageOperation = [AFImageRequestOperation imageRequestOperationWithRequest:subsection.iconURLRequest 
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

@end
