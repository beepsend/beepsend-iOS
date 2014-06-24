//
//  BSAPUserType.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@interface BSAPUserType : BSSerializableObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;

@end
