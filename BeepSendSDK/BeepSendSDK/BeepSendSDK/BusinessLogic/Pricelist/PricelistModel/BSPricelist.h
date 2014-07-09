//
//  BSPricelistModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSNetwork.h"

@interface BSPricelist : BSGeneralModel

@property (nonatomic, strong, readonly) NSArray *networks;
@property (nonatomic, strong, readonly) NSNumber *networkCount;
@property (nonatomic, strong, readonly) NSDate *saved;
@property (nonatomic, assign, readonly) NSNumber *active;
@property (nonatomic, strong, readonly) NSDate *firstViewed;

- (BSPricelist *)initPricelistWithID:(NSString *)pID
							networks:(NSArray *)pNetworks
						networkCount:(NSNumber *)nCount
						  timeOfSave:(NSDate *)nSaved
							  active:(NSNumber *)active
					 timeOfFirstView:(NSDate *)nFirstView;

@end
