//
//  BSAPHLR.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPHLR.h"

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

#pragma mark - Public methods

@end
