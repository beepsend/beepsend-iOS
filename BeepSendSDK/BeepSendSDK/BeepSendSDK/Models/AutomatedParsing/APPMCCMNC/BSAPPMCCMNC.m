//
//  BSAPPMCCMNC.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPPMCCMNC.h"

@implementation BSAPPMCCMNC

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	BSAPPMCCMNC	*mccmnc = [super classFromDict:dictionary];
	
	return mccmnc;
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
