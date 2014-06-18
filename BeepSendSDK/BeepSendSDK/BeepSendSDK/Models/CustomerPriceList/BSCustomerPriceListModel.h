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

@property (nonatomic, strong) NSNumber *priceListType;
@property (nonatomic, strong) NSString *priceListDelimiter;

@property (nonatomic, strong) BSCustomerPriceListScheduleModel *priceListSchedule;

@property (nonatomic, strong) NSArray *priceListFields;

@end
