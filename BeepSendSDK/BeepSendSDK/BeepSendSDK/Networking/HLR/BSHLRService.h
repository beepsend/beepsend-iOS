//
//  BSHLRService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSConnectionModel.h"

@interface BSHLRService : BSBaseService

- (void)doImmediateHLRForNumber:(NSString *)number
				 withConnection:(BSConnectionModel *)connection
			withCompletionBlock:(void(^)(id response, id error))block;

@end
