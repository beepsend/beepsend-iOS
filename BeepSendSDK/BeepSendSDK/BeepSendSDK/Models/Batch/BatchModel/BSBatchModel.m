//
//  BSBatchModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/26/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBatchModel.h"

@interface BSBatchModel ()

@property (nonatomic, strong, readwrite) NSString *label;
@property (nonatomic, strong, readwrite) NSDate *createdAt;
@property (nonatomic, strong, readwrite) NSDate *lastUsed;

@end

@implementation BSBatchModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular batch"]) {
		
	}
	return self;
}

- (BSBatchModel *)initBatchWithID:(NSString *)bID
							label:(NSString *)bLabel
				   dateOfCreation:(NSDate *)bCreatedAt
					dateOfLastUse:(NSDate *)bLastUse
{
	if (self = [super initWithID:bID andTitle:bLabel]) {
		_label = bLabel;
		_createdAt = bCreatedAt;
		_lastUsed = bLastUse;
	}
	return self;
}


@end
