//
//  BSAPSMSLookup.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPSMSLookup.h"

#import "BSLookup.h"

@implementation BSAPSMSLookup

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	if (![dictionary isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	//We need to register all classes before load
	[BSAPBatch class];
	[BSAPConnection class];
	[BSAPDLRReport class];
	[BSAPRecipient class];
	[BSAPPMCCMNC class];
	[BSAPTimestamps class];

	BSAPSMSLookup *messageLookup = [super classFromDict:dictionary];
	
	return messageLookup;
}

- (id)convertToModel
{
	NSDateFormatter *smppFormatter = [[NSDateFormatter alloc] init];
	[smppFormatter setDateFormat:kDateFormatForSMPPStandard];
	NSDate *validTo = [smppFormatter dateFromString:_validity_period];
	
	return [[BSLookup alloc] initLookupWithID:_id
										batch:[_batch convertToModel]
									  message:_body
							   usedConnection:[_connection convertToModel]
								   dataCoding:_data_coding
							   deliveryReport:[_dlr convertToModel]
									   sender:[_from convertToModel]
									   mccmnc:[_mccmnc convertToModel]
										price:_price
									timestamp:[_timestamps	convertToModel]
									recipient:[_to convertToModel]
										valid:validTo];
}

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPSMSLookup classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

@end
