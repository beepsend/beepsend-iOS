//
//  BSHLRView.h
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BSTextFieldCustomTextInset.h"

@interface BSHLRView : UIView

@property (nonatomic, strong) BSTextFieldCustomTextInset *textFieldNumberToCheck;
@property (nonatomic, strong) UIButton *buttonPerformHLR;
@property (nonatomic, strong) UIButton *buttonValidateHLR;

@property (nonatomic, strong) UIButton *buttonBack;

@property (nonatomic, weak) UIButton *buttonDone;

@end
