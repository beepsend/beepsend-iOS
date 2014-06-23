//
//  BSPricelistService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/20/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSConnectionModel.h"

@interface BSPricelistService : BSBaseService

- (void)getCurrentPricelistsForConnection:(BSConnectionModel *)connection withCompletionBlock:(void(^)(id result, id error))block;
- (void)getCurrentPricelistsForMeWithCompletionBlock:(void(^)(id result, id error))block;

- (void)getPricelistsForConnection:(BSConnectionModel *)connection withCompletionBlock:(void(^)(id result, id error))block;
- (void)getPriceListsForMeWithCompletionBlock:(void(^)(id result, id error))block;

@end
