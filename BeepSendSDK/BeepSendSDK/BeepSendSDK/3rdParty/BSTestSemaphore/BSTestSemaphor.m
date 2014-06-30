//
//  TestSemaphor.m
//  BillsApp
//
//  Created by Marin Todorov on 17/01/2012.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "BSTestSemaphor.h"

@implementation BSTestSemaphor

#pragma mark - Initialization

- (id)init
{
	if (self = [super init]) {
		_flags = [NSMutableDictionary dictionaryWithCapacity:10];
	}
	return self;
}

+ (BSTestSemaphor *)sharedInstance
{   
    static BSTestSemaphor *sharedInstance = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        sharedInstance = [[BSTestSemaphor alloc] init];
    });
    
    return sharedInstance;
}

- (void)dealloc
{
    _flags = nil;
}

#pragma mark - Public methods

- (BOOL)isLifted:(NSString *)key
{
    return _flags[key] != nil;
}

- (void)lift:(NSString *)key
{
    [_flags setObject:@"YES" forKey:key];
}

- (void)waitForKey:(NSString *)key
{
    BOOL keepRunning = YES;
    while (keepRunning &&
		   [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
									beforeDate:[NSDate dateWithTimeIntervalSinceNow:1.0]]) {
        keepRunning = ![[BSTestSemaphor sharedInstance] isLifted:key];
    }
}

@end
