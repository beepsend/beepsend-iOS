//
//  BSCustomerPriceListModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSCustomerPriceListModel.h"

@interface BSCustomerPriceListModel ()

@property (nonatomic, strong, readwrite) NSNumber *priceListType;
@property (nonatomic, strong, readwrite) NSString *priceListDelimiter;

@property (nonatomic, strong, readwrite) BSCustomerPriceListScheduleModel *priceListSchedule;

@property (nonatomic, strong, readwrite) NSArray *priceListFields;

@end

@implementation BSCustomerPriceListModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular pricelist details"]) {
		
	}
	return self;
}

- (BSCustomerPriceListModel *)initPricelistDetailsWithType:(NSNumber *)pType
												 delimiter:(NSString *)pDelimiter
										 pricelistSchedule:(BSCustomerPriceListScheduleModel *)pSchedule
													fields:(NSArray *)pFields
{
	if (self = [super initWithID:@"0" andTitle:[NSString stringWithFormat:@"Price list with type: %@", pType]]) {
		_priceListType = pType;
		_priceListDelimiter = pDelimiter;
		_priceListSchedule = pSchedule;
		_priceListFields = pFields;
	}
	return self;
}

@end
