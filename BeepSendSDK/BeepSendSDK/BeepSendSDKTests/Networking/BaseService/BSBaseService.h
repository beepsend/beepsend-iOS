//
//  BSBaseService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/13/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSBaseService : NSObject

+ (instancetype)sharedService;

- (void)executeGETForMethod:(NSString *)method
			 withParameters:(id)parameters
			   onCompletion:(void(^)(id response, id error))block;

- (void)executePOSTForMethod:(NSString *)method
			  withParameters:(id)parameters
				onCompletion:(void(^)(id response, id error))block;

- (void)executePUTForMethod:(NSString *)method
			 withParameters:(id)parameters
			   onCompletion:(void(^)(id response, id error))block;

- (void)executeDELETEForMethod:(NSString *)method
				withParameters:(NSDictionary *)parameters
				  onCompletion:(void(^)(id response, id error))block;

- (void)executeGETForMethod:(NSString *)method
			 withParameters:(id)parameters
					headers:(NSDictionary *)headers
			   onCompletion:(void(^)(id response, id error))block;

- (void)executePOSTForMethod:(NSString *)method
			  withParameters:(id)parameters
					 headers:(NSDictionary *)headers
				onCompletion:(void(^)(id response, id error))block;

- (void)executePUTForMethod:(NSString *)method
			 withParameters:(id)parameters
					headers:(NSDictionary *)headers
			   onCompletion:(void(^)(id response, id error))block;

- (void)executeDELETEForMethod:(NSString *)method
				withParameters:(id)parameters
					   headers:(NSDictionary *)headers
				  onCompletion:(void(^)(id response, id error))block;

@end
