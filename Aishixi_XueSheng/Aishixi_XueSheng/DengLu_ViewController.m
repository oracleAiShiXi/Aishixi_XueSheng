//
//  DengLu_ViewController.m
//  Aishixi_XueSheng
//
//  Created by 斌小狼 on 2017/9/18.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "DengLu_ViewController.h"
#import "NavagationViewController.h"
#import "XL_TouWenJian.h"
@interface DengLu_ViewController ()<UITextFieldDelegate>

@end

@implementation DengLu_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self delegate];
    [self navagatio];
    _username.text =@"13888888888";
    _password.text =@"123456";
   // NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:@"zls",@"userName",@"123456789",@"passWord",@"2",@"userType", nil];13888888888
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)navagatio{
    self.title =@"登录";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    //    UIButton *btnn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    //    [btnn setImage:[UIImage imageNamed:@"首页.png"] forState:UIControlStateNormal];
    //    [btnn addTarget:self action:@selector(Home:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:btnn];
    //    self.navigationItem.leftBarButtonItem =left;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)delegate{
    _username.delegate = self;
    _password.delegate = self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _username) {
        [_password becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
        [self Login:nil];
    }
    return YES;
}

-(void)jiekou{
    NSDictionary * did =[NSDictionary dictionaryWithObjectsAndKeys:_username.text,@"userName",_password.text,@"passWord",@"1",@"userType",nil];
    [WarningBox warningBoxModeIndeterminate:@"登陆中..." andView:self.view];
    [XL_WangLuo QianWaiWangQingqiuwithBizMethod:@"/user/logined" Rucan:did type:Post success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
            /*数据处理*/
            NSDictionary * data =[responseObject objectForKey:@"data"];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            //用户Id
            [user setObject:[data objectForKey:@"userId"] forKey:@"userId"];
            //用户电话
            [user setObject:[data objectForKey:@"tel"] forKey:@"tel"];
            //用户姓名
            [user setObject:[data objectForKey:@"nick"] forKey:@"nick"];
            //教师电话
            [user setObject:[data objectForKey:@"teacherTel"] forKey:@"teacherTel"];
            
            NavagationViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Navagation"];
            [self presentViewController:his animated:YES completion:^{
            }];
        }else{
            [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] andView:self.view];
            
        }
        
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        NSLog(@"%@",error);
    }];
}


- (IBAction)Login:(id)sender {
   [self jiekou];
}


@end
