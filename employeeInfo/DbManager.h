//
//  DbManager.h
//  employeeInfo
//
//  Created by panther on 10/11/15.
//  Copyright (c) 2015 panther. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DbManager : NSObject

+(DbManager*)getDBManager;


-(BOOL) validateUser:(NSString*)userName andPassword:(NSString*)password;
-(NSDictionary*)getEmployeeDetailsOfEmpWithId:(NSString*)empId;
-(NSArray*)getEmployeeList;

@end
