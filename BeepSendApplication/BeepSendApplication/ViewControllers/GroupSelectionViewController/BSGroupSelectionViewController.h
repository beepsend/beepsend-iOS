//
//  BSGroupSelectionViewController.h
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/22/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSGroupSelectionViewController;
@class BSGroup;

@protocol BSGroupSelectionDelegate <NSObject>

- (void)groupSelectionViewController:(BSGroupSelectionViewController *)groupSelectionVC didSelectGroup:(BSGroup *)group;

@end

@interface BSGroupSelectionViewController : UIViewController

@property (nonatomic, assign) id<BSGroupSelectionDelegate> delegate;

@end
