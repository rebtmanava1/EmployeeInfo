//
//  EmpListViewController.m
//  employeeInfo
//
//  Created by panther on 10/13/15.
//  Copyright (c) 2015 panther. All rights reserved.
//

#import "EmpListViewController.h"

@interface EmpListViewController ()
@property (strong, nonatomic) IBOutlet UIView *tabView;

@end

@implementation EmpListViewController{
    DbManager* dbMan;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    dbMan = [DbManager getDBManager];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_empList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSDictionary* nsdObj = [_empList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [nsdObj objectForKey:@"First_Name"], [nsdObj objectForKey:@"Last_Name"]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NSDictionary* nsdEmpDetails = [dbMan getEmployeeDetailsOfEmpWithId:[[_empList objectAtIndex:indexPath.row] valueForKey:@"EmployeeId"]];
    
    [self performSegueWithIdentifier:@"testManualSeg" sender:nsdEmpDetails];
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier]isEqualToString:@"testManualSeg"]) {
        EmpDetViewController* vc = [segue destinationViewController];
        vc.nsdEmpDetails = sender;
    }
}


@end
