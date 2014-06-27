//
//  BSMessageModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSBatchModel.h"

@interface BSMessageModel : BSGeneralModel

@property (nonatomic, strong, readonly) BSBatchModel *batch;
@property (nonatomic, strong, readonly) NSString *recipient;
@property (nonatomic, strong, readonly) NSArray *recipients;
@property (nonatomic, strong, readonly) NSString *sender;
@property (nonatomic, strong, readonly) NSArray *errors;
@property (nonatomic, strong, readonly) NSArray *recipientGroups;

- (BSMessageModel *)initMessageWithID:(NSString *)mID
								batch:(BSBatchModel *)mBatch
						   recipients:(id)mRecipients
							   sender:(NSString *)mSender
							   errors:(NSArray *)mErrors
					  recipientGroups:(NSArray *)mGroups;

@end
