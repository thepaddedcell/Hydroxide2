//
//  SectionTableViewCell.h
//  TheBlock
//
//  Created by Craig Stanford on 17/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Section+Additions.h"

@interface SectionTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIImageView* iconImageView;
@property (nonatomic, strong) Section* section;

- (id)initWithSection:(Section*)section reuseIdentifier:(NSString *)reuseIdentifier;

@end
