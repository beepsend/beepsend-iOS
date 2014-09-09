//
//  BSHLRView.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSHLRView.h"

#import "BSInputAccessoryView.h"

@implementation BSHLRView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		
		////////////////////////////////////////////////////////////////////////
		//Main view
		self.backgroundColor = [UIColor clearColor];
		
		UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:frame
														  byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
																cornerRadii:CGSizeMake(kDefaultButtonCornerRadius, kDefaultButtonCornerRadius)];
		CAShapeLayer *maskLayer = [CAShapeLayer layer];
		maskLayer.frame = frame;
		maskLayer.path = [roundedPath CGPath];
		maskLayer.fillColor = [UIColor darkGrayColor].CGColor;
		maskLayer.lineWidth = kDefaultBorderWidth;
		maskLayer.strokeColor = [[UIColor orangeColor] CGColor];
		
		[self.layer addSublayer:maskLayer];
		
		////////////////////////////////////////////////////////////////////////
		//Setup textField input accessory view
		BSInputAccessoryView *accessoryView = [BSInputAccessoryView inputAccessoryViewWithDoneButton];
		_buttonDone = accessoryView.buttonDone;

		////////////////////////////////////////////////////////////////////////
		//Text field recipient
		_textFieldNumberToCheck = [[BSTextFieldCustomTextInset alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, kViewDefaultBorderInset, frame.size.width - kViewDefaultBorderInset*2, kTextFieldDefaultHeight)];
		_textFieldNumberToCheck.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_textFieldNumberToCheck.backgroundColor = [UIColor whiteColor];
		_textFieldNumberToCheck.textColor = [UIColor blackColor];
		_textFieldNumberToCheck.textAlignment = NSTextAlignmentNatural;
		_textFieldNumberToCheck.keyboardAppearance = UIKeyboardAppearanceDark;
		_textFieldNumberToCheck.keyboardType = UIKeyboardTypeNumberPad;
		_textFieldNumberToCheck.clearButtonMode = UITextFieldViewModeWhileEditing;
		_textFieldNumberToCheck.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@""
																			 attributes:@{
																						  NSForegroundColorAttributeName:[UIColor lightGrayColor],
																						  NSFontAttributeName:[UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultPlaceholderSize]
																						  }];
		
		_textFieldNumberToCheck.inputAccessoryView = accessoryView;
		
		_textFieldNumberToCheck.layer.borderColor = [UIColor orangeColor].CGColor;
		_textFieldNumberToCheck.layer.borderWidth = kDefaultBorderWidth;
		_textFieldNumberToCheck.layer.cornerRadius = kTextFieldDefaultHeight/2.0;
		
		[self addSubview:_textFieldNumberToCheck];
		
		////////////////////////////////////////////////////////////////////////
		//Validate number button
		_buttonValidateHLR = [[UIButton alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_textFieldNumberToCheck.frame) + kSeparatorDefaultSpacing, frame.size.width/2.0 - kViewDefaultBorderInset - kSeparatorDefaultSpacing/2.0, CGRectGetHeight(_textFieldNumberToCheck.frame))];
		_buttonValidateHLR.backgroundColor = [UIColor lightGrayColor];
		_buttonValidateHLR.showsTouchWhenHighlighted = YES;
		_buttonValidateHLR.clipsToBounds = YES;
		[_buttonValidateHLR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_buttonValidateHLR setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
		_buttonValidateHLR.titleLabel.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		
		_buttonValidateHLR.layer.cornerRadius = _textFieldNumberToCheck.layer.cornerRadius;
		_buttonValidateHLR.layer.borderWidth = kDefaultBorderWidth;
		_buttonValidateHLR.layer.borderColor = [UIColor orangeColor].CGColor;
		
		[self addSubview:_buttonValidateHLR];
		
		////////////////////////////////////////////////////////////////////////
		//Check number button
		_buttonPerformHLR = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_buttonValidateHLR.frame) + kSeparatorDefaultSpacing, CGRectGetMinY(_buttonValidateHLR.frame), frame.size.width/2.0 - kViewDefaultBorderInset - kSeparatorDefaultSpacing/2.0, CGRectGetHeight(_textFieldNumberToCheck.frame))];
		_buttonPerformHLR.backgroundColor = [UIColor lightGrayColor];
		_buttonPerformHLR.showsTouchWhenHighlighted = YES;
		_buttonPerformHLR.clipsToBounds = YES;
		[_buttonPerformHLR setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_buttonPerformHLR setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
		_buttonPerformHLR.titleLabel.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		
		_buttonPerformHLR.layer.cornerRadius = _textFieldNumberToCheck.layer.cornerRadius;
		_buttonPerformHLR.layer.borderWidth = kDefaultBorderWidth;
		_buttonPerformHLR.layer.borderColor = [UIColor orangeColor].CGColor;
		
		[self addSubview:_buttonPerformHLR];
		
		////////////////////////////////////////////////////////////////////////
		
		_buttonBack = [[UIButton alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, frame.size.height - kViewDefaultBorderInset - kTextFieldDefaultHeight, frame.size.width - 2*kViewDefaultBorderInset, kTextFieldDefaultHeight)];
		_buttonBack.backgroundColor = [UIColor lightGrayColor];
		_buttonBack.showsTouchWhenHighlighted = YES;
		_buttonBack.clipsToBounds = YES;
		_buttonBack.titleLabel.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_buttonBack.titleLabel.textAlignment = NSTextAlignmentCenter;
		[_buttonBack setTitle:NSLocalizedString(@"Back", @"") forState:UIControlStateNormal];
		[_buttonBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_buttonBack setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
		
		_buttonBack.layer.cornerRadius = _textFieldNumberToCheck.layer.cornerRadius;
		_buttonBack.layer.borderWidth = kDefaultBorderWidth;
		_buttonBack.layer.borderColor = [UIColor orangeColor].CGColor;
		
		[self addSubview:_buttonBack];
		
    }
    return self;
}

@end
