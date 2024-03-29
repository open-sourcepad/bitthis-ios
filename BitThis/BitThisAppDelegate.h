//
//  BitThisAppDelegate.h
//  BitThis
//
//  Created by Nikki Fernandez on 3/21/14.
//  Copyright (c) 2014 SourcePad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "BitThisViewController.h"

@interface BitThisAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) RKObjectManager *apiObjMgr;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) BitThisViewController *bitThisVC;

//@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
