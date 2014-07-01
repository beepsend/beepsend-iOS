//
//  BSRootViewController.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 6/11/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSRootViewController.h"

#import "BSRootView.h"

//TODO: IMPORT SDK FOR TESTING
#import "BSConnectionsService.h"
#import "BSCustomerService.h"
#import "BSPricelistService.h"
#import "BSSMSService.h"
#import "BSUserService.h"
#import "BSHLRService.h"
#import "BSContactsService.h"
#import "BSGroupsService.h"

@interface BSRootViewController () <UITextFieldDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UITextField *textFieldFrom;
@property (nonatomic, weak) UITextField *textFieldTo;

@property (nonatomic, weak) UITextView *textViewMessageBox;

- (void)setupViewElements;

- (void)buttonDoneClicked;
- (void)buttonCheckClicked;

- (void)keyboardBecameActive:(NSNotification *)notification;
- (void)keyboardBecameInactive:(NSNotification *)notification;

@end

@implementation BSRootViewController

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)loadView
{
	BSRootView *rootView = [[BSRootView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	
	_scrollView = rootView.scrollViewContainer;
	
	_textFieldFrom = rootView.textFieldFrom;
	_textFieldTo = rootView.textFieldTo;
	
	_textViewMessageBox = rootView.textViewMessageBox;
	
	[rootView.buttonCheckDestinationNumber addTarget:self action:@selector(buttonCheckClicked) forControlEvents:UIControlEventTouchUpInside];
	[rootView.buttonDone addTarget:self action:@selector(buttonDoneClicked) forControlEvents:UIControlEventTouchUpInside];
	
	self.view = rootView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self setupViewElements];
	
	//Add keyboard appearance notification
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBecameActive:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBecameInactive:) name:UIKeyboardWillHideNotification object:nil];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Private methods

- (void)setupViewElements
{
	_textFieldFrom.placeholder = NSLocalizedString(@"Who is sending message?", @"");
	_textFieldFrom.delegate = self;
	
	_textFieldTo.placeholder = NSLocalizedString(@"To whom is message sent?", @"");
	_textFieldTo.delegate = self;
	
}

- (void)buttonDoneClicked
{
	if ([_textFieldFrom isFirstResponder]) {
		[_textFieldFrom resignFirstResponder];
	}
	else if ([_textFieldTo isFirstResponder]) {
		[_textFieldTo resignFirstResponder];
	}
	else if ([_textViewMessageBox isFirstResponder]) {
		[_textViewMessageBox resignFirstResponder];
	}
	
	if (![Helper isNilOrEmpty:_textFieldFrom.text] &&
		![Helper isNilOrEmpty:_textFieldTo.text] &&
		![Helper isNilOrEmpty:_textViewMessageBox.text]) {
		
		BSSMSService *sms = [BSSMSService sharedService];
		
		BSMessageRequestModel *message1 = [[BSMessageRequestModel alloc] initWithMessage:_textViewMessageBox.text
																			   receiver:_textFieldTo.text
																				 sender:nil
																				batchID:nil
																			 batchLabel:nil
																			   sendTime:nil
																		   usedEncoding:nil
																			messageType:nil
																				validTo:nil
																			 recieveDLR:nil
																			  forGroups:nil
																		 userDataHeader:nil
																	 dataCodingSettings:nil];
		BSMessageRequestModel *message2 = [[BSMessageRequestModel alloc] initWithMessage:_textViewMessageBox.text
																			   receiver:@[_textFieldTo.text, @"381692101760"]
																				 sender:nil
																				batchID:nil
																			 batchLabel:nil
																			   sendTime:nil
																		   usedEncoding:nil
																			messageType:nil
																				validTo:nil
																			 recieveDLR:nil
																			  forGroups:nil
																		 userDataHeader:nil
																	 dataCodingSettings:nil];
		BSMessageRequestModel *message3 = [[BSMessageRequestModel alloc] initWithMessage:_textViewMessageBox.text
																			   receiver:nil
																				 sender:nil
																				batchID:nil
																			 batchLabel:nil
																			   sendTime:nil
																		   usedEncoding:nil
																			messageType:nil
																				validTo:nil
																			 recieveDLR:nil
																			  forGroups:@[@"13122"]
																		 userDataHeader:nil
																	 dataCodingSettings:nil];
		BSMessageRequestModel *message4 = [[BSMessageRequestModel alloc] initWithMessage:_textViewMessageBox.text
																			   receiver:_textFieldTo.text
																				 sender:nil
																				batchID:nil
																			 batchLabel:nil
																			   sendTime:nil
																		   usedEncoding:nil
																			messageType:nil
																				validTo:nil
																			 recieveDLR:nil
																			  forGroups:nil
																		 userDataHeader:nil
																	 dataCodingSettings:nil];
		
		[sms estimateCostForMessages:@[message1, message2, message3, message4] usingConnection:nil withCompletionBlock:^(NSArray *response, id error) {
			DLog(@"%@", response);
		}];
		
//		[sms sendMessage:message usingConnection:nil withCompletionBlock:^(NSArray *response, id error) {
//			DLog(@"%@", response);
//		}];

//		[sms sendMessage:_textViewMessageBox.text
//					from:_textFieldFrom.text
//					  to:@[@"381643460358"]
//				  groups:@[@"13122"]
//			  withBachID:nil
//		   andBatchLabel:nil
//		 atScheduledTime:nil
//			usedEncoding:nil
//			 messageType:nil
//				validFor:nil
//   recieveDeliveryReport:nil
//	 withCompletionBlock:^(NSArray *response, id error) {
//		  DLog(@"%@, %@", response, error);
//	 }];

	}
}

- (void)buttonCheckClicked {
	
	__block BSConnectionsService *cs = [BSConnectionsService sharedService];
	
	[cs getAllAvailableConnectsionOnCompletion:^(NSArray *connections, id error) {
		for (BSConnectionModel *connection in connections) {
			if (connection.type == BSConnectionTypeHLR) {
				
				BSHLRService *hlrs = [BSHLRService sharedService];
				
				[hlrs doImmediateHLRForNumber:_textFieldTo.text
							   withConnection:connection
						  withCompletionBlock:^(BSHLRModel *hlr, id error) {
				 
							  DLog(@"%@", hlr);
					   }];
			}
		}
	}];
}

- (void)keyboardBecameActive:(NSNotification *)notification
{
	CGRect keyboardFrameEndUser = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
	CGRect scrollViewFrame = _scrollView.frame;
	scrollViewFrame.size.height = keyboardFrameEndUser.origin.y;
	
	[self animateScrollViewFrame:scrollViewFrame
					withDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
			   andAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
}

- (void)keyboardBecameInactive:(NSNotification *)notification
{
	CGRect keyboardFrameEndUser = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
	CGRect scrollViewFrame = _scrollView.frame;
	scrollViewFrame.size.height = keyboardFrameEndUser.origin.y;
	
	[self animateScrollViewFrame:scrollViewFrame
					withDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
			   andAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
}

- (void)animateScrollViewFrame:(CGRect)newFrame withDuration:(CGFloat)duration andAnimationCurve:(NSInteger)animationCurve {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationCurve:animationCurve];
	[UIView setAnimationBeginsFromCurrentState:YES];
	{
		self.view.frame = newFrame;
	}
	[UIView commitAnimations];
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if ([textField isEqual:_textFieldFrom]) {
		[_textFieldTo becomeFirstResponder];
	}
	
	return YES;
}

@end
