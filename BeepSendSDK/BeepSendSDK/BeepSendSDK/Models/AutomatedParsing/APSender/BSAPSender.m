//
//  BSAPSender.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 9/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPSender.h"

#import "BSSender.h"

@implementation BSAPSender

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	//We need to register all classes before load
	[BSAPContact class];
	
	BSAPSender *sender = [super classFromDict:dictionary];
	
	return sender;
}

- (id)convertToModel
{
	return [[BSSender alloc] initWithNumber:_number andContact:[_contact convertToModel]];
}

@end
