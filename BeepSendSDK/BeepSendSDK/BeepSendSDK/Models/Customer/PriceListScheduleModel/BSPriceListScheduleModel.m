//
//  BSCustomerPriceListSchedule.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSPriceListScheduleModel.h"

@interface BSPriceListScheduleModel ()

@property (nonatomic, strong, readwrite) NSString *scheduleName;

@end

@implementation BSPriceListScheduleModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular pricelist schedule"]) {
		
	}
	return self;
}

- (BSPriceListScheduleModel *)initPricelistScheduleWithID:(NSString *)psID
												  andName:(NSString *)psName
{
	if (self = [super initWithID:psID andTitle:psName]) {
		_scheduleName = psName;
	}
	return self;
}

@end
