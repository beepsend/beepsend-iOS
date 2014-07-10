//
//  BSCustomerPriceListSchedule.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSPriceListSchedule.h"

@interface BSPriceListSchedule ()

@property (nonatomic, strong, readwrite) NSString *scheduleName;

@end

@implementation BSPriceListSchedule

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular pricelist schedule"]) {
		_pricelistScheduleID = @"-1";
	}
	return self;
}

- (BSPriceListSchedule *)initPricelistScheduleWithID:(NSString *)psID
											 andName:(NSString *)psName
{
	if (self = [super initWithID:psID andTitle:psName]) {
		_pricelistScheduleID = psID;
		_scheduleName = psName;
	}
	return self;
}

@end
