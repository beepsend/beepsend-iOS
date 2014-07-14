//
//  BSGroupModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/26/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGroup.h"

@interface BSGroup ()

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSNumber *contactsCount;
@property (nonatomic, strong, readwrite) NSNumber *processing;

@end


@implementation BSGroup

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular group"]) {
		
	}
	return self;
}

- (BSGroup *)initGroupWithID:(NSString *)gID
							 name:(NSString *)gName
						 contacts:(NSNumber *)gContactsCount
					   processing:(NSNumber *)gProcessing
{
	if (self = [super initWithID:gID andTitle:gName]) {
		_name = gName;
		_contactsCount = gContactsCount;
		_processing = gProcessing;
	}
	return self;
}

- (BSGroup *)initGroupWithName:(NSString *)gName
{
	if (self = [super initWithID:@"0" andTitle:gName]) {
		_name = gName;
	}
	return self;
}

- (BSGroup *)initGroupWithID:(NSString *)gID
							 name:(NSString *)gName
						 contacts:(NSNumber *)gContactsCount
{
	if (self = [super initWithID:gID andTitle:gName]) {
		_name = gName;
		_contactsCount = gContactsCount;
	}
	return self;
}

@end
