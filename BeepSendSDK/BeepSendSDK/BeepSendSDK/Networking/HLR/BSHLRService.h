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

@interface BSHLRService : BSBaseService

/*
 
	Method might require longer time for execution
 
 */
- (void)doImmediateHLRForNumber:(NSString *)number
				 withConnection:(BSConnection *)connection
			withCompletionBlock:(void(^)(BSHLR *hlr, id error))block;

- (void)validateHLRForNumber:(NSString *)number
			  withConnection:(BSConnection *)connection
		 withCompletionBlock:(void(^)(BSHLR *response, id error))block;

@end
