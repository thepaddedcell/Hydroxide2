//
//  Subsection+Additions.m
//  Hydroxide
//
//  Created by Craig Stanford on 8/02/12.
//  Copyright (c) 2012 Monsterbomb. All rights reserved.
//

#import "Subsection+Additions.h"

@implementation Subsection (Additions)

- (void)initWithDictionary:(NSDictionary *)dictionary andRootURLString:(NSString*)rootURLString
{
    self.title = [dictionary valueForKey:@"title"];
    self.subtitle = [dictionary valueForKey:@"subtitle"];
    self.urlString = [NSString stringWithFormat:@"%@%@", rootURLString, [dictionary valueForKey:@"page"]];
    self.position = [NSNumber numberWithInt:[[dictionary valueForKey:@"position"] intValue]];
}

- (NSURL *)url
{
    return [NSURL URLWithString:[self urlString]];
}

- (NSURLRequest*)urlRequest
{
    return [NSURLRequest requestWithURL:[self url]];
}

@end
