//
//  BSMessageModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSMessageModel.h"

@interface BSMessageModel ()

@property (nonatomic, strong, readwrite) BSBatchModel *batch;
@property (nonatomic, strong, readwrite) NSString *recipient;
@property (nonatomic, strong, readwrite) NSArray *recipients;
@property (nonatomic, strong, readwrite) NSString *sender;
@property (nonatomic, strong, readwrite) NSArray *errors;
@property (nonatomic, strong, readwrite) NSArray *recipientGroups;

@end

@implementation BSMessageModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular message"]) {
		
	}
	return self;
}

- (BSMessageModel *)initMessageWithID:(NSString *)mID
								batch:(BSBatchModel *)mBatch
						   recipients:(id)mRecipients
							   sender:(NSString *)mSender
							   errors:(NSArray *)mErrors
					  recipientGroups:(NSArray *)mGroups
{
	if (self = [super initWithID:mID?mID:@"0" andTitle:mSender]) {
		_batch = mBatch;
		_sender = mSender;
		_errors = mErrors;
		_recipientGroups = mGroups;
		_recipient = [mRecipients isKindOfClass:[NSString class]] ? mRecipients : @"";
		_recipients = [mRecipients isKindOfClass:[NSArray class]] ? mRecipients : @[];
	}
	return self;
}

@end
