//
//  Section.h
//  Hydroxide
//
//  Created by Craig Stanford on 7/02/12.
//  Copyright (c) 2012 Monsterbomb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Section : NSManagedObject

@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * urlString;
@property (nonatomic, retain) NSSet *subsections;
@end

@interface Section (CoreDataGeneratedAccessors)

- (void)addSubsectionsObject:(NSManagedObject *)value;
- (void)removeSubsectionsObject:(NSManagedObject *)value;
- (void)addSubsections:(NSSet *)values;
- (void)removeSubsections:(NSSet *)values;

@end
