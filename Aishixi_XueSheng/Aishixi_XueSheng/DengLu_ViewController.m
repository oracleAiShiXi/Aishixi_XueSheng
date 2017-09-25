//
//  DengLu_ViewController.m
//  Aishixi_XueSheng
//
//  Created by 斌小狼 on 2017/9/18.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "DengLu_ViewController.h"
#import "MainTableViewController.h"
@interface DengLu_ViewController ()

@end

@implementation DengLu_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Login:(id)sender {
    MainTableViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Main"];
    [self.navigationController pushViewController:his animated:YES];
}


@end
