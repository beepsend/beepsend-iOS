//
//  BSHLRService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSHLRModel.h"
#import "BSConnectionModel.h"

@interface BSHLRService : BSBaseService

/*
 
	Method might require longer time for execution
 
 */
- (void)doImmediateHLRForNumber:(NSString *)number
				 withConnection:(BSConnectionModel *)connection
			withCompletionBlock:(void(^)(BSHLRModel *hlr, id error))block;

- (void)validateHLRForNumber:(NSString *)number
			  withConnection:(BSConnectionModel *)connection
		 withCompletionBlock:(void(^)(id response, id error))block;

@end
