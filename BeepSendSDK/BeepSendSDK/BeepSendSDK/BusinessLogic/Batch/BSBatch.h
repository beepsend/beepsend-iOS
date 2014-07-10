//
//  BSBatch.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/9/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSBatch : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *batchID;
@property (nonatomic, strong, readonly) NSString *label;

@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSDate *lastUsed;

- (BSBatch *)initWithID:(NSString *)bID andLabel:(NSString *)bLabel;

@end
