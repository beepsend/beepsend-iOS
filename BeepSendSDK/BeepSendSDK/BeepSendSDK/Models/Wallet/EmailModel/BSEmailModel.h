//
//  BSEmailModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSEmailModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *address;

- (BSEmailModel *)initEmailWithID:(NSString *)eID atAddress:(NSString *)address;
- (BSEmailModel *)initEmailWithAddress:(NSString *)address;

@end
