//
//  BSGeneralModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSGeneralModel : NSObject

@property (nonatomic, strong, readonly) NSString *objectID;
@property (nonatomic, strong, readonly) NSString *title;
 
- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title;

@end
