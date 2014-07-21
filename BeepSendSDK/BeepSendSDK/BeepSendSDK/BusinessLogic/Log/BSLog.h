//
//  BSLogModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/7/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSLog : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *logID;
@property (nonatomic, strong, readonly) NSDate *timeOfTransaction;
@property (nonatomic, strong, readonly) NSNumber *balanceAfterTransaction;
@property (nonatomic, strong, readonly) NSNumber *change;
@property (nonatomic, strong, readonly) NSString *comment;

- (BSLog *)initLogWithID:(NSString *)logID
				  atTime:(NSDate *)time
			 withBalance:(NSNumber *)balance
				  change:(NSNumber *)change
				 comment:(NSString *)comment;

@end
