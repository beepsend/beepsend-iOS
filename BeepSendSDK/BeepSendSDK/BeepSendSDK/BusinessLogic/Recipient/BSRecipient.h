//
//  BSRecipientModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

/*!
 @class BSRecipient
 @discussion Recipient is used when performing SMS lookup.
 */
@interface BSRecipient : BSGeneralModel

/*! Destination address.
 */
@property (nonatomic, strong, readonly) NSString *destinationNumber;

/*! Type of number.
 */
@property (nonatomic, strong, readonly) NSNumber *numberType;

/*! Number Plan Index.
 */
@property (nonatomic, strong, readonly) NSNumber *numberPlanIndex;

/*! Create Recipient object
 
 @param number - Destination address
 @param nType - Type of number
 @param nPlanIndex - Number Plan Index
 
 @return Returns Recipient object
 */
- (BSRecipient *)initRecipientWithNumber:(NSString *)nNumber
							  numberType:(NSNumber *)nType
							   planIndex:(NSNumber *)nPlanIndex;

@end
