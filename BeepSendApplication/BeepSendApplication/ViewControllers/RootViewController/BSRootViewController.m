//
//  BSRootViewController.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 6/11/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSRootViewController.h"

#import "BSRootView.h"

#import "BSUserDetailsViewController.h"

@interface BSRootViewController () 

@property (nonatomic, weak) UILabel *labelIntro;
@property (nonatomic, weak) UIButton *buttonEnter;

- (void)setupTitles;

- (void)buttonEnterClicked:(UIButton *)sender;

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
	
	_labelIntro = rootView.labelIntro;
	_buttonEnter = rootView.buttonEnter;
	
	[_buttonEnter addTarget:self action:@selector(buttonEnterClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	self.view = rootView;
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
	_labelIntro.text = NSLocalizedString(@"WELCOME :)\nThis is example application, built to show capabilities of BeepSendSDK and its basic functionalities.", @"");
	[_buttonEnter setTitle:NSLocalizedString(@"Enter application", @"") forState:UIControlStateNormal];
}

- (void)buttonEnterClicked:(UIButton *)sender
{
	BSUserDetailsViewController *userDetailsVC = [[BSUserDetailsViewController alloc] init];
	[self.navigationController pushViewController:userDetailsVC animated:YES];
}

@end
