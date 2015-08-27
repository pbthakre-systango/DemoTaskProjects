//
//  TaskListViewController.m
//  Task2
//
//  Created by NR on 25/08/2015.
//  Copyright (c) 2015 Systango. All rights reserved.
//

#import "TaskListViewController.h"
#import "AddTaskViewController.h"
#import "TaskDetailViewController.h"
#import "SignUpViewController.h"
#import "DBOperation.h"
#import  "Utility.h"
@interface TaskListViewController ()
@property(nonatomic,strong)NSArray *taskListArray;
@end

@implementation TaskListViewController
@synthesize taskListTable;
@synthesize userId;

-(void)viewWillAppear:(BOOL)animated
{
    DBOperation *dbObject=[[DBOperation alloc]init];
    self.taskListArray=[dbObject fetchAllTaskForUserId:self.userId];
    if (self.taskListArray!=nil && [self.taskListArray count]>0) {
        self.taskListTable.hidden=NO;
        [self.taskListTable reloadData];
        CGRect frame=self.taskListTable.frame;
        self.taskListTable.frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width,[self.taskListArray count]*44);
    }
    
}
-(void)logoutUser
{
    id rootVC = [[[[[UIApplication sharedApplication] keyWindow] subviews] objectAtIndex:0] nextResponder];

    DBOperation *dbOperation=[[DBOperation alloc]init];
    [dbOperation LogOutUserWithId:self.userId];
    if ([rootVC isKindOfClass:[SignUpViewController class]]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                    @"Main" bundle:[NSBundle mainBundle]];
        SignUpViewController *signUpVC =
        [storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
        [self.navigationController pushViewController:signUpVC animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden=NO;
    self.navigationItem.hidesBackButton = YES;
    UIButton *LogoutBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 0, 50, 30)];
    LogoutBtn.titleLabel.text=@"Logout";
    [LogoutBtn setTitle:@"Logout" forState:UIControlStateNormal];
    [LogoutBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:15.0]];
   [LogoutBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    [LogoutBtn addTarget:self action:@selector(logoutUser)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LogoutBarBtn =[[UIBarButtonItem alloc] initWithCustomView:LogoutBtn];
    
   UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTaskItem:)];
    
    self.navigationItem.rightBarButtonItems =[NSArray arrayWithObjects:LogoutBarBtn, addButton, nil];
    DBOperation *dbObject=[[DBOperation alloc]init];
    self.taskListArray=[dbObject fetchAllTaskForUserId:self.userId];
    if (self.taskListArray!=nil && [self.taskListArray count]>0) {
        self.taskListTable.hidden=NO;
        [self.taskListTable reloadData];
        CGRect frame=self.taskListTable.frame;
        self.taskListTable.frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width,[self.taskListArray count]*44);
    }
    else{
        self.taskListTable.hidden=YES;
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:TaskListEmptyMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    }

   
}
// method to navigate to add task view
-(void)addTaskItem:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"Main" bundle:[NSBundle mainBundle]];
    AddTaskViewController *addTaskVC =
    [storyboard instantiateViewControllerWithIdentifier:@"AddTaskViewController"];
    addTaskVC.userId=self.userId;
    addTaskVC.taskCount=(int)[self.taskListArray count];
    [self.navigationController pushViewController:addTaskVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Table view delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.taskListArray!=nil) {
        return [self.taskListArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
                
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    TaskDetail *taskDetail=(TaskDetail *)[self.taskListArray objectAtIndex:indexPath.row];
    cell.textLabel.text = taskDetail.taskName;
    
       return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"Main" bundle:[NSBundle mainBundle]];
    TaskDetailViewController *taskDetailVC =
    [storyboard instantiateViewControllerWithIdentifier:@"TaskDetailViewController"];
     TaskDetail *taskDetail=(TaskDetail *)[self.taskListArray objectAtIndex:indexPath.row];
    taskDetailVC.taskDetail=taskDetail;
    [self.navigationController pushViewController:taskDetailVC animated:YES];
    
    
}
@end
