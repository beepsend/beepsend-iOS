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
	
	
//	__block BSGroupsService *gs = [BSGroupsService sharedService];
	
//	[gs addGroupNamed:@"Friends" withCompletionBlock:^(BSGroupModel *group, id error) {
//		
//		DLog(@"%@", group);
//	}];
	
	/*
	[gs getAllGroupsWithCompletionBlock:^(NSArray *groups, id error) {
		
		DLog(@"%@", groups);
		
		for (BSGroupModel *group in groups) {
			if ([group.name isEqualToString:@"My contact"]) {
				
				[gs deleteGroup:group withCompletionBlock:^(BOOL success, id error) {
					
				}];
				
			}
		}
		
	}];
	*/
	
//	__block BSContactsService *cs = [BSContactsService sharedService];
//	
//	[cs getAllContactsWithCompletionBlock:^(NSArray *contacts, id error) {
//		
//		DLog(@"%@", contacts);
//	}];
	
	/*
	[cs addContacts:@[
					  [[BSContactModel alloc] initContactWithPhoneNumber:@"381643460358"
															   firstName:@"Vladica"
																lastName:@"Pešić"
																 groupID:nil],
					  [[BSContactModel alloc] initContactWithPhoneNumber:@"381692101760"
															   firstName:@"Ivica"
																lastName:@"Pešić"
																 groupID:nil],
					  [[BSContactModel alloc] initContactWithPhoneNumber:@"381653389189"
															   firstName:@"Milan"
																lastName:@"Djokić"
																 groupID:nil],
					  [[BSContactModel alloc] initContactWithPhoneNumber:@"381658899986"
															   firstName:@"Milan"
																lastName:@"Stanojević"
																 groupID:nil],
					  [[BSContactModel alloc] initContactWithPhoneNumber:@"381642551948"
															   firstName:@"Ivan"
																lastName:@"Živković"
																 groupID:nil],
					  [[BSContactModel alloc] initContactWithPhoneNumber:@"381665544300"
															   firstName:@"Vuk"
																lastName:@"Ninić"
																 groupID:nil]
					  ] withCompletionBlock:^(NSArray *contacts, id error) {
						  
		DLog(@"%@", contacts);
	}];
	 */
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
		
		[sms validateSMSForMessage:_textViewMessageBox.text
							sender:_textFieldFrom.text
						  receiver:_textFieldTo.text
			   withCompletionBlock:^(id response, id error) {
				   
				   
				   DLog(@"%@, %@", response, error);
		}];
		/*
		[sms sendMessage:_textViewMessageBox.text 
				  sender:_textFieldFrom.text
				receiver:_textFieldTo.text
		  withCompletion:^(id response, id error) {
				DLog(@"%@, %@", response, error);
		}];
		 */
	}
}

- (void)buttonCheckClicked {
	
	__block BSConnectionsService *cs = [BSConnectionsService sharedService];
		
	
	[cs getAllAvailableConnectsionOnCompletion:^(NSArray *connections, id error) {
		for (BSConnectionModel *connection in connections) {
			if (connection.type == BSConnectionTypeHLR) {
				
				BSHLRService *hlrs = [BSHLRService sharedService];
				
				[hlrs validateHLRForNumber:_textFieldTo.text
							withConnection:connection
					   withCompletionBlock:^(id response, id error) {
						   
						  DLog(@"%@", response);
					   }];
				
				/*
				[hlrs doImmediateHLRForNumber:_textFieldTo.text
							   withConnection:connection
						  withCompletionBlock:^(BSHLRModel *hlr, id error) {
				 
							  DLog(@"%@", hlr);
					   }];
				*/
			}
		}
	}];
	 
	
	/*
	[cs getMeConnectionOnCompletion:^(BSConnectionModel *connection, id error) {
		
		BSUserService *userService = [BSUserService sharedService];
		[userService updateUserWithName:@"Vladica" phone:nil defaultConnection:connection userTypes:nil verifiedTerms:nil withCompletionBlock:^(BSUserModel *user, id error) {
			DLog(@"%@", user);
		}];
		
	}];
	 */

	/*
	BSCustomerService *s = [BSCustomerService sharedService];
	
	[s getCustomerOnCompletion:^(BSCustomerModel *customer, id error) {
		DLog(@"\nCustomer: %@, \nWith error: %@\n", customer, error);
	}];
	 */
}

- (void)keyboardBecameActive:(NSNotification *)notification
{
	DLog(@"%@", notification.userInfo);
	CGRect keyboardFrameEndUser = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
	CGRect scrollViewFrame = _scrollView.frame;
	scrollViewFrame.size.height = keyboardFrameEndUser.origin.y;
	
	[self animateScrollViewFrame:scrollViewFrame
					withDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
			   andAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
}

- (void)keyboardBecameInactive:(NSNotification *)notification
{
	DLog(@"%@", notification.userInfo);
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
