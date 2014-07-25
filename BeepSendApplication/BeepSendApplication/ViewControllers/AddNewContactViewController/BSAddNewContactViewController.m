//
//  BSAddNewContactViewController.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/22/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAddNewContactViewController.h"

#import "BSAddNewContactView.h"

#import "BSGroupSelectionViewController.h"

@interface BSAddNewContactViewController () <UITextFieldDelegate, BSGroupSelectionDelegate>

@property (nonatomic, strong) BSGroup *selectedGroup;

@property (nonatomic, weak) UIScrollView *scrollViewContainer;

@property (nonatomic, weak) UITextField *textFieldFirstName;
@property (nonatomic, weak) UITextField *textFieldLastName;
@property (nonatomic, weak) UITextField *textFieldPhoneNumber;
@property (nonatomic, weak) UIButton *buttonAddToGroup;

@property (nonatomic, weak) UIButton *buttonCancel;
@property (nonatomic, weak) UIButton *buttonAdd;

@property (nonatomic, weak) UIButton *buttonDone;

- (void)setupTitles;

- (void)buttonAddToGroupClicked:(UIButton *)sender;

- (void)buttonCancelClicked:(UIButton *)sender;
- (void)buttonAddClicked:(UIButton *)sender;

- (void)buttonDoneClicked:(UIButton *)sender;

@end

@implementation BSAddNewContactViewController

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
	BSAddNewContactView *addContactView = [[BSAddNewContactView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	
	_scrollViewContainer = addContactView.scrollViewContainer;
	
	_textFieldFirstName = addContactView.textFieldFirstName;
	_textFieldFirstName.delegate = self;
	
	_textFieldLastName = addContactView.textFieldLastName;
	_textFieldLastName.delegate = self;
	
	_textFieldPhoneNumber = addContactView.textFieldPhoneNumber;
	_textFieldPhoneNumber.delegate = self;
	
	_buttonAddToGroup = addContactView.buttonAddToGroup;
	[_buttonAddToGroup addTarget:self action:@selector(buttonAddToGroupClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	_buttonCancel = addContactView.buttonCancel;
	[_buttonCancel addTarget:self action:@selector(buttonCancelClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	_buttonAdd = addContactView.buttonAdd;
	[_buttonAdd addTarget:self action:@selector(buttonAddClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	_buttonDone = addContactView.buttonDone;
	[_buttonDone addTarget:self action:@selector(buttonDoneClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	self.view = addContactView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self setupTitles];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)setupTitles
{
	_textFieldFirstName.placeholder = NSLocalizedString(@"First name", @"");
	_textFieldLastName.placeholder = NSLocalizedString(@"Last name", @"");
	_textFieldPhoneNumber.placeholder = NSLocalizedString(@"Phone number", @"");
	
	[_buttonAddToGroup setTitle:NSLocalizedString(@"Add to group", @"") forState:UIControlStateNormal];
	
	[_buttonCancel setTitle:NSLocalizedString(@"Cancel", @"") forState:UIControlStateNormal];
	[_buttonAdd setTitle:NSLocalizedString(@"Add", @"") forState:UIControlStateNormal];
	
	[_buttonDone setTitle:NSLocalizedString(@"Done", @"") forState:UIControlStateNormal];
}

- (void)buttonAddToGroupClicked:(UIButton *)sender
{
	_selectedGroup = nil;
	[_buttonAddToGroup setTitle:NSLocalizedString(@"Add to group", @"") forState:UIControlStateNormal];
	
	BSGroupSelectionViewController *groupselectionVC = [[BSGroupSelectionViewController alloc] init];
	groupselectionVC.delegate = self;
	[self presentViewController:groupselectionVC animated:YES completion:^{
		
	}];
}

- (void)buttonCancelClicked:(UIButton *)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)buttonAddClicked:(UIButton *)sender
{
	if ([Helper isNilOrEmpty:_textFieldPhoneNumber.text]) {
		return; // You need to enter phone number
	}
	
	BSContact *contact = [[BSContact alloc] initContactWithPhoneNumber:_textFieldPhoneNumber.text
															 firstName:_textFieldFirstName.text
															  lastName:_textFieldLastName.text
																 group:_selectedGroup];
	[contact saveContact];
	
}

- (void)buttonDoneClicked:(UIButton *)sender
{
	if ([_textFieldFirstName isFirstResponder]) {
		[_textFieldFirstName resignFirstResponder];
	}
	else if ([_textFieldLastName isFirstResponder]) {
		[_textFieldLastName resignFirstResponder];
	}
	else if ([_textFieldPhoneNumber isFirstResponder]) {
		[_textFieldPhoneNumber resignFirstResponder];
	}
}

#pragma mark - BSGroupSelection delegate

-(void)groupSelectionViewController:(BSGroupSelectionViewController *)groupSelectionVC didSelectGroup:(BSGroup *)group
{
	_selectedGroup = group;
	
	[_buttonAddToGroup setTitle:[NSString stringWithFormat:NSLocalizedString(@"Add to group (%@)", @""), _selectedGroup.name] forState:UIControlStateNormal];
}

@end
