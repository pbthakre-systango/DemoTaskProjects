//
//  SignUpViewController.h
//  Task2
//
//  Created by NR on 25/08/2015.
//  Copyright (c) 2015 Systango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property(weak,nonatomic)IBOutlet UITextField *txtUserName,*txtUserId,*txtUserEmail,*txtPassword,*txtconfirmPassword;
@property(weak,nonatomic)IBOutlet UIScrollView *baseScroll;
-(IBAction)signUpClicked:(id)sender;
-(IBAction)signInClicked:(id)sender;
@end
