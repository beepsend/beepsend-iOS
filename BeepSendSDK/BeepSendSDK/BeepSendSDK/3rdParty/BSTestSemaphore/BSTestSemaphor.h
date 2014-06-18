//
//  TestSemaphor.h
//  BillsApp
//
//  Created by Marin Todorov on 17/01/2012.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSTestSemaphor : NSObject

@property (atomic, strong) NSMutableDictionary *flags;

+ (BSTestSemaphor *)sharedInstance;

- (BOOL)isLifted:(NSString *)key;
- (void)lift:(NSString *)key;
- (void)waitForKey:(NSString *)key;

@end
