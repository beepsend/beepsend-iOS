//
//  APCCallback.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPCCallback.h"

#import "BSCallbacksModel.h"

@implementation BSAPCCallback

#pragma mark - Inherited methods

- (id)convertToModel
{
	return [[BSCallbacksModel alloc] initCallbackWithMethod:_method?_method:@"" dlr:_dlr?_dlr:@"" mo:_mo?_mo:@""];
}

@end
