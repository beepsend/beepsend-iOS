//
//  APPCountry.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPPCountry.h"

#import "BSCountry.h"

@implementation BSAPPCountry

#pragma mark - Inherited methods

- (id)convertToModel
{
	return [[BSCountry alloc] initCountryNamed:_name?_name:@"" withCountryCode:_code?_code:@"" andCallingCode:_prefix?_prefix:@0];
}

@end
