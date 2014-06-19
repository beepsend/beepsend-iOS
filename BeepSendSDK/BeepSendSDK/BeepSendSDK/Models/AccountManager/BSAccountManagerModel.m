//
//  BSAccountManagerModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAccountManagerModel.h"

@interface BSAccountManagerModel ()

@property (nonatomic, strong, readwrite) NSString *accountManagerName;
@property (nonatomic, strong, readwrite) NSString *accountManagerEmail;

@end

@implementation BSAccountManagerModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular account manager"]) {
		
	}
	return self;
}

- (BSAccountManagerModel *)initAccountManagerWithName:(NSString *)amName
											 andEmail:(NSString *)amEmail
{
	if (self = [super initWithID:@"0" andTitle:amName]) {
		_accountManagerName = amName;
		_accountManagerEmail = amEmail;
	}
	return self;
}

@end
