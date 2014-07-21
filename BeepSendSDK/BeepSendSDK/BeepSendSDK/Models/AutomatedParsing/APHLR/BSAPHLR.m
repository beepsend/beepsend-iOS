//
//  BSAPHLR.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPHLR.h"

#import "BSHLR.h"

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
	
	return hlr;
}

- (id)convertToModel
{
	return [[BSHLR alloc] initHLRWithID:_id timestamp:[_timestamps convertToModel] dlrReport:[_dlr convertToModel] mccmnc:[_mccmnc convertToModel] imsi:_imsi prefix:[_prefix convertToModel] potred:_ported inRoaming:_roaming];
}

#pragma mark - Public methods

@end
