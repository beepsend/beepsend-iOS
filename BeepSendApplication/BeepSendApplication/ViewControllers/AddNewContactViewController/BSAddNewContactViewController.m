//
//  BSAddNewContactViewController.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/22/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAddNewContactViewController.h"

#import "BSAddNewContactView.h"

@interface BSAddNewContactViewController ()

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
	
	self.view = addContactView;
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
