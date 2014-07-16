//
//  BSSendMessageViewController.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/9/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSendMessageViewController.h"

#import "BSSendMessageView.h"

//TODO: IMPORT SDK FOR TESTING
#import "BSUser.h"
#import "BSConnection.h"
#import "BSMessage.h"
#import "BSWallet.h"

@interface BSSendMessageViewController () <UITextFieldDelegate>

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

@implementation BSSendMessageViewController

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
	BSSendMessageView *sendMessageView = [[BSSendMessageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	
	_scrollView = sendMessageView.scrollViewContainer;
	
	_textFieldFrom = sendMessageView.textFieldFrom;
	_textFieldTo = sendMessageView.textFieldTo;
	
	_textViewMessageBox = sendMessageView.textViewMessageBox;
	
	[sendMessageView.buttonCheckDestinationNumber addTarget:self action:@selector(buttonCheckClicked) forControlEvents:UIControlEventTouchUpInside];
	[sendMessageView.buttonDone addTarget:self action:@selector(buttonDoneClicked) forControlEvents:UIControlEventTouchUpInside];
	
	self.view = sendMessageView;
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
		
//		BSMessage *message = [BSMessage messageWithBody:[_textViewMessageBox.text stringByAppendingString:@"1"] from:_textFieldFrom.text to:_textFieldTo.text];
//		BSMessage *message1 = [BSMessage messageWithBody:[_textViewMessageBox.text stringByAppendingString:@"2"] from:_textFieldFrom.text to:_textFieldTo.text];
//		BSMessage *message2 = [BSMessage messageWithBody:[_textViewMessageBox.text stringByAppendingString:@"3"] from:_textFieldFrom.text to:_textFieldTo.text];
		
//		BSMessage *flashMessage = [BSMessage flashMessageWithBody:_textViewMessageBox.text from:_textFieldFrom.text to:_textFieldTo.text];
		
//		BSMessage *binaryMessage = [BSMessage binaryMessageWithBody:_textViewMessageBox.text from:_textFieldFrom.text to:_textFieldTo.text];
		
		BSMessage *msg = [[BSMessage alloc] initMessageWithID:@"023360800140542909816482381643460358" andErrors:nil forMessage:nil];
		
		[[[BSUser currentUser] defaultConnection] getDetailsForSMS:msg onCompletion:^(BSLookup *lookup, id error) {
			
		}];
	}
}

- (void)buttonCheckClicked {
	DLog(@"START");
	
	StartCounting;
	
	TICK;
	[[[BSUser currentUser] defaultConnection] getDetailsForMessagesSentTo:@"381643460358" sentFrom:nil usedBatch:nil beforeDate:nil afterDate:nil forNextPage:NO onCompletion:^(NSArray *lookups, id error) {
		DLog(@"%@", lookups);
		
	}];
	TOCK;
	
	DLog(@"END");
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
