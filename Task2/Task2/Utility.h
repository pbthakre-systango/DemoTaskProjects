//
//  Utility.h
//  Task2
//
//  Created by NR on 26/08/2015.
//  Copyright (c) 2015 Systango. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MadatoryFieldsMessage @"All Fields are Mandatory for Sign Up."
#define ValidEmailIdMessage @"Please Enter a valid email id."
#define PasswordMismatchMessage @"Confirm Password should be same as Password."
#define UserIdExistMessage @"This user id already exist. Please try a different one."
#define UserIdNotExist @"This user id does not exist. Please try a different one."
#define IncorrectPasswordMessage @"This Password is incorrect"
#define TaskListEmptyMessage @"You dont have any task yet. Click on + to add a task"
#define EnterTaskDetailMessage @"Enter task name and detail both"

#define kUserNameKey @"name"
#define kUserIdKey @"userId"
#define kUserEmailIdKey @"emailId"
#define kPasswordKey @"password"

#define kTaskNameKey @"taskName"
#define kTaskDetailKey @"taskDescription"
#define kTaskIdKey @"taskId"

@interface Utility : NSObject

@end
