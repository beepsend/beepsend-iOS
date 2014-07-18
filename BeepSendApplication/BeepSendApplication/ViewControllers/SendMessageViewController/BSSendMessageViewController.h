//
//  BSSendMessageViewController.h
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/9/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSConnection;

@interface BSSendMessageViewController : UIViewController

- (BSSendMessageViewController *)initWithConnection:(BSConnection *)connection;

@end
