//
//  LoginViewController.h
//  Task2
//
//  Created by NR on 25/08/2015.
//  Copyright (c) 2015 Systango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

-(IBAction)signInClicked:(id)sender;
@property(strong,nonatomic)IBOutlet UITextField *txtPassword,*txtUserId;
@end
