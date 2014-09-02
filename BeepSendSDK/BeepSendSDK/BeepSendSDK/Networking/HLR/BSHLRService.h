//
//  BSHLRService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSHLR.h"
#import "BSConnection.h"
#import "BSError.h"

@interface BSHLRService : BSBaseService

/*
 
	Method might require longer time for execution
 
 */
- (void)doImmediateHLRForNumber:(NSString *)number
				 withConnection:(BSConnection *)connection
			withCompletionBlock:(void(^)(BSHLR *hlr, NSArray *errors))block;

- (void)doBulkHLRForNumbers:(NSArray *)numbers
			 withConnection:(BSConnection *)connection
		withCompletionBlock:(void(^)(NSArray *hlrs, NSArray *errors))block;

- (void)validateHLRForNumber:(NSString *)number
			  withConnection:(BSConnection *)connection
		 withCompletionBlock:(void(^)(BSHLR *response, NSArray *errors))block;

@end
