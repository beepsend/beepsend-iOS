//
//  BSInputAccessoryView.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 6/11/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSInputAccessoryView.h"

#import <QuartzCore/QuartzCore.h>

@implementation BSInputAccessoryView

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		
		self.backgroundColor = [UIColor colorWithWhite:0.90 alpha:0.70];
		
		_buttonDone = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		_buttonDone.frame = CGRectMake(frame.size.width - kViewDefaultBorderInset - kDoneButtonWidth, (kToolbarDefaultHeight - kDoneButtonHeight) / 2.0, kDoneButtonWidth, kDoneButtonHeight);
		_buttonDone.backgroundColor = [UIColor colorWithRed:121.0/255.0 green:196.0/255.0 blue:70.0/255.0 alpha:1];
		_buttonDone.showsTouchWhenHighlighted = YES;
		_buttonDone.clipsToBounds = YES;
		[_buttonDone setTitle:NSLocalizedString(@"Done", @"") forState:UIControlStateNormal];
		[_buttonDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[_buttonDone setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
		_buttonDone.titleLabel.font = [UIFont systemFontOfSize:12.0];
		
		_buttonDone.layer.cornerRadius = kDefaultButtonCornerRadius;
		_buttonDone.layer.borderWidth = kDefaultBorderWidth;
		_buttonDone.layer.borderColor = [UIColor darkGrayColor].CGColor;
		
		[self addSubview:_buttonDone];
		
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	CGColorRef startColor = [UIColor darkGrayColor].CGColor;
	CGColorRef endColor = [UIColor orangeColor].CGColor;
	
	[Helper drawLinearGradientWithContext:ctx
									 inRect:rect
								 startColor:startColor
								   endColor:endColor];
}

#pragma mark - Public methods

+ (BSInputAccessoryView *)inputAccessoryViewWithDoneButton {
	return [[BSInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kToolbarDefaultHeight)];
}

@end
