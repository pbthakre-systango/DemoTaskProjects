//
//  ViewController.m
//  Task1
//
//  Created by NR on 24/08/2015.
//  Copyright (c) 2015 Systango. All rights reserved.
//

#define CustomerIDKey @"CustomerId"
#define ProducerIDKey @"ProducerId"

#define TimeElapsedKey @"TimeElapsed"
#define ItemProductionTime 5
#define ItemConsumptionTime 2

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize customerButton,producerButton,customerCountLbl,producerCountLbl,itemCountLbl;
@synthesize customerArray,producerArray;
@synthesize globalTimer,itemCount;

- (void)viewDidLoad {
    [super viewDidLoad];
    customerArray=[[NSMutableArray alloc]init];
    producerArray=[[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Method to handle timer. This method gets invoked after every 1 sec
-(void)handleTimer:(id)sender
{
    for (NSMutableDictionary *dic in self.customerArray)
    {
        int timeElapsed=[[dic valueForKey:TimeElapsedKey ] intValue];
        NSLog(@"time elapsed for %@ =%d",[dic valueForKey:CustomerIDKey],timeElapsed);
        // if time elapsed for consumer is equals to 2, consumer will consume an item and reset time elapsed to 0 else increase time elapsed by 1
        if (timeElapsed<ItemConsumptionTime)
        {
            [dic setValue:[NSNumber numberWithInt:timeElapsed+1] forKey:TimeElapsedKey];

        }
        else{
            if (itemCount>0) {
                itemCount--;
                self.itemCountLbl.text=[NSString stringWithFormat:@"%d",itemCount];
                [dic setValue:[NSNumber numberWithInt:0] forKey:TimeElapsedKey];
                NSLog(@" item consumed by %@",[dic valueForKey:CustomerIDKey]);
            }
        }
    }
    for (NSMutableDictionary *dic in self.producerArray)
    {
        int timeElapsed=[[dic valueForKey:TimeElapsedKey ] intValue];
       
        NSLog(@"time elapsed for %@ =%d",[dic valueForKey:ProducerIDKey],timeElapsed);
        // if time elapsed for producer is equals to 5, producer will produce an item and reset time elapsed to 0 else increase time elapsed by 1

        if (timeElapsed<ItemProductionTime)
        {
            [dic setValue:[NSNumber numberWithInt:timeElapsed+1] forKey:TimeElapsedKey];
            
        }
        else{
                itemCount++;
                self.itemCountLbl.text=[NSString stringWithFormat:@"%d",itemCount];
                [dic setValue:[NSNumber numberWithInt:0] forKey:TimeElapsedKey];
            NSLog(@"item is produced by %@",[dic valueForKey:ProducerIDKey]);

        }
    }
}

// This methos will increase consumer count and if timer is not running it will start a timer
-(IBAction)increaseCustomerCount:(id)sender
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSString *custId=[NSString stringWithFormat:@"Customer_%lu",[self.customerArray count]+1 ];
    [dic setObject:custId forKey:CustomerIDKey];
    [dic setValue:[NSNumber numberWithInt:0] forKey:TimeElapsedKey];
    [self.customerArray addObject:dic];
    self.customerCountLbl.text=[NSString stringWithFormat:@"%lu",[self.customerArray count]];
    if (![self.globalTimer isValid]){
        globalTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
    }
    else{
        NSLog(@"Timer is already started");
    }
    
}
// This methos will increase producer count and if timer is not running it will start a timer

-(IBAction)increaseProducerCount:(id)sender
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSString *custId=[NSString stringWithFormat:@"Producer_%lu",[self.producerArray count]+1 ];
    [dic setObject:custId forKey:ProducerIDKey];
    [dic setValue:[NSNumber numberWithInt:0] forKey:TimeElapsedKey];
    [self.producerArray addObject:dic];
    self.producerCountLbl.text=[NSString stringWithFormat:@"%lu",[self.producerArray count]];

    if (![self.globalTimer isValid]){
        globalTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
    }
    else{
        NSLog(@"Timer is already started");
    }
}

@end
