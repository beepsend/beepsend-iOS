//
//  BSCustomerPriceListSchedule.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSPriceListSchedule : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *pricelistScheduleID;
@property (nonatomic, strong, readonly) NSString *scheduleName;

- (BSPriceListSchedule *)initPricelistScheduleWithID:(NSString *)psID
											 andName:(NSString *)psName;

@end
