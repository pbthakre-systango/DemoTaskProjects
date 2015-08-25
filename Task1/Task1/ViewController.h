//
//  ViewController.h
//  Task1
//
//  Created by NR on 24/08/2015.
//  Copyright (c) 2015 Systango. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic,strong)IBOutlet UIButton *customerButton,*producerButton;
@property(nonatomic,strong)IBOutlet UILabel *customerCountLbl,* producerCountLbl,*itemCountLbl;
@property(nonatomic,strong) NSMutableArray *customerArray,*producerArray;
@property(nonatomic,assign) int itemCount;
@property(nonatomic,strong)NSTimer * globalTimer;
-(IBAction)increaseCustomerCount:(id)sender;
-(IBAction)increaseProducerCount:(id)sender;
@end

