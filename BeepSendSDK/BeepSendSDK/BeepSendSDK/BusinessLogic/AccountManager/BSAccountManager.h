//
//  BSAccountManagerModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

/*!
 @class BSAccountManager
 @discussion Used to identify customers account manager
 */
@interface BSAccountManager : BSGeneralModel

/*! Name of customer account manager.
 */
@property (nonatomic, strong, readonly) NSString *name;

/*! Email of customer account manager.
 */
@property (nonatomic, strong, readonly) NSString *email;

/*! Creates account manager with name and email
 
 @param accountManagerName - Account manager name
 @param accountManagerEmail - Account manager email
 
 @return - Returns BSAccountManager object
 */
- (BSAccountManager *)initAccountManagerWithName:(NSString *)accountManagerName
										andEmail:(NSString *)accountManagerEmail;

@end
