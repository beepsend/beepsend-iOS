//
//  BSCustomerPriceListSchedule.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

/*!
 @class BSPriceListSchedule
 @discussion Pricelist schedule is object that is received when fetching customer from server.
 It tels how often pricelist will be mailed.
 */
@interface BSPriceListSchedule : BSGeneralModel

/*! Pricelist sendout schedule ID.
 */
@property (nonatomic, strong, readonly) NSString *pricelistScheduleID;

/*! Pricelist sendout schedule name. 
	How often new pricelist updates should be mailed out.
 */
@property (nonatomic, strong, readonly) NSString *scheduleName;

/*! Create Pricelist object
 
 @param psID - Pricelist sendout schedule ID
 @param psName - Pricelist sendout schedule name
 
 @return Returns Pricelist schedule object
 */
- (BSPriceListSchedule *)initPricelistScheduleWithID:(NSString *)psID
											 andName:(NSString *)psName;

@end
