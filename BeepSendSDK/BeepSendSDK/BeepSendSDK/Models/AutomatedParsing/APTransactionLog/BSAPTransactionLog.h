//
//  BSAPTransactionLog.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/7/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPTransactionLog : BSSerializableObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong, getter = the_new_balance) NSNumber *new_balance;
@property (nonatomic, strong) NSNumber *change;
@property (nonatomic, strong) NSString *comment;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;
+ (NSArray *)arrayOfModelsFromArrayOfObjects:(NSArray *)array;

@end
