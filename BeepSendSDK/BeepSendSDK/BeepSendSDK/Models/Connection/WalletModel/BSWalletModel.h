//
//  BSWalletModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSWalletModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *walletName;
@property (nonatomic, strong, readonly) NSNumber *walletBalance;

- (BSWalletModel *)initWalletWithID:(NSString *)wID
							   name:(NSString *)wName
							balance:(NSNumber *)wBalance;

@end
