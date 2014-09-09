//
//  BSAPError.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPError : BSSerializableObject

@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, strong) NSString *description;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;
+ (NSArray *)arrayOfModelsFromArrayOfObjects:(NSArray *)array;

@end
