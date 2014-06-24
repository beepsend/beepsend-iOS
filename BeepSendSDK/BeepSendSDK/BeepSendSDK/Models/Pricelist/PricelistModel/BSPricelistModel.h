//
//  BSPricelistModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSNetworkModel.h"

@interface BSPricelistModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSArray *networks;
@property (nonatomic, strong, readonly) NSNumber *networkCount;
@property (nonatomic, strong, readonly) NSDate *saved;
@property (nonatomic, assign, readonly, getter = isActive) BOOL active;
@property (nonatomic, strong, readonly) NSDate *firstViewed;

- (BSPricelistModel *)initPricelistWithID:(NSString *)pID
								 networks:(NSArray *)pNetworks
							 networkCount:(NSNumber *)nCount
							   timeOfSave:(NSDate *)nSaved
								   active:(BOOL)active
						  timeOfFirstView:(NSDate *)nFirstView;

@end