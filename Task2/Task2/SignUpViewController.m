//
//  SignUpViewController.m
//  Task2
//
//  Created by NR on 25/08/2015.
//  Copyright (c) 2015 Systango. All rights reserved.
//

#import "SignUpViewController.h"
#import "DBOperation.h"
#import "TaskListViewController.h"
#import "LoginViewController.h"
#import "Utility.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

@synthesize txtUserName,txtUserId,txtUserEmail,txtPassword,txtconfirmPassword;
@synthesize baseScroll;
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden=YES;
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.baseScroll addGestureRecognizer:singleFingerTap];
    
}


    //The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [[self view] endEditing:YES];

}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

// method validate email string

- (BOOL)validateEmailWithString:(NSString*)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// method validate  all fields and sign up i.e save all data in DB
-(IBAction)signUpClicked:(id)sender
{
    DBOperation *dbObject=[[DBOperation alloc]init];
    if ([self.txtUserName.text length]>0 && [self.txtUserEmail.text length]>0 && [self.txtUserId.text length]>0 && [self.txtPassword.text length]>0 &&[self.txtconfirmPassword.text length]>0)
    {
        if (![self validateEmailWithString:self.txtUserEmail.text]) {
         
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:ValidEmailIdMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            return;
            
        }
        if([dbObject isUserIdExist:self.txtUserId.text]){
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:UserIdExistMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            return;
        }
        if(![self.txtPassword.text isEqualToString:self.txtconfirmPassword.text])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:PasswordMismatchMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            return;
        }
        else
        {
            UserDetail *userdetail=[[UserDetail alloc]init];
            userdetail.userId=self.txtUserId.text;
            userdetail.name=self.txtUserName.text;
            userdetail.emailId=self.txtUserEmail.text;
            userdetail.password=self.txtPassword.text;
            userdetail.isLoggedIn=YES;
            [dbObject saveUserDetailInDB:userdetail];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                        @"Main" bundle:[NSBundle mainBundle]];
            TaskListViewController *tasklistVC =
            [storyboard instantiateViewControllerWithIdentifier:@"TaskListViewController"];
            tasklistVC.userId=userdetail.userId;
            [self.navigationController pushViewController:tasklistVC animated:YES];
            
        }
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:MadatoryFieldsMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}


// method to navigate to sign in screen
-(IBAction)signInClicked:(id)sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"Main" bundle:[NSBundle mainBundle]];
    LoginViewController *loginVC =
    [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginVC animated:YES];

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
