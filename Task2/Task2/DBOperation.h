//
//  DBOperation.h
//  Task2
//
//  Created by NR on 26/08/2015.
//  Copyright (c) 2015 Systango. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UserDetail.h"
#import "TaskDetail.h"
@interface DBOperation : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
-(UserDetail*)fetchUserDetailWithUserId:(NSString*)userId;
-(TaskDetail*)fetchTaskDetailsWithTaskId:(NSString*)taskId;
-(NSArray*)fetchAllTaskForUserId:(NSString*)userId;
-(BOOL)saveTaskDetailInDB:(TaskDetail*)taskDetail;
-(BOOL)saveUserDetailInDB:(UserDetail*)userDetail;
-(BOOL)isUserIdExist:(NSString*)userId;
@end
