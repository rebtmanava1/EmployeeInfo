//
//  DbManager.m
//  employeeInfo
//
//  Created by panther on 10/11/15.
//  Copyright (c) 2015 panther. All rights reserved.
//

#import "DbManager.h"
#import <sqlite3.h>


#pragma mark - Static Variables
static NSString* dbFileName = @"employee.db";
static NSString* dbFilePath;
static NSString* documentPath;
static DbManager* dataBase;
static sqlite3* dbHandle;

#pragma mark - implimentation
@implementation DbManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSError *error;
        documentPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:dbFileName];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:documentPath]) {
            //File Already Exists
            [[NSFileManager defaultManager] removeItemAtPath:documentPath error:&error];
            if (error != nil) {
                NSLog(@"Failed to remove the DB file from Document Path");
                NSLog(@"%@",[error localizedDescription]);
            }
        }
        
        dbFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbFileName];
        
        [[NSFileManager defaultManager] copyItemAtPath:dbFilePath toPath:documentPath error:&error];
        
        if (error != nil) {
            NSLog(@"Failed to Copy the DB file to Document Path");
            NSLog(@"%@",[error localizedDescription]);
        }else{
            if (sqlite3_open([documentPath UTF8String], &dbHandle) != SQLITE_OK) {
                NSLog(@"Failed to open the sqlite db");
            }
        }
    }
    return self;
}


#pragma mark - Shared instance creator
+(DbManager *)getDBManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBase = [[DbManager alloc]init];
    });
    
    return dataBase;
}

#pragma mark - Dealloc
-(void)dealloc{
    sqlite3_close(dbHandle);
}


-(BOOL) validateUser:(NSString*)userName andPassword:(NSString*)password{
    NSString* query = [NSString stringWithFormat:@"select * from login where username= '%@' and password='%@'", userName, password ];
    sqlite3_stmt* sqlStmt;
    
    if (sqlite3_prepare_v2(dbHandle, [query UTF8String], -1, &sqlStmt, nil) == SQLITE_OK) {
        while (sqlite3_step(sqlStmt) == SQLITE_ROW) {
            return YES;
        }
        sqlite3_finalize(sqlStmt);
    }
    
    return NO;
}

-(NSArray*)getEmployeeList{
    NSString* query = [NSString stringWithFormat:@"select employeeId, first_name, last_name from employee order by last_name"];
    NSMutableArray* nsmEmpList = [[NSMutableArray alloc]initWithCapacity:0];
    sqlite3_stmt* sqlStmt;
    
    if (sqlite3_prepare_v2(dbHandle, [query UTF8String], -1, &sqlStmt, nil) == SQLITE_OK) {
        while (sqlite3_step(sqlStmt) == SQLITE_ROW) {
            NSMutableDictionary* nsdObj = [[NSMutableDictionary alloc]init];
            [nsdObj setValue:[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 0)] forKey:@"EmployeeId"];
            [nsdObj setValue:[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 1)] forKey:@"First_Name"];
            [nsdObj setValue:[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 2)] forKey:@"Last_Name"];
            [nsmEmpList addObject:nsdObj];
        }
        sqlite3_finalize(sqlStmt);
    }    
    return nsmEmpList;
}
/*
 CREATE TABLE "Employee" (
	`EmployeeId`	TEXT NOT NULL UNIQUE,
	`First_name`	TEXT,
	`Last_name`	TEXT,
	`Street_address`	TEXT,
	`City`	TEXT,
	`State`	TEXT,
	`Country`	TEXT,
	`Pin`	TEXT,
	`DOB`	TEXT,
	`Email`	TEXT,
	`Phone`	TEXT,
	`Dept`	TEXT,
	`Maritial_status`	TEXT,
	`Gender`	TEXT,
	PRIMARY KEY(EmployeeId)
 )
 
 */

-(NSDictionary*)getEmployeeDetailsOfEmpWithId:(NSString*)empId{
    NSString* query = [NSString stringWithFormat:@"select * from employee where EmployeeId='%@'", empId];
    NSMutableDictionary* nsmEmpDet = [[NSMutableDictionary alloc]init];
    sqlite3_stmt* sqlStmt;
    
    if (sqlite3_prepare_v2(dbHandle, [query UTF8String], -1, &sqlStmt, nil) == SQLITE_OK) {
        while (sqlite3_step(sqlStmt) == SQLITE_ROW) {
            [nsmEmpDet setValue:[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 0)] forKey:@"EmployeeId"];
            [nsmEmpDet setValue:[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 1)] forKey:@"First_Name"];
            [nsmEmpDet setValue:[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 2)] forKey:@"Last_Name"];
            [nsmEmpDet setValue:[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 3)] forKey:@"Street_address"];
            [nsmEmpDet setValue:[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 4)] forKey:@"City"];
            [nsmEmpDet setValue:[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 5)] forKey:@"State"];
            [nsmEmpDet setValue:[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 6)] forKey:@"Country"];
            [nsmEmpDet setValue:[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 7)] forKey:@"Pin"];
            [nsmEmpDet setValue:[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 8)] forKey:@"DOB"];
            [nsmEmpDet setValue:[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 9)] forKey:@"Email"];
            [nsmEmpDet setValue:[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 10)] forKey:@"Phone"];
            [nsmEmpDet setValue:[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 11)] forKey:@"Dept"];
            [nsmEmpDet setValue:[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 12)] forKey:@"Maritial_status"];
            [nsmEmpDet setValue:[[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 13)] forKey:@"Gender"];
            
        }
        sqlite3_finalize(sqlStmt);
    }
    
    return nsmEmpDet;
}

@end
