//
//  BSMessageRequestModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/30/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSMessageRequestModel : BSGeneralModel

@property (nonatomic, strong, readonly) id receiver; //Array or string
@property (nonatomic, strong, readonly) NSString *message;
@property (nonatomic, strong, readonly) NSString *sender;
@property (nonatomic, strong, readonly) NSString *batchID;
@property (nonatomic, strong, readonly) NSString *batchLabel;
@property (nonatomic, strong, readonly) NSDate *sendTime;
@property (nonatomic, strong, readonly) NSString *usedEncoding;
@property (nonatomic, strong, readonly) NSString *messageType;
@property (nonatomic, strong, readonly) NSDate *validTo;
@property (nonatomic, strong, readonly) NSNumber *receiveDeliveryReport;
@property (nonatomic, strong, readonly) NSArray *groups;

@property (nonatomic, strong, readonly) NSString *userDataHeader;
@property (nonatomic, strong, readonly) NSString *dataCodingSettings;

- (BSMessageRequestModel *)initWithMessage:(NSString *)rMessage
								  receiver:(id)rReceiver
									sender:(NSString *)rSender
								   batchID:(NSString *)rBatchID
								batchLabel:(NSString *)rBatchLabel
								  sendTime:(NSDate *)rSendTime
							  usedEncoding:(NSString *)rEncoding
							   messageType:(NSString *)rType
								   validTo:(NSDate *)rValidTo
								recieveDLR:(NSNumber *)rReceiveDLR
								 forGroups:(NSArray *)rGroups
							userDataHeader:(NSString *)rUDH
						dataCodingSettings:(NSString *)rDCS;

@end
