//
//  ChangePassViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/29.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "ChangePassViewController.h"
#import "DengLu_ViewController.h"
#import "XL_TouWenJian.h"
@interface ChangePassViewController ()<UITextFieldDelegate>

@end

@implementation ChangePassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //限制textField位数
    [self xianzhi];
    [self navagatio];
    [self delegate];
    
    
    // Do any additional setup after loading the view.
}
-(void)navagatio{
    self.title =@"修改密码";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    //    UIButton *btnn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    //    [btnn setImage:[UIImage imageNamed:@"首页.png"] forState:UIControlStateNormal];
    //    [btnn addTarget:self action:@selector(Home:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:btnn];
    //    self.navigationItem.leftBarButtonItem =left;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
    
    
}

-(void)fanhui{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)delegate{
   
    //textfield 代理
    _oldPass.delegate = self;
    _mewPass.delegate = self;
    _rePass.delegate = self;
    _oldPass.keyboardType = UIKeyboardTypeASCIICapable;
    _mewPass.keyboardType = UIKeyboardTypeASCIICapable;
    _rePass.keyboardType=UIKeyboardTypeASCIICapable;
    _oldPass.autocorrectionType = UITextAutocorrectionTypeNo;
    _mewPass.autocorrectionType = UITextAutocorrectionTypeNo;
    _rePass.autocorrectionType = UITextAutocorrectionTypeNo;
}
#pragma mark - textfield方法

//光标下移
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.oldPass)
    {
        [self.mewPass becomeFirstResponder];
    }
    else if (textField == self.mewPass)
    {
        [self.rePass becomeFirstResponder];
    }
    else
    {
        //结束编辑
        [self.view endEditing:YES];
        [self Sure:nil];
    }
    return YES;
}
#pragma mark - 限制textField位数
-(void)xianzhi
{
    [self.oldPass addTarget:self action:@selector(OldPass) forControlEvents:UIControlEventEditingChanged];
    [self.mewPass addTarget:self action:@selector(newPass1) forControlEvents:UIControlEventEditingChanged];
    [self.rePass addTarget:self action:@selector(newPass2) forControlEvents:UIControlEventEditingChanged];
}
-(void)OldPass
{
    int MaxLen = 14;
    NSString* szText = [_oldPass text];
    if ([_oldPass.text length]> MaxLen)
    {
        _oldPass.text = [szText substringToIndex:MaxLen];
    }
}
-(void)newPass1
{
    int MaxLen = 14;
    NSString* szText = [_mewPass text];
    if ([_mewPass.text length]> MaxLen)
    {
        _mewPass.text = [szText substringToIndex:MaxLen];
    }
}
-(void)newPass2
{
    int MaxLen = 14;
    NSString* szText = [_rePass text];
    if ([_rePass.text length]> MaxLen)
    {
        _rePass.text = [szText substringToIndex:MaxLen];
    }
}
#pragma mark - 判断长度
-(BOOL)newpass1:(NSString *)new1
{
    if (self.mewPass.text.length < 5) {
        return NO;
    }
    return YES;
}

-(BOOL)newpass_Deng:(NSString *)deng
{
    if (![self.rePass.text isEqualToString: self.mewPass.text]) {
        return NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Sure:(id)sender {
    [self.view endEditing:YES];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[defaults objectForKey:@"Password"]);
        if (self.oldPass.text.length > 0 && self.mewPass.text.length > 0 && self.rePass.text.length > 0){
            
            if(self.oldPass.text != [NSString stringWithFormat:@"%@",[defaults objectForKey:@"Password"]])
            {
                [WarningBox warningBoxModeText:@"原密码不正确" andView:self.view];
            }
            else if (![self newpass1:self.mewPass.text])
            {
                [WarningBox warningBoxModeText:@"密码长度不够" andView:self.view];
            }
            else if (![self newpass_Deng:self.rePass.text])
            {
                [WarningBox warningBoxModeText:@"两次密码不一致，请重新输入" andView:self.view];
            }
           else
           {
               
               NSString * Method = @"/user/setPassword";
               NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",_oldPass.text,@"oldPassword",@"1",@"userType",_mewPass.text,@"newPassword", nil];
             [WarningBox warningBoxModeIndeterminate:@"正在修改" andView:self.view];
               [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
                   [WarningBox warningBoxHide:YES andView:self.view];
                   if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
                   
                   NSLog(@"3、修改密码\n%@",responseObject);
                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                           DengLu_ViewController *view = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DengLu"];
                           [self presentViewController:view animated:YES completion:^{}];
                       });
                       
                   }else{
                       [WarningBox warningBoxModeText:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] andView:self.view];
                       
                   }
                       
                       
               } failure:^(NSError *error) {
                   [WarningBox warningBoxHide:YES andView:self.view];
                   NSLog(@"%@",error);
               }];
            }
        }
        else{
            [WarningBox warningBoxModeText:@"密码不能为空" andView:self.view];
        }

}

@end
