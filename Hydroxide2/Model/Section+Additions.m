//
//  Section+Additions.m
//  Hydroxide
//
//  Created by Craig Stanford on 30/01/12.
//  Copyright (c) 2012 MonsterBomb. All rights reserved.
//

#import "Section+Additions.h"
#import "Subsection+Additions.h"

@implementation Section (Additions)

- (NSURL *)url
{
    return [NSURL URLWithString:[self urlString]];
}

- (NSURLRequest*)urlRequest
{
    return [NSURLRequest requestWithURL:[self url]];
}

- (void)initWithDictionary:(NSDictionary *)dictionary
{
    self.title = [dictionary valueForKey:@"title"];
    self.subtitle = [dictionary valueForKey:@"subtitle"];
    self.urlString = [dictionary valueForKey:@"page"];
    self.position = [NSNumber numberWithInt:[[dictionary valueForKey:@"position"] intValue]];
    
    for (NSDictionary* subSectionDict in [dictionary valueForKey:@"subsections"]) 
    {
        Subsection* subSection = [Subsection createEntity];
        [subSection initWithDictionary:subSectionDict];
        subSection.section = self;
    }
}

+ (Section *)createSectionWithDictionary:(NSDictionary *)dictionary
{
    // Create the new section
    Section* section = [Section createEntity];
    
    //Now populate it with the data
    [section initWithDictionary:dictionary];
    
    return section;
}

@end
