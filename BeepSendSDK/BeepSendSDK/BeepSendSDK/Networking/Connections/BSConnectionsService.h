//
//  ConnectionsService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/13/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSConnectionModel.h"

@interface BSConnectionsService : BSBaseService

- (void)getAllAvailableConnectsionOnCompletion:(void(^)(NSArray *connections, id error))block;
- (void)getMeConnectionOnCompletion:(void(^)(BSConnectionModel *connection, id error))block;

@end
