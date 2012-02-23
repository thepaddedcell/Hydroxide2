//
//  DataManager.h
//  Hydroxide
//
//  Created by Craig Stanford on 30/01/12.
//  Copyright (c) 2012 MonsterBomb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

extern NSString* kHydroxideConfigSuccess;
extern NSString* kHydroxideConfigFailure;
extern NSString* kHydroxideAppRequiresUpdate;


@interface DataManager : NSObject

+ (DataManager *)sharedDataManager;

- (void)updateSections;
- (void)getAnnotationsFromURL:(NSURLRequest*)request success:(void(^)(NSArray* annotations, id JSON))success failure:(void(^)(NSError* error))failure;

@end
