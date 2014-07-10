//
//  BSAccountManagerModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAccountManager.h"

@interface BSAccountManager ()

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *email;

@end

@implementation BSAccountManager

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular account manager"]) {
		
	}
	return self;
}

- (BSAccountManager *)initAccountManagerWithName:(NSString *)amName
										andEmail:(NSString *)amEmail
{
	if (self = [super initWithID:@"0" andTitle:amName]) {
		_name = amName;
		_email = amEmail;
	}
	return self;
}

@end
