//
//  ViewController.m
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/16.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

#import "ViewController.h"
#import "TabBarLogic.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)customTabBarController:(id)sender {
    TabBarLogic *tabBarLogic = [[TabBarLogic alloc] init];
    [tabBarLogic presentTabBarFromViewController:self];
}

@end
