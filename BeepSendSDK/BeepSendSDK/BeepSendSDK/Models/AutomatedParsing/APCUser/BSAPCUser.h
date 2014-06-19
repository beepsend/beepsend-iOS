//
//  APCUser.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/19/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPCUser : BSSerializableObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *username;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;

@end
