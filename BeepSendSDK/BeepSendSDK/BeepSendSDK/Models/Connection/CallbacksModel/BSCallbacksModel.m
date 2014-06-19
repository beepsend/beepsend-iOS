//
//  BSCallbacksModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSCallbacksModel.h"

@interface BSCallbacksModel ()

@property (nonatomic, strong, readwrite) NSString *callbackDLR;
@property (nonatomic, strong, readwrite) NSString *callbackMO;
@property (nonatomic, strong, readwrite) NSString *callbackMethod;

@end

@implementation BSCallbacksModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular callbacks"]) {
		
	}
	return self;
}

- (BSCallbacksModel *)initCallbackWithMethod:(NSString *)cMethod
										 dlr:(NSString *)cDlr
										  mo:(NSString *)cMo
{
	if (self = [super initWithID:@"0" andTitle:@"Callback"]) {
		_callbackDLR = cDlr;
		_callbackMO = cMo;
		_callbackMethod = cMethod;
	}
	return self;
}

@end
