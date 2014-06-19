//
//  BSBaseService.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/13/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSNetworkLayer.h"

#import "BSAPIConfiguration.h"

@interface BSBaseService ()

@end

@implementation BSBaseService

#pragma mark - Initialization

+ (instancetype)sharedService
{
	return nil;
}

#pragma mark - Public methods

- (void)executeGETForMethod:(NSString *)method
			 withParameters:(NSDictionary *)parameters
			   onCompletion:(RequestCompletionBLock)block
{
	BSNetworkLayer *layer = [BSNetworkLayer networkLayerWithBaseStringURL:[BSAPIConfiguration baseURL]];
	
	[layer executeHTTPMethod:HTTPMethodGET
	   withRequestSerializer:RequestSerializerJSON
	   andResponseSerializer:ResponseSerializerJSON
				   forMethod:method
			  withParameters:parameters
		   additionalHeaders:[BSAPIConfiguration authorizationHeader]
				onCompletion:^(id response, id error) {
			   
			   block(response, error);
			   
		   }];
}

- (void)executePOSTForMethod:(NSString *)method
			  withParameters:(NSDictionary *)parameters
				onCompletion:(RequestCompletionBLock)block
{
	BSNetworkLayer *layer = [BSNetworkLayer networkLayerWithBaseStringURL:[BSAPIConfiguration baseURL]];
	
	[layer executeHTTPMethod:HTTPMethodPOST
	   withRequestSerializer:RequestSerializerJSON
	   andResponseSerializer:ResponseSerializerJSON
				   forMethod:method
			  withParameters:parameters
		   additionalHeaders:[BSAPIConfiguration authorizationHeader]
				onCompletion:^(id response, id error) {
			   
			   block(response, error);
			   
		   }];
}

- (void)executePUTForMethod:(NSString *)method
			 withParameters:(NSDictionary *)parameters
			   onCompletion:(RequestCompletionBLock)block
{
	BSNetworkLayer *layer = [BSNetworkLayer networkLayerWithBaseStringURL:[BSAPIConfiguration baseURL]];
	
	[layer executeHTTPMethod:HTTPMethodPUT
	   withRequestSerializer:RequestSerializerJSON
	   andResponseSerializer:ResponseSerializerJSON
				   forMethod:method
			  withParameters:parameters
		   additionalHeaders:[BSAPIConfiguration authorizationHeader]
				onCompletion:^(id response, id error) {
			   
			   block(response, error);
			   
		   }];
}

- (void)executeDELETEForMethod:(NSString *)method
				withParameters:(NSDictionary *)parameters
				  onCompletion:(RequestCompletionBLock)block
{
	BSNetworkLayer *layer = [BSNetworkLayer networkLayerWithBaseStringURL:[BSAPIConfiguration baseURL]];
	
	[layer executeHTTPMethod:HTTPMethodDELETE
	   withRequestSerializer:RequestSerializerJSON
	   andResponseSerializer:ResponseSerializerJSON
				   forMethod:method
			  withParameters:parameters
		   additionalHeaders:[BSAPIConfiguration authorizationHeader]
				onCompletion:^(id response, id error) {
			   
			   block(response, error);
			   
		   }];
}

@end
