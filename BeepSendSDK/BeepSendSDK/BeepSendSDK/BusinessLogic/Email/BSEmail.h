//
//  BSEmailModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSEmail : BSGeneralModel

/** Email id.
 */
@property (nonatomic, strong, readonly) NSString *emailID;

/** Email address.
 */
@property (nonatomic, strong, readonly) NSString *address;

- (BSEmail *)initEmailWithID:(NSString *)eID atAddress:(NSString *)address;
- (BSEmail *)initEmailWithAddress:(NSString *)address;

@end
