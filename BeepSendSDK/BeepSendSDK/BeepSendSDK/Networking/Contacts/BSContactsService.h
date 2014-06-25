//
//  ContactsService.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

@interface BSContactsService : BSBaseService

- (void)getAllContactsWithCompletionBlock:(void(^)(id response, id error))block;

@end
