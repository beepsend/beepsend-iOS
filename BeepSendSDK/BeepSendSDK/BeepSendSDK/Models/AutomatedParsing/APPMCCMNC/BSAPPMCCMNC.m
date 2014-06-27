//
//  BSAPPMCCMNC.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPPMCCMNC.h"

#import "BSMCCMNCModel.h"

@implementation BSAPPMCCMNC

#pragma mark - Properties

- (NSNumber *)mcc
{
	if ([_mcc isKindOfClass:[NSNumber class]]) {
		return _mcc;
	}
	else if	([_mcc isKindOfClass:[NSString class]]) {
		return [NSNumber numberWithInteger:[(NSString *)_mcc integerValue]];
	}
	else {
		return @0;
	}
}

- (NSNumber *)mnc
{
	if ([_mnc isKindOfClass:[NSNumber class]]) {
		return _mnc;
	}
	else if	([_mnc isKindOfClass:[NSString class]]) {
		return [NSNumber numberWithInteger:[(NSString *)_mnc integerValue]];
	}
	else {
		return @0;
	}
}

#pragma mark - Inherited methods

- (id)convertToModel
{
	return [[BSMCCMNCModel alloc] initWithMNC:self.mnc andMCC:self.mcc];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPPMCCMNC classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

@end
