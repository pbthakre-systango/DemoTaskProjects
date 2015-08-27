//
//  TaskDetailViewController.m
//  Task2
//
//  Created by NR on 25/08/2015.
//  Copyright (c) 2015 Systango. All rights reserved.
//

#import "TaskDetailViewController.h"

@implementation TaskDetailViewController
@synthesize taskDetail;
@synthesize lblTaskName,lblTaskDetail;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.lblTaskName.text=self.taskDetail.taskName;
    self.lblTaskDetail.text=self.taskDetail.taskDetail;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
