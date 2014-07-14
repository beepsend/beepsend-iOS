//
//  BSAPRecipient.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPRecipient.h"

#import "BSRecipient.h"

@implementation BSAPRecipient

#pragma mark - Inherited methods

- (id)convertToModel
{
	return [[BSRecipient alloc] initRecipientWithNumber:_address numberType:_ton planIndex:_npi];
}

@end
