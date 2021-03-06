//
//  DBOperation.m
//  Task2
//
//  Created by NR on 26/08/2015.
//  Copyright (c) 2015 Systango. All rights reserved.
//

#import "DBOperation.h"
#import "Utility.h"
@implementation DBOperation

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;



- (id)init
{
    if (self = [super init]) {
        [self managedObjectContext];

    }
    return self;
}


// method to fetch user detail with user id from DB
-(UserDetail*)fetchUserDetailWithUserId:(NSString*)userId
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserDetail"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"userId=%@", userId];
    fetchRequest.predicate=predicateName;
    [fetchRequest setResultType:NSDictionaryResultType];

    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (error || !fetchedObjects || [fetchedObjects count] > 1) {
        NSLog(@"Whoops, couldn't fetch: %@", [error localizedDescription]);
    }
    else if ([fetchedObjects count]) {
        
        NSDictionary *dic=[fetchedObjects objectAtIndex:0];
        UserDetail *userInfo=[[UserDetail alloc]init];
        userInfo.name=[dic objectForKey:kUserNameKey];
        userInfo.userId=[dic objectForKey:kUserIdKey];
        userInfo.emailId=[dic objectForKey:kUserEmailIdKey];
        userInfo.password=[dic objectForKey:kPasswordKey];
        userInfo.isLoggedIn=[[dic objectForKey:kUserState] boolValue];

        return userInfo;
    }
    return nil;
}


// method to fetch user detail of logged in user
-(UserDetail*)fetchLoggedInUser
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserDetail"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"isLoggedIn=YES"];
    fetchRequest.predicate=predicateName;
    [fetchRequest setResultType:NSDictionaryResultType];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (error || !fetchedObjects || [fetchedObjects count] > 1) {
        NSLog(@"Whoops, couldn't fetch: %@", [error localizedDescription]);
    }
    else if ([fetchedObjects count]) {
        
        NSDictionary *dic=[fetchedObjects objectAtIndex:0];
        UserDetail *userInfo=[[UserDetail alloc]init];
        userInfo.name=[dic objectForKey:kUserNameKey];
        userInfo.userId=[dic objectForKey:kUserIdKey];
        userInfo.emailId=[dic objectForKey:kUserEmailIdKey];
        userInfo.password=[dic objectForKey:kPasswordKey];
        userInfo.isLoggedIn=[[dic objectForKey:kUserState] boolValue];
        
        return userInfo;
    }
    return nil;
}

// method to log out user with and save status in DB
-(BOOL)LogOutUserWithId:(NSString*)userId
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserDetail"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"userId=%@", userId];
    fetchRequest.predicate=predicateName;
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (error || !fetchedObjects || [fetchedObjects count] > 1) {
        NSLog(@"Whoops, couldn't fetch: %@", [error localizedDescription]);
    }
    else if ([fetchedObjects count]) {
        
        NSDictionary *dic=[fetchedObjects objectAtIndex:0];
        
        [dic setValue:[NSNumber numberWithBool:NO] forKey:kUserState];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            return NO;
        }
        else{
            NSLog(@"user state saved successfully");
            
            return YES;
        }
        
        return YES;
    }
    return NO;
    
}

// method to log in user with and save status in DB
-(BOOL)LogIUserWithId:(NSString*)userId
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserDetail"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"userId=%@", userId];
    fetchRequest.predicate=predicateName;
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (error || !fetchedObjects || [fetchedObjects count] > 1) {
        NSLog(@"Whoops, couldn't fetch: %@", [error localizedDescription]);
    }
    else if ([fetchedObjects count]) {
        
        NSDictionary *dic=[fetchedObjects objectAtIndex:0];

        [dic setValue:[NSNumber numberWithBool:YES] forKey:kUserState];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            return NO;
        }
        else{
            NSLog(@"user state saved successfully");
            
            return YES;
        }

        return YES;
    }
    return NO;
    
}

// method to check user with given user id already exist in DB
-(BOOL)isUserIdExist:(NSString*)userId
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserDetail"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"userId=%@", userId];
    fetchRequest.predicate=predicateName;

    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (error || !fetchedObjects || [fetchedObjects count] > 1) {
        NSLog(@"Whoops, couldn't fetch: %@", [error localizedDescription]);
    }
    else if ([fetchedObjects count]) {
        return YES;
    }
    return NO;

}
// method to fetch all task with user id from DB

-(NSArray*)fetchAllTaskForUserId:(NSString*)userId{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TaskDetail"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicateName = [NSPredicate predicateWithFormat:@"userId=%@", userId];
    fetchRequest.predicate=predicateName;
    [fetchRequest setResultType:NSDictionaryResultType];

    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (error || !fetchedObjects ) {
        NSLog(@"Whoops, couldn't fetch: %@", [error localizedDescription]);
    }
    else if ([fetchedObjects count])
    {
        NSMutableArray * taskArray=[[NSMutableArray alloc]init];
        for (NSDictionary *dic in fetchedObjects)
        {
            TaskDetail *taskInfo=[[TaskDetail alloc]init];
            taskInfo.userId=[dic objectForKey:kUserIdKey];
            taskInfo.taskId=[dic objectForKey:kTaskIdKey];
            taskInfo.taskName=[dic objectForKey:kTaskNameKey];
            taskInfo.taskDetail=[dic objectForKey:kTaskDetailKey];
            [taskArray addObject:taskInfo];
        }
        return [taskArray copy];
    }
    return nil;
}
// method save task detail in from DB

-(BOOL)saveTaskDetailInDB:(TaskDetail*)taskDetail{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    TaskDetail *taskInfo = [NSEntityDescription
                                      insertNewObjectForEntityForName:@"TaskDetail"
                                      inManagedObjectContext:context];
    
    [taskInfo setValue:taskDetail.userId forKey:kUserIdKey];
    [taskInfo setValue:taskDetail.taskId forKey:kTaskIdKey];
    [taskInfo setValue:taskDetail.taskName forKey:kTaskNameKey];
    [taskInfo setValue:taskDetail.taskDetail forKey:kTaskDetailKey];
    

   
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return NO;
    }
    else{
        NSLog(@"task detail saved successfully");

        return YES;
    }
}
// method save user detail in from DB

-(BOOL)saveUserDetailInDB:(UserDetail*)userDetail{
    
    NSManagedObjectContext *context = [self managedObjectContext];

    UserDetail *userInfo= [NSEntityDescription insertNewObjectForEntityForName:@"UserDetail"
                            inManagedObjectContext:context];
    [userInfo setValue:userDetail.name forKey:kUserNameKey];
    [userInfo setValue:userDetail.userId forKey:kUserIdKey];
    [userInfo setValue:userDetail.emailId forKey:kUserEmailIdKey];
    [userInfo setValue:userDetail.password forKey:kPasswordKey];
    [userInfo setValue:[NSNumber numberWithBool:userDetail.isLoggedIn] forKey:kUserState];

    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return NO;
    }
    else{
        NSLog(@"user detail saved successfully");
        
        return YES;
    }
}

#pragma mark - Core Data Methods

/**
 *  Method to create managed Object Context object
 *
 *  @return  managed Object Context object
 */

-(NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

/**
 *  Method to create managed Object Model object
 *
 *  @return  managed Object Model object
 */

-(NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Task2" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

/**
 *  Method to create persistent Store coordinator object
 *
 *  @return persistent Store Coordinator object
 */
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Task2.sqlite"];
    NSLog(@"storeURL =%@",storeURL);
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



@end
