//
//  Subsection+Additions.m
//  Hydroxide
//
//  Created by Craig Stanford on 8/02/12.
//  Copyright (c) 2012 Monsterbomb. All rights reserved.
//

#import "Subsection+Additions.h"

@implementation Subsection (Additions)

- (void)initWithDictionary:(NSDictionary *)dictionary
{
    self.title = [dictionary valueForKey:@"title"];
    self.subtitle = [dictionary valueForKey:@"subtitle"];
    self.urlString = [dictionary valueForKey:@"page"];
    self.position = [NSNumber numberWithInt:[[dictionary valueForKey:@"position"] intValue]];
}

@end
