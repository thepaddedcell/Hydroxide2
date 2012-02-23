//
//  UIBarButtonItem+Additions.m
//  Hydroxide2
//
//  Created by Craig Stanford on 23/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIBarButtonItem+Additions.h"

@implementation UIBarButtonItem (Additions)

- (id)initWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [sendButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [sendButton setImage:image forState:UIControlStateNormal];
    self = [self initWithCustomView:sendButton];
    
    return self;
}

@end
