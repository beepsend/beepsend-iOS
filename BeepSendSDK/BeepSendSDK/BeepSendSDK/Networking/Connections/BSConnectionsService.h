//
//  ConnectionsService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/13/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

@interface BSConnectionsService : BSBaseService

- (void)getAllAvailableConnectsionOnCompletion:(void(^)(id response, id error))block;
- (void)getConnectionOnCompletion:(void(^)(id response, id error))block;

@end
