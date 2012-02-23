//
//  Subsection+Additions.h
//  Hydroxide
//
//  Created by Craig Stanford on 8/02/12.
//  Copyright (c) 2012 Monsterbomb. All rights reserved.
//

#import "Subsection.h"

@interface Subsection (Additions)

- (NSURL *)url;
- (NSURLRequest*)urlRequest;
- (void)initWithDictionary:(NSDictionary *)dictionary andRootURLString:(NSString*)rootURLString;

@end
