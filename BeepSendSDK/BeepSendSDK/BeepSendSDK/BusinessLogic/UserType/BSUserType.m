//
//  BSUserTypeModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSUserType.h"

@interface BSUserType ()

@property (nonatomic, strong, readwrite) NSString *name;

@end

@implementation BSUserType

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular user type"]) {
		_userTypeID = @"-1";
	}
	return self;
}

- (BSUserType *)initUserTypeWithID:(NSString *)uID
{
	if (self = [super initWithID:uID andTitle:@"ID User type"]) {
		_userTypeID = uID;
	}
	return self;
}

- (BSUserType *)initUserTypeWithID:(NSString *)uID
								   name:(NSString *)uName
{
	if (self = [super initWithID:uID andTitle:uName]) {
		_userTypeID = uID;
		_name = uName;
	}
	return self;
}

@end
