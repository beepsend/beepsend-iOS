//
//  BSCustomerPriceListSchedule.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSCustomerPriceListScheduleModel.h"

@interface BSCustomerPriceListScheduleModel ()

@property (nonatomic, strong, readwrite) NSString *priceListScheduleName;

@end

@implementation BSCustomerPriceListScheduleModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular pricelist schedule"]) {
		
	}
	return self;
}

- (BSCustomerPriceListScheduleModel *)initPricelistScheduleWithID:(NSString *)psID
														  andName:(NSString *)psName
{
	if (self = [super initWithID:psID andTitle:psName]) {
		_priceListScheduleName = psName;
	}
	return self;
}

@end
