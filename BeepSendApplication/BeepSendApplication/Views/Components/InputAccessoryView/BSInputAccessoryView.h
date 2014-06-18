//
//  BSInputAccessoryView.h
//  BeepSendApplication
//
//  Created by Vladica Pesic on 6/11/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSInputAccessoryView : UIView

@property (nonatomic, strong) UIButton *buttonDone;

+ (BSInputAccessoryView *)inputAccessoryViewWithDoneButton;

@end
