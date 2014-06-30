//
//  BSBatchModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/26/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSBatchModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *label;
@property (nonatomic, strong, readonly) NSDate *createdAt;
@property (nonatomic, strong, readonly) NSDate *lastUsed;

- (BSBatchModel *)initBatchWithID:(NSString *)bID
							label:(NSString *)bLabel
				   dateOfCreation:(NSDate *)bCreatedAt
					dateOfLastUse:(NSDate *)bLastUse;

@end
