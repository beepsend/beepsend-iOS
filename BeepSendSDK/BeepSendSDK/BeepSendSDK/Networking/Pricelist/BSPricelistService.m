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
#import "BSAPPNetwork.h"

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

- (void)getCurrentPricelistsForConnection:(BSConnection *)connection withCompletionBlock:(void(^)(BSPricelist *pricelist, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration pricelistCurrentWithID:connection.connectionID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  BSPricelist *pricelist = [[BSAPPricelist classFromDict:response] convertToModel];
						  
						  block(pricelist, nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)getCurrentPricelistsForMeWithCompletionBlock:(void(^)(BSPricelist *pricelist, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration pricelistCurrentMe]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  BSPricelist *pricelist = [[BSAPPricelist classFromDict:response] convertToModel];
						  
						  block(pricelist, nil);
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)getPricelistsForConnection:(BSConnection *)connection withCompletionBlock:(void(^)(NSArray *pricelists, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration pricelistAllForID:connection.connectionID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPPricelist *pricelist in [BSAPPricelist arrayOfObjectsFromArrayOfDictionaries:response]) {
							  
							  [mArr addObject:[pricelist convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], nil);
						  
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)getPriceListsForMeWithCompletionBlock:(void(^)(NSArray *pricelists, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration pricelistAllMe]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPPricelist *pricelist in [BSAPPricelist arrayOfObjectsFromArrayOfDictionaries:response]) {
							  
							  [mArr addObject:[pricelist convertToModel]];
						  }
						  block([NSArray arrayWithArray:mArr], nil);
						  
					  }
					  else {

						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)getPricelistAsCSVForConnection:(BSConnection *)connection onCompletion:(void(^)(NSString *pricelist, NSArray *errors))block
{
	[super executeGETForMethod:[BSAPIConfiguration pricelistCSVForID:connection.connectionID] forCSVDownloadOnCompletion:^(id response, id error) {
		
		if (!error) {
			
			NSString *csvString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
			block(csvString, nil);
		}
		else {
			
			block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
		}
	}];
}

- (void)getPricelistDiffForConnection:(BSConnection *)connection withPricelist1:(BSPricelist *)pricelist1 andPricelist2:(BSPricelist *)pricelist2 onCompletion:(void(^)(BSNetwork *diff, NSArray *error))block
{
	[super executeGETForMethod:[BSAPIConfiguration pricelistDiffForConnectionID:connection.connectionID rev1:pricelist1.pricelistID rev2:pricelist2.pricelistID]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPPNetwork *pricelist in [BSAPPNetwork arrayOfObjectsFromArrayOfDictionaries:response]) {
							  
							  [mArr addObject:[pricelist convertToModel]];
						  }
						  
						  if (mArr.count>0) {
							  block(mArr[0], nil);
						  }
						  else {
							  block(nil, nil);
						  }
					  }
					  else {
						  
						  block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
					  }
				  }];
}

- (void)getPricelistDiffAsCSVForConnection:(BSConnection *)connection withPricelist1:(BSPricelist *)pricelist1 andPricelist2:(BSPricelist *)pricelist2 onCompletion:(void(^)(NSString *diff, NSArray *error))block
{
	[super executeGETForMethod:[BSAPIConfiguration pricelistDiffAsCSVForConnectionID:connection.connectionID rev1:pricelist1.pricelistID rev2:pricelist2.pricelistID] forCSVDownloadOnCompletion:^(id response, id error) {
		
		if (!error) {
			
			NSString *csvString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
			block(csvString, nil);
		}
		else {
			
			block(nil, [BSHelper handleErrorWithResponse:response andOptionalError:error]);
		}
	}];
}

@end
