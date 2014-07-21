//
//  BSCustomerPriceListModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSPriceListSchedule.h"

@interface BSPriceListDetails : BSGeneralModel

@property (nonatomic, strong, readonly) NSNumber *type;
@property (nonatomic, strong, readonly) NSString *delimiter;

@property (nonatomic, strong, readonly) BSPriceListSchedule *schedule;

@property (nonatomic, strong, readonly) NSArray *fields;

- (BSPriceListDetails *)initPricelistDetailsWithType:(NSNumber *)pType
										   delimiter:(NSString *)pDelimiter
								   pricelistSchedule:(BSPriceListSchedule *)pSchedule
											  fields:(NSArray *)pFields;

@end
