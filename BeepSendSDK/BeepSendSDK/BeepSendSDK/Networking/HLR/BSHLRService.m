//
//  BSHLRService.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSHLRService.h"

#import "BSAPIConfiguration.h"

#import "BSAPHLR.h"
#import "BSAPHLRValidateResponse.h"

@implementation BSHLRService

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

- (void)doImmediateHLRForNumber:(NSString *)number
				 withConnection:(BSConnection *)connection
			withCompletionBlock:(void(^)(BSHLR *hlr, id error))block
{
	NSString *method = [BSAPIConfiguration hlrForNumber:number];
	NSDictionary *params = connection ? @{ @"connection" : connection.objectID } : @{};
	
	[super executeGETForMethod:method
				withParameters:params
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  BSHLR *hlr = [[BSAPHLR classFromDict:response] convertToModel];
						  
						  block(hlr, error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)validateHLRForNumber:(NSString *)number
			  withConnection:(BSConnection *)connection
		 withCompletionBlock:(void(^)(BSHLR *response, id error))block
{
	NSString *method = [BSAPIConfiguration validateHLR];
	
	NSDictionary *params = connection ? @{ @"msisdn" : number , @"connection" : connection.objectID } : @{ @"msisdn" : number };
	
	[super executePOSTForMethod:method
				 withParameters:params
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  block([[BSAPHLRValidateResponse classFromDict:response] convertToModel], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

@end
