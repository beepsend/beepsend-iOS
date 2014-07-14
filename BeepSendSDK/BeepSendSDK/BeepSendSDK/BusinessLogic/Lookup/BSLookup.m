//
//  BSLookupModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSLookup.h"

@interface BSLookup ()

@property (nonatomic, strong, readwrite) BSBatch *batch;
@property (nonatomic, strong, readwrite) NSString *messageBody;
@property (nonatomic, strong, readwrite) BSConnection *usedConnection;
@property (nonatomic, strong, readwrite) NSNumber *dataCoding; //0 for Gsm7 encoded messages. 8 for UCS-2 encoded messages and 4 for binary messages.
@property (nonatomic, strong, readwrite) BSDLRReport *deliveryReport;
@property (nonatomic, strong, readwrite) BSRecipient *sender;
@property (nonatomic, strong, readwrite) BSMCCMNC *mccmnc;
@property (nonatomic, strong, readwrite) NSNumber *price;
@property (nonatomic, strong, readwrite) BSTimestamps *timestamps;
@property (nonatomic, strong, readwrite) BSRecipient *recipient;
@property (nonatomic, strong, readwrite) NSDate *validTo;

@end

@implementation BSLookup

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular lookup"]) {
		
	}
	return self;
}

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
							  valid:(NSDate *)lValidTo
{
	if (self = [super initWithID:lID andTitle:@"SMS lookup"]) {
		_batch = lBatch;
		_messageBody = lMessage;
		_usedConnection = lConnection;
		_dataCoding = lDataCoding;
		_deliveryReport = lDLR;
		_sender = lSender;
		_mccmnc = lMccmnc;
		_price = lPrice;
		_timestamps = lTimestamp;
		_recipient = lRecipient;
		_validTo = lValidTo;
	}
	return self;
}

@end
