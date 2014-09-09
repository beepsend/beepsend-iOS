//
//  BSAddNewContactView.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/22/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAddNewContactView.h"

#import "BSInputAccessoryView.h"

@implementation BSAddNewContactView

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
		//Scroll view
		_scrollViewContainer = [[UIScrollView alloc] initWithFrame:frame];
		_scrollViewContainer.backgroundColor = [UIColor clearColor];
		_scrollViewContainer.contentSize = frame.size;
		_scrollViewContainer.clipsToBounds = YES;
		
		[self addSubview:_scrollViewContainer];
		
		////////////////////////////////////////////////////////////////////////
		//Text field first name
		_textFieldFirstName = [[BSTextFieldCustomTextInset alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, kViewDefaultBorderInset, frame.size.width - kViewDefaultBorderInset*2, kTextFieldDefaultHeight)];
		_textFieldFirstName.backgroundColor = [UIColor whiteColor];
		_textFieldFirstName.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_textFieldFirstName.textColor = [UIColor blackColor];
		_textFieldFirstName.textAlignment = NSTextAlignmentNatural;
		_textFieldFirstName.keyboardAppearance = UIKeyboardAppearanceDark;
		_textFieldFirstName.keyboardType = UIKeyboardTypeAlphabet;
		_textFieldFirstName.returnKeyType = UIReturnKeyNext;
		_textFieldFirstName.clearButtonMode = UITextFieldViewModeWhileEditing;
		_textFieldFirstName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@""
																			   attributes:@{
																							NSForegroundColorAttributeName:[UIColor lightGrayColor],
																							NSFontAttributeName:[UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultPlaceholderSize]
																							}];
		
		_textFieldFirstName.inputAccessoryView = accessoryView;
		
		_textFieldFirstName.layer.borderColor = [UIColor orangeColor].CGColor;
		_textFieldFirstName.layer.borderWidth = kDefaultBorderWidth;
		_textFieldFirstName.layer.cornerRadius = kTextFieldDefaultHeight/2.0;
		
		[_scrollViewContainer addSubview:_textFieldFirstName];
		
		////////////////////////////////////////////////////////////////////////
		//Text field last name
		_textFieldLastName = [[BSTextFieldCustomTextInset alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_textFieldFirstName.frame) + kSeparatorDefaultSpacing, frame.size.width - kViewDefaultBorderInset*2, kTextFieldDefaultHeight)];
		_textFieldLastName.backgroundColor = [UIColor whiteColor];
		_textFieldLastName.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_textFieldLastName.textColor = [UIColor blackColor];
		_textFieldLastName.textAlignment = NSTextAlignmentNatural;
		_textFieldLastName.keyboardAppearance = UIKeyboardAppearanceDark;
		_textFieldLastName.keyboardType = UIKeyboardTypeAlphabet;
		_textFieldLastName.returnKeyType = UIReturnKeyNext;
		_textFieldLastName.clearButtonMode = UITextFieldViewModeWhileEditing;
		_textFieldLastName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@""
																					attributes:@{
																								 NSForegroundColorAttributeName:[UIColor lightGrayColor],
																								 NSFontAttributeName:[UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultPlaceholderSize]
																								 }];
		
		_textFieldLastName.inputAccessoryView = accessoryView;
		
		_textFieldLastName.layer.borderColor = [UIColor orangeColor].CGColor;
		_textFieldLastName.layer.borderWidth = kDefaultBorderWidth;
		_textFieldLastName.layer.cornerRadius = kTextFieldDefaultHeight/2.0;
		
		[_scrollViewContainer addSubview:_textFieldLastName];
		
		////////////////////////////////////////////////////////////////////////
		//Text field phone number
		_textFieldPhoneNumber = [[BSTextFieldCustomTextInset alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_textFieldLastName.frame) + kSeparatorDefaultSpacing, frame.size.width - kViewDefaultBorderInset*2, kTextFieldDefaultHeight)];
		_textFieldPhoneNumber.backgroundColor = [UIColor whiteColor];
		_textFieldPhoneNumber.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_textFieldPhoneNumber.textColor = [UIColor blackColor];
		_textFieldPhoneNumber.textAlignment = NSTextAlignmentNatural;
		_textFieldPhoneNumber.keyboardAppearance = UIKeyboardAppearanceDark;
		_textFieldPhoneNumber.keyboardType = UIKeyboardTypeAlphabet;
		_textFieldPhoneNumber.returnKeyType = UIReturnKeyDone;
		_textFieldPhoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
		_textFieldPhoneNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@""
																				   attributes:@{
																								NSForegroundColorAttributeName:[UIColor lightGrayColor],
																								NSFontAttributeName:[UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultPlaceholderSize]
																								}];
		
		_textFieldPhoneNumber.inputAccessoryView = accessoryView;
		
		_textFieldPhoneNumber.layer.borderColor = [UIColor orangeColor].CGColor;
		_textFieldPhoneNumber.layer.borderWidth = kDefaultBorderWidth;
		_textFieldPhoneNumber.layer.cornerRadius = kTextFieldDefaultHeight/2.0;
		
		[_scrollViewContainer addSubview:_textFieldPhoneNumber];
		
		////////////////////////////////////////////////////////////////////////
		//Button add to group
		_buttonAddToGroup = [[UIButton alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_textFieldPhoneNumber.frame) + kSeparatorDefaultSpacing, frame.size.width - kViewDefaultBorderInset*2, kTextFieldDefaultHeight)];
		_buttonAddToGroup.titleLabel.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_buttonAddToGroup.titleLabel.textAlignment = NSTextAlignmentCenter;
		_buttonAddToGroup.backgroundColor = [UIColor lightGrayColor];
		_buttonAddToGroup.showsTouchWhenHighlighted = YES;
		_buttonAddToGroup.clipsToBounds = YES;
		
		[_buttonAddToGroup setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_buttonAddToGroup setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
		
		_buttonAddToGroup.layer.borderColor = [UIColor orangeColor].CGColor;
		_buttonAddToGroup.layer.borderWidth = kDefaultBorderWidth;
		_buttonAddToGroup.layer.cornerRadius = kTextFieldDefaultHeight/2.0;
		
		[_scrollViewContainer addSubview:_buttonAddToGroup];
		
		////////////////////////////////////////////////////////////////////////
		//Cancel button
		_buttonCancel = [[UIButton alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, frame.size.height - kViewDefaultBorderInset - kTextFieldDefaultHeight, frame.size.width/2.0 - kViewDefaultBorderInset*2, kTextFieldDefaultHeight)];
		_buttonCancel.backgroundColor = [UIColor lightGrayColor];
		_buttonCancel.showsTouchWhenHighlighted = YES;
		_buttonCancel.clipsToBounds = YES;
		[_buttonCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_buttonCancel setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
		_buttonCancel.titleLabel.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		
		_buttonCancel.layer.cornerRadius = kTextFieldDefaultHeight/2.0;
		_buttonCancel.layer.borderWidth = kDefaultBorderWidth;
		_buttonCancel.layer.borderColor = [UIColor orangeColor].CGColor;
		
		[_scrollViewContainer addSubview:_buttonCancel];
		
		////////////////////////////////////////////////////////////////////////
		//Add button
		_buttonAdd = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width/2.0 + kViewDefaultBorderInset, CGRectGetMinY(_buttonCancel.frame), frame.size.width/2.0 - kViewDefaultBorderInset*2, kTextFieldDefaultHeight)];
		_buttonAdd.backgroundColor = [UIColor lightGrayColor];
		_buttonAdd.showsTouchWhenHighlighted = YES;
		_buttonAdd.clipsToBounds = YES;
		[_buttonAdd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_buttonAdd setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
		_buttonAdd.titleLabel.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		
		_buttonAdd.layer.cornerRadius = kTextFieldDefaultHeight/2.0;
		_buttonAdd.layer.borderWidth = kDefaultBorderWidth;
		_buttonAdd.layer.borderColor = [UIColor orangeColor].CGColor;
		
		[_scrollViewContainer addSubview:_buttonAdd];
		
    }
    return self;
}

@end
