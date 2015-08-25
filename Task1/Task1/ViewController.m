//
//  ViewController.m
//  Task1
//
//  Created by NR on 24/08/2015.
//  Copyright (c) 2015 Systango. All rights reserved.
//



#define ItemProductionTime 5
#define ItemConsumptionTime 2

#import "ViewController.h"
#import "Customer.h"
#import "Producer.h"
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
    for (Customer *customerObj in self.customerArray)
    {
        int timeElapsed=customerObj.timeElapsed;
        NSLog(@"time elapsed for %@ =%d",customerObj.customerId,timeElapsed);
        // if time elapsed for consumer is equals to 2, consumer will consume an item and reset time elapsed to 0 else increase time elapsed by 1
        if (timeElapsed<ItemConsumptionTime)
        {
           customerObj.timeElapsed=timeElapsed+1;

        }
        else{
            if (itemCount>0) {
                itemCount--;
                self.itemCountLbl.text=[NSString stringWithFormat:@"%d",itemCount];
                customerObj.timeElapsed=0;
                NSLog(@" item consumed by %@",customerObj.customerId);
            }
        }
    }
    for (Producer *producerObj in self.producerArray)
    {
        int timeElapsed=producerObj.timeElapsed;
       
        NSLog(@"time elapsed for %@ =%d",producerObj.producerId,timeElapsed);
        // if time elapsed for producer is equals to 5, producer will produce an item and reset time elapsed to 0 else increase time elapsed by 1

        if (timeElapsed<ItemProductionTime)
        {
            producerObj.timeElapsed=timeElapsed+1;
            
        }
        else{
                itemCount++;
                self.itemCountLbl.text=[NSString stringWithFormat:@"%d",itemCount];
               producerObj.timeElapsed=0;
            NSLog(@"item is produced by %@",producerObj.producerId);

        }
    }
}

// This methos will increase consumer count and if timer is not running it will start a timer
-(IBAction)increaseCustomerCount:(id)sender
{
    NSString *custId=[NSString stringWithFormat:@"Customer_%lu",[self.customerArray count]+1 ];
    Customer *customerObj=[[Customer alloc]init];
    customerObj.customerId=custId;
    customerObj.timeElapsed=0;
    [self.customerArray addObject:customerObj];
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
    NSString *prodId=[NSString stringWithFormat:@"Producer_%lu",[self.producerArray count]+1 ];
    Producer *producerObj=[[Producer alloc]init];
    producerObj.producerId=prodId;
    producerObj.timeElapsed=0;
    [self.producerArray addObject:producerObj];
    self.producerCountLbl.text=[NSString stringWithFormat:@"%lu",[self.producerArray count]];

    if (![self.globalTimer isValid]){
        globalTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
    }
    else{
        NSLog(@"Timer is already started");
    }
}

@end
