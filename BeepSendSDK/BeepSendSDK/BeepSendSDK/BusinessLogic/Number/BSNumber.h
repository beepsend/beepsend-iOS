//
//  BSNumber.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 9/1/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSConnection;
@class BSCountry;

/*!
 @class BSNumber
 @discussion As a user you will have associated connections. These connections
 have access to recipient numbers, which can receive mobile originated messages. 
 The recipient numbers are registered in specific countries, which this endpoint 
 will also list.
 */
@interface BSNumber : BSGeneralModel

/*! Connection object.
 */
@property (nonatomic, strong, readonly) BSConnection *connection;

/*! Country object.
 */
@property (nonatomic, strong, readonly) BSCountry *country;

/*! Recipient number id.
 */
@property (nonatomic, strong, readonly) NSString *numberID;

/*! Recipient number.
 */
@property (nonatomic, strong, readonly) NSNumber *recipientNumber;

/*! Create Number object
 
 @param nID - Recipient number id
 @param nCountry - Country object
 @param nConnection - Connection object
 @param nNumber - Recipient number
 
 @return Returns Number object
 */
- (BSNumber *)initWithID:(NSString *)nID
				 country:(BSCountry *)nCountry
			  connection:(BSConnection *)nConnection
	  andRecipientNumber:(NSNumber *)nNumber;

@end
