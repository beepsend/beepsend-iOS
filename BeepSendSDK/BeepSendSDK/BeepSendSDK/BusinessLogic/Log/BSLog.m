//
//  BSLogModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/7/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSLog.h"

@interface BSLog ()

@property (nonatomic, strong, readwrite) NSDate *timeOfTransaction;
@property (nonatomic, strong, readwrite) NSNumber *balanceAfterTransaction;
@property (nonatomic, strong, readwrite) NSNumber *change;
@property (nonatomic, strong, readwrite) NSString *comment;

@end

@implementation BSLog

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular Log"]) {
		_logID = @"-1";
	}
	return self;
}

- (BSLog *)initLogWithID:(NSString *)logID
				  atTime:(NSDate *)time
			 withBalance:(NSNumber *)balance
				  change:(NSNumber *)change
				 comment:(NSString *)comment
{
	if (self = [super initWithID:logID andTitle:@"Transaction Log"]) {
		_logID = logID;
		_timeOfTransaction = time;
		_balanceAfterTransaction = balance;
		_change = change;
		_comment = comment;
	}
	return self;
}

@end
