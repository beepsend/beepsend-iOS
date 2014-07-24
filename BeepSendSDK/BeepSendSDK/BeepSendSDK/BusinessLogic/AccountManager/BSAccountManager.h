//
//  BSAccountManagerModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSAccountManager : BSGeneralModel

/** Name of customer account manager.
 */
@property (nonatomic, strong, readonly) NSString *name;

/** Email of customer account manager.
 */
@property (nonatomic, strong, readonly) NSString *email;

/** Init account manager with name and email
 
 @param amName - Account manager name
 @param amEmail - Account manager email
 
 @return Returns Account manager object
 */
-(BSAccountManager *)initAccountManagerWithName:(NSString *)amName
										andEmail:(NSString *)amEmail;

@end
