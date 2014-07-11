//
//  BSAPWalletRequest.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/11/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPWalletRequest : BSSerializableObject

@property (nonatomic, strong) NSString *since_id;
@property (nonatomic, strong) NSString *max_id;
@property (nonatomic, strong) NSNumber *count;

@end
