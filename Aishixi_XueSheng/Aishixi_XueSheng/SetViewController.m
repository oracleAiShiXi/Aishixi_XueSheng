//
//  SetViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/25.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "SetViewController.h"
#import "ChangePassViewController.h"
@interface SetViewController ()

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ChangePass:(id)sender {
    ChangePassViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ChangePass"];
    [self.navigationController pushViewController:his animated:YES];
    
}

- (IBAction)Exit:(id)sender {
}
@end
