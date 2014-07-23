//
//  BSLookupModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSBatch;
@class BSTimestamps;
@class BSMCCMNC;
@class BSRecipient;
@class BSDLRReport;
@class BSConnection;

@interface BSLookup : BSGeneralModel

/** Unique Beepsend generated ID.
 */
@property (nonatomic, strong, readonly) NSString *lookupID;

/** id and label or null if message was sent with no batch specified.
 */
@property (nonatomic, strong, readonly) BSBatch *batch;

/** The message body of sent SMS.
 */
@property (nonatomic, strong, readonly) NSString *messageBody;

/** Connection details.
 */
@property (nonatomic, strong, readonly) BSConnection *usedConnection;

/** 0 for Gsm7 encoded messages. 8 for UCS-2 encoded messages and 4 for binary messages.
 */
@property (nonatomic, strong, readonly) NSNumber *dataCoding;

/** One of the following: DELIVRD, EXPIRED, REJECTD, UNKNOWN, UNDELIV, FAILED. 
	Or null if message has not yet been delivered.
 */
@property (nonatomic, strong, readonly) BSDLRReport *deliveryReport;

/** Source
 */
@property (nonatomic, strong, readonly) BSRecipient *sender;

/** Destination mcc mnc.
 */
@property (nonatomic, strong, readonly) BSMCCMNC *mccmnc;

/** Message price.
 */
@property (nonatomic, strong, readonly) NSNumber *price;

/** When the message reached Beepsend in Unix time.
 */
@property (nonatomic, strong, readonly) BSTimestamps *timestamps;

/** Destination
 */
@property (nonatomic, strong, readonly) BSRecipient *recipient;

/** Until what date and time the message is considered valid for routing. 
	Formatted like YYMMDDhhmmsstnnp according to the SMPP standard.
 */
@property (nonatomic, strong, readonly) NSDate *validTo;

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
