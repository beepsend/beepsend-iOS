//
//  BSCountryModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSCountryModel.h"

@interface BSCountryModel ()

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSNumber *callingCode;
@property (nonatomic, strong, readwrite) NSString *code;

@end

@implementation BSCountryModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular country"]) {
		
	}
	return self;
}

- (BSCountryModel *)initCountryNamed:(NSString *)cName
					 withCountryCode:(NSString *)cCountryCode
					  andCallingCode:(NSNumber *)cCallingCode
{
	if (self = [super initWithID:@"0" andTitle:cName]) {
		_name = cName;
		_callingCode = cCallingCode;
		_code = cCountryCode;
	}
	return self;
}

@end
