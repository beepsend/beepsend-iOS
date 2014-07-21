//
//  APCPriceListSchedule.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/18/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPCPriceListSchedule.h"

#import "BSPriceListSchedule.h"

@implementation BSAPCPriceListSchedule

#pragma mark - Inherited methods

- (id)convertToModel
{
	return [[BSPriceListSchedule alloc] initPricelistScheduleWithID:_id andName:_name?_name:@""];
}

@end
