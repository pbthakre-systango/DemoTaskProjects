//
//  TaskDetailViewController.h
//  Task2
//
//  Created by NR on 25/08/2015.
//  Copyright (c) 2015 Systango. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskDetail.h"

@interface TaskDetailViewController : UIViewController
@property(nonatomic,strong)TaskDetail *taskDetail;
@property(nonatomic,weak)IBOutlet UILabel *lblTaskName,*lblTaskDetail;
@end
