//
//  BSGeneralService.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/13/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSNetworkLayer.h"

#import "BSAFNetworking.h"

@interface BSNetworkLayer ()

@property (nonatomic, strong) NSURL *baseURL;

@end

@implementation BSNetworkLayer

#pragma mark - Initialization

- (BSNetworkLayer *)initWithBaseURL:(NSURL *)baseURL
{
	if (self = [super init]) {
		_baseURL = baseURL;
	}
	return self;
}

- (BSNetworkLayer *)initWithBaseStringURL:(NSString *)baseURL
{
	return [[BSNetworkLayer alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
}

+ (BSNetworkLayer *)networkLayerWithBaseURL:(NSURL *)baseURL
{
	return [[BSNetworkLayer alloc] initWithBaseURL:baseURL];
}

+ (BSNetworkLayer *)networkLayerWithBaseStringURL:(NSString *)baseURL
{
	return [BSNetworkLayer networkLayerWithBaseURL:[NSURL URLWithString:baseURL]];
}

#pragma mark - Private methods

- (BSAFHTTPSessionManager *)getSessionManagerWithRequestSerializer:(RequestSerializer)requestSerializer
											 andResponseSerializer:(ResponseSerializer)responseSerializer
{
	BSAFHTTPSessionManager *_manager = [[BSAFHTTPSessionManager alloc] init];
	
	switch (requestSerializer) {
		case RequestSerializerHTTP:
		{
			_manager.requestSerializer  = [BSAFHTTPRequestSerializer serializer];
		}
			break;
		case RequestSerializerJSON:
		{
			_manager.requestSerializer  = [BSAFJSONRequestSerializer serializer];
		}
			break;
		case RequestSerializerPropertyList:
		{
			_manager.requestSerializer  = [BSAFPropertyListRequestSerializer serializer];
		}
			break;
		default:
		{
			_manager.requestSerializer  = [BSAFHTTPRequestSerializer serializer];
		}
			break;
	}
	
	switch (responseSerializer) {
		case ResponseSerializerHTTP:
		{
			_manager.responseSerializer = [BSAFHTTPResponseSerializer serializer];
		}
			break;
		case ResponseSerializerJSON:
		{
			_manager.responseSerializer = [BSAFJSONResponseSerializer serializer];
		}
			break;
		case ResponseSerializerXMLParser:
		{
			_manager.responseSerializer = [BSAFXMLParserResponseSerializer serializer];
		}
			break;
		case ResponseSerializerPropertyList:
		{
			_manager.responseSerializer = [BSAFPropertyListResponseSerializer serializer];
		}
			break;
		case ResponseSerializerImage:
		{
			_manager.responseSerializer = [BSAFImageResponseSerializer serializer];
		}
			break;
		case ResponseSerializerCompound:
		{
			_manager.responseSerializer = [BSAFCompoundResponseSerializer serializer];
		}
			break;
		default:
		{
			_manager.responseSerializer = [BSAFHTTPResponseSerializer serializer];
		}
			break;
	}
	
	
	return _manager;
}

- (NSURL *)urlWithMethod:(NSString *)method {
	return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", _baseURL.absoluteString, method]];
}

#pragma mark - Public methods

- (void)executeHTTPMethod:(HTTPMethod)HTTPmethod
	withRequestSerializer:(RequestSerializer)requestSerializer
	andResponseSerializer:(ResponseSerializer)responseSerializer
				forMethod:(NSString *)method
		   withParameters:(NSDictionary *)parameters
		additionalHeaders:(NSDictionary *)headers
			 onCompletion:(RequestCompletionBLock)block
{
	BSAFHTTPSessionManager *_manager = [self getSessionManagerWithRequestSerializer:requestSerializer
															  andResponseSerializer:responseSerializer];
	NSURL *methodURL = [self urlWithMethod:method];
	
	switch (HTTPmethod) {
		case HTTPMethodGET:
		{
			[_manager GET:[methodURL absoluteString]
			   parameters:parameters
		 headerParameters:headers
				 response:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
			 
					 block(responseObject, error);
				 }];
		}
			break;
		case HTTPMethodPOST:
		{
			[_manager POST:[methodURL absoluteString]
				parameters:parameters
		  headerParameters:headers
				  response:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
					  
					  block(responseObject, error);
				  }];
		}
			break;
		case HTTPMethodPUT:
		{
			[_manager PUT:[methodURL absoluteString]
			   parameters:parameters
		 headerParameters:headers
				 response:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {

					 block(responseObject, error);
				 }];
		}
			break;
		case HTTPMethodDELETE:
		{
			[_manager DELETE:[methodURL absoluteString]
				  parameters:parameters
			headerParameters:headers
					response:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
						
						block(responseObject, error);
					}];
		}
			break;
		default:
			break;
	}
}

@end

