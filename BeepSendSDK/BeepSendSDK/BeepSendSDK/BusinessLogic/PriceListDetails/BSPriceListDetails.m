//
//  BSCustomerPriceListModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSPriceListDetails.h"

@interface BSPriceListDetails ()

@property (nonatomic, strong, readwrite) NSNumber *type;
@property (nonatomic, strong, readwrite) NSString *delimiter;

@property (nonatomic, strong, readwrite) BSPriceListSchedule *schedule;

@property (nonatomic, strong, readwrite) NSArray *fields;

@end

@implementation BSPriceListDetails

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular pricelist details"]) {
		
	}
	return self;
}

- (BSPriceListDetails *)initPricelistDetailsWithType:(NSNumber *)pType
										   delimiter:(NSString *)pDelimiter
								   pricelistSchedule:(BSPriceListSchedule *)pSchedule
											  fields:(NSArray *)pFields
{
	if (self = [super initWithID:@"0" andTitle:[NSString stringWithFormat:@"Price list with type: %@", pType]]) {
		_type = pType;
		_delimiter = pDelimiter;
		_schedule = pSchedule;
		_fields = pFields;
	}
	return self;
}

@end
