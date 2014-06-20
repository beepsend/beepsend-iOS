//
//  BSUserModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSUserModel.h"

@interface BSUserModel ()

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *email;

@end

@implementation BSUserModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular user"]) {
		
	}
	return self;
}

- (BSUserModel *)initUserWithID:(NSString *)uID
						   name:(NSString *)uName
						  email:(NSString *)uEmail
{
	if (self = [super initWithID:uID andTitle:uName]) {
		_name = uName;
		_email = uEmail;
	}
	return self;
}

@end
