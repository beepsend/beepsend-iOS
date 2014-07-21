//
//  APCCallback.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPCCallback.h"

#import "BSCallbacks.h"

@implementation BSAPCCallback

#pragma mark - Inherited methods

- (id)convertToModel
{
	return [[BSCallbacks alloc] initCallbackWithMethod:_method?_method:nil dlr:_dlr?_dlr:nil mo:_mo?_mo:nil];
}

@end
