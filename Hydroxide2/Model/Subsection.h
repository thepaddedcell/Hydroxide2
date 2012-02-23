//
//  Subsection.h
//  Hydroxide
//
//  Created by Craig Stanford on 8/02/12.
//  Copyright (c) 2012 Monsterbomb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Section;

@interface Subsection : NSManagedObject

@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * urlString;
@property (nonatomic, retain) Section *section;

@end
