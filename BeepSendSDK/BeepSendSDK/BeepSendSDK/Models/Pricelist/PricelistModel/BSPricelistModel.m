//
//  BSPricelistModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSPricelistModel.h"

@interface BSPricelistModel ()

@property (nonatomic, strong, readwrite) NSArray *networks;
@property (nonatomic, strong, readwrite) NSNumber *networkCount;
@property (nonatomic, strong, readwrite) NSDate *saved;
@property (nonatomic, assign, readwrite, getter = isActive) BOOL active;
@property (nonatomic, strong, readwrite) NSDate *firstViewed;

@end

@implementation BSPricelistModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular pricelist"]) {
		
	}
	return self;
}

- (BSPricelistModel *)initPricelistWithID:(NSString *)pID
								 networks:(NSArray *)pNetworks
							 networkCount:(NSNumber *)nCount
							   timeOfSave:(NSDate *)nSaved
								   active:(BOOL)active
						  timeOfFirstView:(NSDate *)nFirstView
{
	if (self = [super initWithID:pID andTitle:@"Pricelist"]) {
		_networks = pNetworks;
		_networkCount = nCount;
		_saved = nSaved;
		_active = active;
		_firstViewed = nFirstView;
	}
	return self;
}

@end
