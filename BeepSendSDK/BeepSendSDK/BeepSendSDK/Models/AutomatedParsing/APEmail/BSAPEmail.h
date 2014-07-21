//
//  BSAPEmail.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

@class BSEmail;

@interface BSAPEmail : BSSerializableObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *email;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;
+ (NSArray *)arrayOfModelsFromArrayOfObjects:(NSArray *)array;

+ (BSAPEmail *)convertFromEmailModel:(BSEmail *)emailModel;

@end
