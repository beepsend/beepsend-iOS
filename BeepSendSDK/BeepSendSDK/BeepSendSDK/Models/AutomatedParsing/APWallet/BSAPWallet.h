//
//  BSAPWallet.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPWallet : BSSerializableObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSNumber *balance;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *notify_limit;
@property (nonatomic, strong) NSArray *connections;
@property (nonatomic, strong) NSArray *users;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;

@end
