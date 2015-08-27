//
//  AddTaskViewController.h
//  Task2
//
//  Created by NR on 27/08/2015.
//  Copyright (c) 2015 Systango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTaskViewController : UIViewController
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,assign)int taskCount;
@property(nonatomic,weak)IBOutlet UITextField * textTaskName;
@property(nonatomic,weak)IBOutlet UITextView * textTaskDetail;
@property(nonatomic,weak)IBOutlet UIButton *addTaskBtn;
-(IBAction)addTaskToDB:(id)sender;
@end
