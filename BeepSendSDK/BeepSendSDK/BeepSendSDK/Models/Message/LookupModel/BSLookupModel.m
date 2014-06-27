//
//  BSLookupModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSLookupModel.h"

@interface BSLookupModel ()

@property (nonatomic, strong, readwrite) BSBatchModel *batch;
@property (nonatomic, strong, readwrite) NSString *messageBody;
@property (nonatomic, strong, readwrite) BSConnectionModel *usedConnection;
@property (nonatomic, strong, readwrite) NSNumber *dataCoding; //0 for Gsm7 encoded messages. 8 for UCS-2 encoded messages and 4 for binary messages.
@property (nonatomic, strong, readwrite) BSDLRReportModel *deliveryReport;
@property (nonatomic, strong, readwrite) BSRecipientModel *sender;
@property (nonatomic, strong, readwrite) BSMCCMNCModel *mccmnc;
@property (nonatomic, strong, readwrite) NSNumber *price;
@property (nonatomic, strong, readwrite) BSTimestampsModel *timestamps;
@property (nonatomic, strong, readwrite) BSRecipientModel *recipient;
@property (nonatomic, strong, readwrite) NSDate *validTo;

@end

@implementation BSLookupModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular lookup"]) {
		
	}
	return self;
}

- (BSLookupModel *)initLookupWithID:(NSString *)lID
							  batch:(BSBatchModel *)lBatch
							message:(NSString *)lMessage
					 usedConnection:(BSConnectionModel *)lConnection
						 dataCoding:(NSNumber *)lDataCoding
					 deliveryReport:(BSDLRReportModel *)lDLR
							 sender:(BSRecipientModel *)lSender
							 mccmnc:(BSMCCMNCModel *)lMccmnc
							  price:(NSNumber *)lPrice
						  timestamp:(BSTimestampsModel *)lTimestamp
						  recipient:(BSRecipientModel *)lRecipient
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
