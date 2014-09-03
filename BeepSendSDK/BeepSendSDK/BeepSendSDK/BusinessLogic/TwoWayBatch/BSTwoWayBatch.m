//
//  BSTwoWayBatch.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 9/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSTwoWayBatch.h"

@interface BSTwoWayBatch ()

@property (nonatomic, strong, readwrite) NSString *mtSmsID;
@property (nonatomic, strong, readwrite) NSString *mtBody;
@property (nonatomic, strong, readwrite) NSString *moSmsID;
@property (nonatomic, strong, readwrite) NSString *moBody;
@property (nonatomic, strong, readwrite) NSString *deliveryStatus;

@end

@implementation BSTwoWayBatch

#pragma mark - Properties

- (NSString *)mtSmsID
{
	return [BSHelper isNilOrEmpty:_mtSmsID] ? @"0" : [_mtSmsID isKindOfClass:[NSNumber class]] ? [(NSNumber *)_mtSmsID stringValue] : _mtSmsID;
}

- (NSString *)mtBody
{
	return _mtBody ? _mtBody : @"";
}

- (NSString *)moSmsID
{
	return [BSHelper isNilOrEmpty:_moSmsID] ? @"0" : [_moSmsID isKindOfClass:[NSNumber class]] ? [(NSNumber *)_moSmsID stringValue] : _moSmsID;
}

- (NSString *)moBody
{
	return _moBody ? _moBody : @"";
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular Batch"]) {
		
	}
	return self;
}

- (BSTwoWayBatch *)initWithMtSmsID:(NSString *)tMtSmsID
							mtBody:(NSString *)tMtBody
						   moSmsID:(NSString *)tMoSmsID
							moBody:(NSString *)tMoBody
					deliveryStatus:(NSString *)tDeliveryStatus
{
	if (self = [super initWithID:@"0" andTitle:@"Batch"]) {
		
		_mtSmsID = tMtSmsID;
		_mtBody = tMtBody;
		_moSmsID = tMoSmsID;
		_moBody = tMoBody;
		_deliveryStatus = tDeliveryStatus;
	}
	return self;
}

@end
