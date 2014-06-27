//
//  BSAPMessage.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

#import "BSAPBatch.h"

#import "BSMessageModel.h"

@interface BSAPMessage : BSSerializableObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) BSAPBatch *batch;
@property (nonatomic, strong) id to;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSArray *errors;
@property (nonatomic, strong) NSArray *groups;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;

- (BSMessageModel *)convertToMessageModel;

@end
