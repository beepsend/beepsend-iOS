//
//  BSContactsViewController.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/22/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSContactsViewController.h"

#import "BSContactsView.h"

@interface BSContactsViewController ()

@end

@implementation BSContactsViewController

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
	BSContactsView *contactsView = [[BSContactsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	
	self.view = contactsView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
