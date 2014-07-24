//
//  BSCustomerPriceListSchedule.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSPriceListSchedule : BSGeneralModel

/** Pricelist sendout schedule ID.
 */
@property (nonatomic, strong, readonly) NSString *pricelistScheduleID;

/** Pricelist sendout schedule name. 
	How often new pricelist updates should be mailed out.
 */
@property (nonatomic, strong, readonly) NSString *scheduleName;

/** Init Pricelist schedule with ID, name
 
 @param psID - Pricelist schedule ID
 @param psName - Name
 
 @return Returns Pricelist schedule object
 */
- (BSPriceListSchedule *)initPricelistScheduleWithID:(NSString *)psID
											 andName:(NSString *)psName;

@end
