//
//  BSLookupModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSBatch.h"

#import "BSConnectionModel.h"
#import "BSDLRReportModel.h"
#import "BSRecipientModel.h"
#import "BSMCCMNC.h"
#import "BSTimestampsModel.h"

@interface BSLookupModel : BSGeneralModel

@property (nonatomic, strong, readonly) BSBatch *batch;
@property (nonatomic, strong, readonly) NSString *messageBody;
@property (nonatomic, strong, readonly) BSConnectionModel *usedConnection;
@property (nonatomic, strong, readonly) NSNumber *dataCoding; //0 for Gsm7 encoded messages. 8 for UCS-2 encoded messages and 4 for binary messages.
@property (nonatomic, strong, readonly) BSDLRReportModel *deliveryReport;
@property (nonatomic, strong, readonly) BSRecipientModel *sender;
@property (nonatomic, strong, readonly) BSMCCMNC *mccmnc;
@property (nonatomic, strong, readonly) NSNumber *price;
@property (nonatomic, strong, readonly) BSTimestampsModel *timestamps;
@property (nonatomic, strong, readonly) BSRecipientModel *recipient;
@property (nonatomic, strong, readonly) NSDate *validTo;

- (BSLookupModel *)initLookupWithID:(NSString *)lID
							  batch:(BSBatch *)lBatch
							message:(NSString *)lMessage
					 usedConnection:(BSConnectionModel *)lConnection
						 dataCoding:(NSNumber *)lDataCoding
					 deliveryReport:(BSDLRReportModel *)lDLR
							 sender:(BSRecipientModel *)lSender
							 mccmnc:(BSMCCMNC *)lMccmnc
							  price:(NSNumber *)lPrice
						  timestamp:(BSTimestampsModel *)lTimestamp
						  recipient:(BSRecipientModel *)lRecipient
							  valid:(NSDate *)lValidTo;

@end
