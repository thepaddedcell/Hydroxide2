//
//  SubsectionTableViewCell.h
//  Hydroxide2
//
//  Created by Craig Stanford on 24/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subsection+Additions.h"

@interface SubsectionTableViewCell : UITableViewCell

@property (nonatomic, strong) Subsection* subsection;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIImageView* iconImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier subsection:(Subsection*)subsection;


@end
