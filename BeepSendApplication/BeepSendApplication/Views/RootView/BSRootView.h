//
//  BSRootView.h
//  BeepSendApplication
//
//  Created by Vladica Pesic on 6/11/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BSTextFieldCustomTextInset.h"

@interface BSRootView : UIView

@property (nonatomic, strong) UIScrollView *scrollViewContainer;

@property (nonatomic, strong) BSTextFieldCustomTextInset *textFieldFrom;
@property (nonatomic, strong) BSTextFieldCustomTextInset *textFieldTo;
@property (nonatomic, strong) UITextView *textViewMessageBox;
@property (nonatomic, strong) UIButton *buttonCheckDestinationNumber;
@property (nonatomic, strong) UIButton *buttonSendMessage;

@property (nonatomic, weak) UIButton *buttonDone;

@end
