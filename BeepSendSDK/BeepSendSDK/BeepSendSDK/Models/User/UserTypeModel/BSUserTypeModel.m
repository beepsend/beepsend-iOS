//
//  BSUserTypeModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSUserTypeModel.h"

@interface BSUserTypeModel ()

@property (nonatomic, strong, readwrite) NSString *name;

@end

@implementation BSUserTypeModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular user type"]) {
		
	}
	return self;
}

- (BSUserTypeModel *)initUserTypeWithID:(NSString *)uID
{
	if (self = [super initWithID:uID andTitle:@"ID User type"]) {
		
	}
	return self;
}

- (BSUserTypeModel *)initUserTypeWithID:(NSString *)uID
								   name:(NSString *)uName
{
	if (self = [super initWithID:uID andTitle:uName]) {
		_name = uName;
	}
	return self;
}

@end
