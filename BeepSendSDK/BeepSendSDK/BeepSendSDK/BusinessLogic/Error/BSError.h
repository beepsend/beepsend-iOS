//
//  BSError.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/24/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSError : BSGeneralModel

/** Error code
 */
@property (nonatomic, strong, readonly) NSNumber *code;

/** Error description
 */
@property (nonatomic, strong, readonly) NSString *errorDescription;

/** Init Error with code and description
 
 @param code - Code
 @param desc - Description
 
 @return Returns Error object
 */
- (BSError *)initWithCode:(NSNumber *)code andDescription:(NSString *)desc;

@end
