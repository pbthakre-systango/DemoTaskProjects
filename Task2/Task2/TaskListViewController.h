//
//  TaskListViewController.h
//  Task2
//
//  Created by NR on 25/08/2015.
//  Copyright (c) 2015 Systango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,weak)IBOutlet UITableView*taskListTable;
@end
