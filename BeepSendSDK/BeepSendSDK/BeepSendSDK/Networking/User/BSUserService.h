//
//  BSUserService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSUserModel.h"

@interface BSUserService : BSBaseService

- (void)getUserDetailsWithCompletionBlock:(void(^)(BSUserModel *user, id error))block;

@end
