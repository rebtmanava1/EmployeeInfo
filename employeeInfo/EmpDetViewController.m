//
//  EmpDetViewController.m
//  employeeInfo
//
//  Created by panther on 10/13/15.
//  Copyright (c) 2015 panther. All rights reserved.
//

#import "EmpDetViewController.h"

@interface EmpDetViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *lastName;
@property (weak, nonatomic) IBOutlet UILabel *dept;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UILabel *pin;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *dob;
@property (weak, nonatomic) IBOutlet UILabel *gender;
@property (weak, nonatomic) IBOutlet UILabel *martStatus;

@end

@implementation EmpDetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self initializeOutlets];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initializeOutlets{
    _firstName.text = [_nsdEmpDetails valueForKey:@"First_Name"];
    _lastName.text  = [_nsdEmpDetails valueForKey:@"Last_Name"];
    _address.text   = [_nsdEmpDetails valueForKey:@"Street_address"];
    _city.text = [_nsdEmpDetails valueForKey:@"City"];
    _pin.text = [_nsdEmpDetails valueForKey:@"Pin"];
    _country.text = [_nsdEmpDetails valueForKey:@"Country"];
    _state.text = [_nsdEmpDetails valueForKey:@"State"];
    _dob.text = [_nsdEmpDetails valueForKey:@"DOB"];
    _email.text = [_nsdEmpDetails valueForKey:@"Email"];
    _phone.text = [_nsdEmpDetails valueForKey:@"Phone"];
    _dept.text = [_nsdEmpDetails valueForKey:@"Dept"];
    _martStatus.text = [_nsdEmpDetails valueForKey:@"Maritial_status"];
    _gender.text = [_nsdEmpDetails valueForKey:@"Gender"];
}

@end
