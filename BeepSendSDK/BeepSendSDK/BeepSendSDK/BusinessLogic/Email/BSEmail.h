//
//  BSEmailModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

/*!
 @class BSEmail
 @discussion By default, all pricelist and wallet notifications will be sent to the email registered to your user.
 If you wish to have updates sent to more emails you can add external recipients.
 */
@interface BSEmail : BSGeneralModel

/*! Email id.
 */
@property (nonatomic, strong, readonly) NSString *emailID;

/*! Email address.
 */
@property (nonatomic, strong, readonly) NSString *address;

/*! Create Email object
 Used for initializing email with object received from server
 
 @param eID - Email id
 @param address - Email address
 
 @return Returns Email object
 */
- (BSEmail *)initEmailWithID:(NSString *)eID
				   atAddress:(NSString *)address;

/*! Create Email object
 Create new email object to add to wallet list
 
 @param address - Email address
 
 @return Returns Email object
 */
- (BSEmail *)initEmailWithAddress:(NSString *)address;

@end
