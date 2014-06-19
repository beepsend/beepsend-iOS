//
//  BSCustomerPriceListSchedule.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSCustomerPriceListScheduleModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *priceListScheduleName;

- (BSCustomerPriceListScheduleModel *)initPricelistScheduleWithID:(NSString *)psID
														  andName:(NSString *)psName;

@end
