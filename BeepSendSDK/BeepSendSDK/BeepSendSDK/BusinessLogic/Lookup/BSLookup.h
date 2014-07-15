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

@property (nonatomic, strong, readonly) BSBatch *batch;
@property (nonatomic, strong, readonly) NSString *messageBody;
@property (nonatomic, strong, readonly) BSConnection *usedConnection;
@property (nonatomic, strong, readonly) NSNumber *dataCoding; //0 for Gsm7 encoded messages. 8 for UCS-2 encoded messages and 4 for binary messages.
@property (nonatomic, strong, readonly) BSDLRReport *deliveryReport;
@property (nonatomic, strong, readonly) BSRecipient *sender;
@property (nonatomic, strong, readonly) BSMCCMNC *mccmnc;
@property (nonatomic, strong, readonly) NSNumber *price;
@property (nonatomic, strong, readonly) BSTimestamps *timestamps;
@property (nonatomic, strong, readonly) BSRecipient *recipient;
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
