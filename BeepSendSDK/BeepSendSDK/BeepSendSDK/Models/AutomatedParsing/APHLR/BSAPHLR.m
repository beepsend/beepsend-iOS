//
//  BSAPHLR.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPHLR.h"

#import "BSHLR.h"
#import "BSAPError.h"

@implementation BSAPHLR

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	//We need to register all classes before load
	[BSAPTimestamps class];
	[BSAPHLRReport class];
	[BSAPDLRReport class];
	[BSAPPMCCMNC class];
	
	BSAPHLR *hlr = [super classFromDict:dictionary];
	hlr.errors = [BSAPError arrayOfObjectsFromArrayOfDictionaries:hlr.errors];
	
	return hlr;
}

- (id)convertToModel
{
	if (_msisdn==nil) {
		return [[BSHLR alloc] initHLRWithID:_id timestamp:[_timestamps convertToModel] dlrReport:[_dlr convertToModel] mccmnc:[_mccmnc convertToModel] imsi:_imsi prefix:[_prefix convertToModel] potred:_ported inRoaming:_roaming withErrors:[BSAPError arrayOfModelsFromArrayOfObjects:_errors]];
	}
	else {
		return [[BSHLR alloc] initHLRWithNumber:_msisdn andErrors:[BSAPError arrayOfModelsFromArrayOfObjects:_errors]];
	}
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPHLR classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

@end
