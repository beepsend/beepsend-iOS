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

/** 1 for json, 2 for csv.
 */
@property (nonatomic, strong, readonly) NSNumber *type;

/** Delimiter that is being used if pricelist_type is csv.
	If pricelist_type is json this will be null.
 */
@property (nonatomic, strong, readonly) NSString *delimiter;

/** Pricelist sendout schedule.
 */
@property (nonatomic, strong, readonly) BSPriceListSchedule *schedule;

/** Pricelist fields to be included.
 */
@property (nonatomic, strong, readonly) NSArray *fields;

/** Init Pricelist details with type, delimiter, schedule, fields
 
 @param pType - Type
 @param pDelimiter - Delimiter
 @param pSchedule - Schedule
 @param pFields - Fields
 
 @return Returns Pricelist details object
 */
- (BSPriceListDetails *)initPricelistDetailsWithType:(NSNumber *)pType
										   delimiter:(NSString *)pDelimiter
								   pricelistSchedule:(BSPriceListSchedule *)pSchedule
											  fields:(NSArray *)pFields;

@end
