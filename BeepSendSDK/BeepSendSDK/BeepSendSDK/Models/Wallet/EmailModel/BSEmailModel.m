//
//  BSEmailModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSEmailModel.h"

@interface BSEmailModel ()

@property (nonatomic, strong, readwrite) NSString *address;

@end

@implementation BSEmailModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular email"]) {
		
	}
	return self;
}

- (BSEmailModel *)initEmailWithID:(NSString *)eID atAddress:(NSString *)address
{
	if (self = [super initWithID:eID andTitle:address]) {
		_address = address;
	}
	return self;
}

- (BSEmailModel *)initEmailWithAddress:(NSString *)address
{
	if (self = [super initWithID:@"0" andTitle:address]) {
		_address = address;
	}
	return self;
}

@end
