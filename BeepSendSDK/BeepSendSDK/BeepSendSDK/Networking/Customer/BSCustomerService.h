//
//  BSCustomer.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/16/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSBaseService.h"

#import "BSCustomer.h"
#import "BSError.h"

@interface BSCustomerService : BSBaseService

- (void)getCustomerOnCompletion:(void(^)(BSCustomer *customer, NSArray *errors))block;

@end
