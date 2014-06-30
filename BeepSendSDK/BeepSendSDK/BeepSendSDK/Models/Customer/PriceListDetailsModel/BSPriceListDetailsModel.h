//
//  BSCustomerPriceListModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSPriceListScheduleModel.h"

@interface BSPriceListDetailsModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSNumber *type;
@property (nonatomic, strong, readonly) NSString *delimiter;

@property (nonatomic, strong, readonly) BSPriceListScheduleModel *schedule;

@property (nonatomic, strong, readonly) NSArray *fields;

- (BSPriceListDetailsModel *)initPricelistDetailsWithType:(NSNumber *)pType
												delimiter:(NSString *)pDelimiter
										pricelistSchedule:(BSPriceListScheduleModel *)pSchedule
												   fields:(NSArray *)pFields;

@end
