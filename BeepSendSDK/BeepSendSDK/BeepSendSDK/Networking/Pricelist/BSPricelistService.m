//
//  BSPricelistService.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/20/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSPricelistService.h"

#import "BSAPIConfiguration.h"

#import "BSAPPricelist.h"

@implementation BSPricelistService

#pragma mark - Initialization

+ (instancetype)sharedService
{
	static id singleton;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		singleton = [[[self class] alloc] init];
	});
	return singleton;
}

#pragma mark - Public methods

- (void)getCurrentPricelistsForConnection:(BSConnectionModel *)connection withCompletionBlock:(void(^)(BSPricelist *pricelist, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration pricelistCurrentWithID:connection.objectID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  BSPricelist *pricelist = [[BSAPPricelist classFromDict:response] convertToModel];
						  
						  block(pricelist, error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)getCurrentPricelistsForMeWithCompletionBlock:(void(^)(BSPricelist *pricelist, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration pricelistCurrentMe]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  BSPricelist *pricelist = [[BSAPPricelist classFromDict:response] convertToModel];
						  
						  block(pricelist, error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)getPricelistsForConnection:(BSConnectionModel *)connection withCompletionBlock:(void(^)(NSArray *pricelists, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration pricelistAllForID:connection.objectID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPPricelist *pricelist in [BSAPPricelist arrayOfObjectsFromArrayOfDictionaries:response]) {
							  
							  [mArr addObject:[pricelist convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], error);
						  
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)getPriceListsForMeWithCompletionBlock:(void(^)(NSArray *pricelists, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration pricelistAllMe]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPPricelist *pricelist in [BSAPPricelist arrayOfObjectsFromArrayOfDictionaries:response]) {
							  
							  [mArr addObject:[pricelist convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], error);
						  
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

@end
