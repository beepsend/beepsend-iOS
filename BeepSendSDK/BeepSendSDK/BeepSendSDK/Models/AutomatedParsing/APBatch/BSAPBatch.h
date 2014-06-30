//
//  BSAPBatch.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/26/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPBatch : BSSerializableObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *date_created;
@property (nonatomic, strong) NSString *last_used;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;

@end
