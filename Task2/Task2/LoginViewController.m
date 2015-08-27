//
//  LoginViewController.m
//  Task2
//
//  Created by NR on 25/08/2015.
//  Copyright (c) 2015 Systango. All rights reserved.
//

#import "LoginViewController.h"
#import "TaskListViewController.h"
#import "DBOperation.h"
#import "Utility.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden=NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

// method validate  all fields and sign in i.e after doing password check

-(IBAction)signInClicked:(id)sender
{
    DBOperation *dbObject=[[DBOperation alloc]init];

    if ([self.txtUserId.text length]>0 && [self.txtPassword.text length]>0 )
    {
        
        if([dbObject isUserIdExist:self.txtUserId.text]){
            
            UserDetail * userDetail=[dbObject fetchUserDetailWithUserId:self.txtUserId.text];
            if ([userDetail.password isEqualToString: self.txtPassword.text])
            {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                            @"Main" bundle:[NSBundle mainBundle]];
                TaskListViewController *tasklistVC =
                [storyboard instantiateViewControllerWithIdentifier:@"TaskListViewController"];
                tasklistVC.userId=userDetail.userId;
                [self.navigationController pushViewController:tasklistVC animated:YES];
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:IncorrectPasswordMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
            
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:UserIdNotExist delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }
else{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:MadatoryFieldsMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
   
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
