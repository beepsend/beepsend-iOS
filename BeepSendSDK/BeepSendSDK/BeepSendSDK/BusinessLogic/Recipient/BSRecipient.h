//
//  BSRecipientModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSRecipient : BSGeneralModel

/** Destination address.
 */
@property (nonatomic, strong, readonly) NSString *destinationNumber;

/** Type of number.
 */
@property (nonatomic, strong, readonly) NSNumber *numberType;

/** Number Plan Index.
 */
@property (nonatomic, strong, readonly) NSNumber *numberPlanIndex;

/** Init Recipient with number, type, plan index
 
 @param number - Number
 @param nType - Number type
 @param nPlanIndex - Plan index
 
 @return Returns Recipient object
 */
- (BSRecipient *)initRecipientWithNumber:(NSString *)number numberType:(NSNumber *)nType planIndex:(NSNumber *)nPlanIndex;

@end
