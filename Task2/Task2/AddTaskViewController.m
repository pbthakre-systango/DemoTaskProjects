//
//  AddTaskViewController.m
//  Task2
//
//  Created by NR on 27/08/2015.
//  Copyright (c) 2015 Systango. All rights reserved.
//

#import "AddTaskViewController.h"
#import "Utility.h"
#import "DBOperation.h"

@implementation AddTaskViewController
@synthesize  userId;
@synthesize textTaskName,textTaskDetail;
@synthesize addTaskBtn,taskCount;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)addTaskToDB:(id)sender{
    
    if ([self.textTaskDetail.text length]>0 && [self.textTaskName.text length]>0 )
    {
        DBOperation *dbAction=[[DBOperation alloc]init];
        TaskDetail *taskDetail=[[TaskDetail alloc]init];
        taskDetail.taskName=self.textTaskName.text;
        taskDetail.taskDetail=self.textTaskDetail.text;
        taskDetail.userId=self.userId;
        taskDetail.taskId=[NSString stringWithFormat:@"%@_Task_%d",taskDetail.userId,self.taskCount+1];
        [dbAction saveTaskDetailInDB:taskDetail];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:EnterTaskDetailMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }

}
@end
