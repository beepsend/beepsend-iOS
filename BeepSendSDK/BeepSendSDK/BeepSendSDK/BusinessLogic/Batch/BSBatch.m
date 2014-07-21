//
//  BSBatch.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/9/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBatch.h"

@interface BSBatch ()

@property (nonatomic, strong, readwrite) NSString *batchID;
@property (nonatomic, strong, readwrite) NSString *label;

@end

@implementation BSBatch

#pragma mark - Properties

- (NSString *)batchID
{
	return [BSHelper isNilOrEmpty:_batchID] ? @"0" : [_batchID isKindOfClass:[NSNumber class]] ? [(NSNumber *)_batchID stringValue] : _batchID;
}

- (NSString *)label
{
	return [BSHelper isNilOrEmpty:_label] ? @"" : _label;
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular connection"]) {
		_batchID = @"-1";
	}
	return self;
}

- (BSBatch *)initWithID:(NSString *)bID andLabel:(NSString *)bLabel
{
	if (self = [super initWithID:bID andTitle:bLabel]) {
		_batchID = bID;
		_label = bLabel;
	}
	return self;
}

@end
