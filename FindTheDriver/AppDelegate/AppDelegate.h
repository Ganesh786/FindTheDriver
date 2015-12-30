//
//  AppDelegate.h
//  FindTheDriver
//
//  Created by Ganesh Korada on 24/11/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SWRevealViewController.h"
#import "AFNetworking.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, assign) UINavigationController *navigationController;
@property (nonatomic, assign) BOOL isSideBarInspectLogsClicked;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

