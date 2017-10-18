//
//  DiaryInfoViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "DiaryInfoViewController.h"
#import "XL_TouWenJian.h"
@interface DiaryInfoViewController ()

@end

@implementation DiaryInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)jiekou{
    
    NSString * Method = @"/diary/internshipInfo";
    NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"19",@"internshipId",nil];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
        NSLog(@"17 学生日记详情\n%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
