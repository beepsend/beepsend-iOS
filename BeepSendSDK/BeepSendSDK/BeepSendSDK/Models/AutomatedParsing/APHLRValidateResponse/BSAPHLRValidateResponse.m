//
//  BSAPHLRValidateResponse.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/22/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPHLRValidateResponse.h"

#import "BSHLR.h"

@implementation BSAPHLRValidateResponse

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	//We need to register all classes before load
	BSAPHLRValidateResponse *hlr = [super classFromDict:dictionary];
	return hlr;
}

- (id)convertToModel
{
	return [[BSHLR alloc] initHLRWithNumber:_msisdn andErrors:_errors];
}

@end
