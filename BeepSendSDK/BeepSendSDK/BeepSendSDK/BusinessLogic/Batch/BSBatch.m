//
//  BSBatch.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/9/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBatch.h"

@implementation BSBatch

- (BSBatch *)initWithID:(NSString *)bID andLabel:(NSString *)bLabel
{
	if (self = [super init]) {
		_batchID = bID;
		_label = bLabel;
	}
	return self;
}

@end
