//
//  BSTwoWayBatch.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 9/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSTwoWayBatch : BSGeneralModel

/*! Unique Beepsend generated ID.
 */
@property (nonatomic, strong, readonly) NSString *mtSmsID;

/*! UTF-8 encoded message body of the mobile terminated message.
 */
@property (nonatomic, strong, readonly) NSString *mtBody;

/*! Unique Beepsend generated ID.
 */
@property (nonatomic, strong, readonly) NSString *moSmsID;

/*! UTF-8 encoded message body of the mobile originated message.
 */
@property (nonatomic, strong, readonly) NSString *moBody;

/*! Response status.
 */
@property (nonatomic, strong, readonly) NSString *deliveryStatus;

/*! Create TwoWayBatch object

@param tMtSmsID - Unique Beepsend generated ID.
@param tMtBody - UTF-8 encoded message body of the mobile terminated message.
@param tMoSmsID - Unique Beepsend generated ID.
@param tMoBody - UTF-8 encoded message body of the mobile originated message.
@param tDeliveryStatus - Response status.
 
@return Returns TwoWayBatch object
*/
- (BSTwoWayBatch *)initWithMtSmsID:(NSString *)tMtSmsID
							mtBody:(NSString *)tMtBody
						   moSmsID:(NSString *)tMoSmsID
							moBody:(NSString *)tMoBody
					deliveryStatus:(NSString *)tDeliveryStatus;

@end
