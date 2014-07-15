//
//  BSCallbacksModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSCallbacks.h"

@implementation BSCallbacks

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular callbacks"]) {
		
	}
	return self;
}

- (BSCallbacks *)initCallbackWithMethod:(NSString *)cMethod
										 dlr:(NSString *)cDlr
										  mo:(NSString *)cMo
{
	if (self = [super initWithID:@"0" andTitle:@"Callback"]) {
		_DLR = cDlr;
		_MO = cMo;
		_method = cMethod;
	}
	return self;
}

@end
