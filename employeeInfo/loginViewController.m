//
//  loginViewController.m
//  employeeInfo
//
//  Created by panther on 10/11/15.
//  Copyright (c) 2015 panther. All rights reserved.
//

#import "loginViewController.h"
#import "DbManager.h"
#import "EmpListViewController.h"

@interface loginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *userPassTF;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginButton:(id)sender;

@end

@implementation loginViewController{
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
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier]isEqualToString:@"empListSeg"]) {
        EmpListViewController* vc = [segue destinationViewController];
        vc.empList = [dbMan getEmployeeList];
    }
    
    
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([dbMan validateUser:_userNameTF.text andPassword:_userPassTF.text]) {
        return YES;
    }else{
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"UserValidationAlert" message:@"Invalid User/Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    return NO;
}

#pragma mark - Delegate
- (IBAction)loginButton:(id)sender {
}
@end
