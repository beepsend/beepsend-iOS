//
//  BSPricelistModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSNetwork;

@interface BSPricelist : BSGeneralModel

/** Pricelist revision ID.
 */
@property (nonatomic, strong, readonly) NSString *pricelistID;

/** An array of networks covered by this pricelist.
 */
@property (nonatomic, strong, readonly) NSArray *networks;

/** Number of networks covered by this pricelist.
 */
@property (nonatomic, strong, readonly) NSNumber *networkCount;

/** Date of save for this pricelist.
 */
@property (nonatomic, strong, readonly) NSDate *saved;

/** Whether this pricelist is active or not.
 */
@property (nonatomic, assign, readonly) NSNumber *active;

/** First time this pricelist was accessed by customer.
 */
@property (nonatomic, strong, readonly) NSDate *firstViewed;

/** Init Pricelist with pricelist ID, networks, Count, Saved, Active, first viewed
 
 @param pID - Pricelist ID
 @param pNetworks - Networks
 @param nCount - Count
 @param nSaved - Saved
 @param active - Active
 @param nFirstView - First viewed
 
 @return Returns Pricelist object
 */
- (BSPricelist *)initPricelistWithID:(NSString *)pID
							networks:(NSArray *)pNetworks
						networkCount:(NSNumber *)nCount
						  timeOfSave:(NSDate *)nSaved
							  active:(NSNumber *)active
					 timeOfFirstView:(NSDate *)nFirstView;

@end
