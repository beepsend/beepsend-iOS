//
//  BSAPConversation.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 9/3/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

#import "BSAPSender.h"

@interface BSAPConversation : BSSerializableObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *to;
@property (nonatomic, strong) BSAPSender *from;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *timestamp;

@property (nonatomic, strong) NSArray *items;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;

@end
