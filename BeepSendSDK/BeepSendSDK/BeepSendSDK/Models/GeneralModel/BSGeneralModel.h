//
//  BSGeneralModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSGeneralModel : NSObject

@property (nonatomic, strong) NSNumber *objectID;
@property (nonatomic, strong) NSString *title;
 
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
