//
//  UserDetail.h
//  Task2
//
//  Created by NR on 25/08/2015.
//  Copyright (c) 2015 Systango. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDetail : NSObject
@property(nonatomic,strong)NSString *name,*userId,*password,*emailId;
@property(nonatomic,assign) BOOL isLoggedIn;
@end
