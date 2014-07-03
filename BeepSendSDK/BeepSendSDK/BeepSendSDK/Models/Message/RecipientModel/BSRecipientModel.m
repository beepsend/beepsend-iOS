//
//  BSRecipientModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSRecipientModel.h"

@interface BSRecipientModel ()

@property (nonatomic, strong, readwrite) NSString *destinationNumber;
@property (nonatomic, strong, readwrite) NSNumber *numberType;
@property (nonatomic, strong, readwrite) NSNumber *numberPlanIndex;

@end

@implementation BSRecipientModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular recipient"]) {
		
	}
	return self;
}

- (BSRecipientModel *)initRecipientWithNumber:(NSString *)number
								   numberType:(NSNumber *)nType
									planIndex:(NSNumber *)nPlanIndex
{
	if (self = [super initWithID:@"0" andTitle:@"Recipient"]) {
		_destinationNumber = number;
		_numberType = nType;
		_numberPlanIndex = nPlanIndex;
	}
	return self;
}

@end