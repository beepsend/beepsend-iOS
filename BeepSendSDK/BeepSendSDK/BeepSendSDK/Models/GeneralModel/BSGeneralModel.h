//
//  BSGeneralModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Parent class
 */
@interface BSGeneralModel : NSObject

/** Object ID
 */
@property (nonatomic, strong, readonly) NSString *objectID;

/** Object title
 */
@property (nonatomic, strong, readonly) NSString *title;

/** Is object valid
 */
@property (nonatomic, assign, readonly, getter = isObjectValid) BOOL objectValid;

/** Init General model
 
 @param objectID - Wallet from
 @param title - Wallet to
 
 @return Returns General object
 */
- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title;

@end
