//
//  BSCustomerPriceListModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSCustomerPriceListScheduleModel.h"

@interface BSCustomerPriceListModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSNumber *priceListType;
@property (nonatomic, strong, readonly) NSString *priceListDelimiter;

@property (nonatomic, strong, readonly) BSCustomerPriceListScheduleModel *priceListSchedule;

@property (nonatomic, strong, readonly) NSArray *priceListFields;

- (BSCustomerPriceListModel *)initPricelistDetailsWithType:(NSNumber *)pType
												 delimiter:(NSString *)pDelimiter
										 pricelistSchedule:(BSCustomerPriceListScheduleModel *)pSchedule
													fields:(NSArray *)pFields;

@end
