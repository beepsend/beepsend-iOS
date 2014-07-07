//
//  BSAPTransfer.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/7/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

#import "BSAPWallet.h"

@interface BSAPTransfer : BSSerializableObject

@property (nonatomic, strong) BSAPWallet *source_wallet;
@property (nonatomic, strong) BSAPWallet *target_wallet;
@property (nonatomic, strong) NSNumber *amount;

@end
