//
//  BSHelper.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 6/11/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (BOOL)isNilOrEmpty:(NSString*)string {
	if (![string isKindOfClass:[NSString class]]) {
		return NO;
	}
	if (string == nil || [string isEqual:[NSNull null]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
		return YES;
	}
	else {
		return NO;
	}
}

+ (void)printAvailableFonts
{
	NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
	NSArray *fontNames;
	NSInteger indFamily, indFont;
	for ( indFamily = 0 ; indFamily < [familyNames count] ; ++indFamily )
	{
		NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
		fontNames = [[NSArray alloc] initWithArray:[UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]]];
		for ( indFont = 0 ; indFont < [fontNames count] ; ++indFont )
		{
			NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
		}
	}
}

+ (void)drawLinearGradientWithContext:(CGContextRef)context inRect:(CGRect)rect startColor:(CGColorRef)startColor endColor:(CGColorRef)endColor
{
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGFloat locations[] = { 0.0, 1.0 };
	
	NSArray *colors = [NSArray arrayWithObjects:(__bridge id)startColor, (__bridge id)endColor, nil];
	
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,
														(__bridge CFArrayRef) colors, locations);
	
	CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
	CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
	
	CGContextSaveGState(context);
	CGContextAddRect(context, rect);
	CGContextClip(context);
	
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	CGContextRestoreGState(context);
	
	CGGradientRelease(gradient);
	CGColorSpaceRelease(colorSpace);
}

@end
