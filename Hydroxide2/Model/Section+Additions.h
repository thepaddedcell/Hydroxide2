//
//  Section+Additions.h
//  Hydroxide
//
//  Created by Craig Stanford on 30/01/12.
//  Copyright (c) 2012 MonsterBomb. All rights reserved.
//

#import "Section.h"

@interface Section (Additions)

- (NSURL*)url;
- (NSURLRequest*)urlRequest;

- (void)initWithDictionary:(NSDictionary *)dictionary andRootURLString:(NSString*)rootURLString;
+ (Section *)createSectionWithDictionary:(NSDictionary *)dictionary andRootURLString:(NSString*)rootURLString;

@end
