//
//  BSBatch.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/9/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBatch.h"

#import "BSAnalyticsService.h"

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

- (BSBatch *)initWithLabel:(NSString *)bLabel
{
	if (self = [super initWithID:@"0" andTitle:bLabel]) {
		_label = bLabel;
	}
	return self;
}

- (void)getDeliveryStatisticsWithCompletionBlock:(void (^)(NSArray *statistisc, NSArray *errors))block
{
	if (!_batchID || [BSHelper isNilOrEmpty:_batchID]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Batch ID missing!", @"")];
		block(nil, @[error]);
		
		return; //Batch id can't be nil
	}
	
	[[BSAnalyticsService sharedService] getDeliveryStatisticsForBach:self withCompletionBlock:^(NSArray *statistics, NSArray *errors) {
		
		if (errors && errors.count > 0) {
			block(nil, errors);
		}
		else {
			block(statistics, nil);
		}
	}];
}

@end
