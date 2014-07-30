//
//  BSLookupModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSDLRReport.h"
#import "BSRecipient.h"
#import "BSMCCMNC.h"
#import "BSTimestamps.h"
#import "BSBatch.h"

@class BSConnection;

/*!
 @class BSLookup
 @discussion Lookup contains data for existing message in system.
 */
@interface BSLookup : BSGeneralModel

/*! Unique Beepsend generated ID.
 */
@property (nonatomic, strong, readonly) NSString *lookupID;

/*! id and label or null if message was sent with no batch specified.
 */
@property (nonatomic, strong, readonly) BSBatch *batch;

/*! The message body of sent SMS.
 */
@property (nonatomic, strong, readonly) NSString *messageBody;

/*! Connection details.
 */
@property (nonatomic, strong, readonly) BSConnection *usedConnection;

/*! 0 for Gsm7 encoded messages. 8 for UCS-2 encoded messages and 4 for binary messages.
 */
@property (nonatomic, strong, readonly) NSNumber *dataCoding;

/*! One of the following: DELIVRD, EXPIRED, REJECTD, UNKNOWN, UNDELIV, FAILED. 
	Or null if message has not yet been delivered.
 */
@property (nonatomic, strong, readonly) BSDLRReport *deliveryReport;

/*! Source.
 */
@property (nonatomic, strong, readonly) BSRecipient *sender;

/*! Destination mcc mnc.
 */
@property (nonatomic, strong, readonly) BSMCCMNC *mccmnc;

/*! Message price.
 */
@property (nonatomic, strong, readonly) NSNumber *price;

/*! When the message reached Beepsend in Unix time.
 */
@property (nonatomic, strong, readonly) BSTimestamps *timestamps;

/*! Destination.
 */
@property (nonatomic, strong, readonly) BSRecipient *recipient;

/*! Until what date and time the message is considered valid for routing. 
	Formatted like YYMMDDhhmmsstnnp according to the SMPP standard.
 */
@property (nonatomic, strong, readonly) NSDate *validTo;

/*! Create Lookup object
 
 @param lID - Lookup ID
 @param lBatch - id and label or null if message was sent with no batch specified
 @param lMessage - The message body of sent SMS
 @param lConnection - Connection details
 @param lDataCoding - 0 for Gsm7 encoded messages. 8 for UCS-2 encoded messages and 4 for binary messages
 @param lDLR - One of the following: DELIVRD, EXPIRED, REJECTD, UNKNOWN, UNDELIV, FAILED
 @param lSender - Source
 @param lMccmnc - Destination mcc mnc
 @param lPrice - Message price
 @param lTimestamp - When the message reached Beepsend in Unix time
 @param lRecipient - Destination
 @param lValidTo - Until what date and time the message is considered valid for routing
 
 @return Returns Lookup object
 */
- (BSLookup *)initLookupWithID:(NSString *)lID
						 batch:(BSBatch *)lBatch
					   message:(NSString *)lMessage
				usedConnection:(BSConnection *)lConnection
					dataCoding:(NSNumber *)lDataCoding
				deliveryReport:(BSDLRReport *)lDLR
						sender:(BSRecipient *)lSender
						mccmnc:(BSMCCMNC *)lMccmnc
						 price:(NSNumber *)lPrice
					 timestamp:(BSTimestamps *)lTimestamp
					 recipient:(BSRecipient *)lRecipient
						 valid:(NSDate *)lValidTo;

@end
