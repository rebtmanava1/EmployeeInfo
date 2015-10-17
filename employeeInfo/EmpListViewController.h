//
//  EmpListViewController.h
//  employeeInfo
//
//  Created by panther on 10/13/15.
//  Copyright (c) 2015 panther. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbManager.h"
#import "EmpDetViewController.h"

@interface EmpListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, readwrite) NSArray* empList;

@end
