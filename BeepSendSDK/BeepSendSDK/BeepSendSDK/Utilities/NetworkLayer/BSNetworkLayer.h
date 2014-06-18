//
//  BSGeneralService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/13/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

/*
 
 BSNetworkLayer class is added to act like layer between 3rd party class (AFNetworking) 
 and service communication classes. 
 This is neccessary for easier switching between network communication frameworks.
 
 */

#import <Foundation/Foundation.h>

/*
 Serializers available in AFNetworking 
 */
typedef enum {
	RequestSerializerHTTP,
	RequestSerializerJSON,
	RequestSerializerPropertyList
} RequestSerializer;

typedef enum {
	ResponseSerializerHTTP,
	ResponseSerializerJSON,
	ResponseSerializerXMLParser,
	ResponseSerializerPropertyList,
	ResponseSerializerImage,
	ResponseSerializerCompound
} ResponseSerializer;

typedef enum {
	HTTPMethodGET,
	HTTPMethodPOST,
	HTTPMethodDELETE,
	HTTPMethodPUT
} HTTPMethod;

typedef void(^RequestCompletionBLock)(id response, id error);

@interface BSNetworkLayer : NSObject

/*
 Accepts URL as parameter
 */
- (BSNetworkLayer *)initWithBaseURL:(NSURL *)baseURL;

/*
 Same as - (id)initWithBaseURL:(NSURL *)baseURL; except that accepts string instead of url
 */
- (BSNetworkLayer *)initWithBaseStringURL:(NSString *)baseURL;

/*
 Class methods for initialization
 */
+ (BSNetworkLayer *)networkLayerWithBaseURL:(NSURL *)baseURL;
+ (BSNetworkLayer *)networkLayerWithBaseStringURL:(NSString *)baseURL;

/*
 Request method
 */
- (void)executeHTTPMethod:(HTTPMethod)HTTPmethod
	withRequestSerializer:(RequestSerializer)requestSerializer
	andResponseSerializer:(ResponseSerializer)responseSerializer
				forMethod:(NSString *)method
		   withParameters:(NSDictionary *)parameters
		additionalHeaders:(NSDictionary *)headers
			 onCompletion:(RequestCompletionBLock)block;

@end
