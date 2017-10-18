//
//  EditAdvisoryViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "EditAdvisoryViewController.h"
#import "XL_TouWenJian.h"
@interface EditAdvisoryViewController ()
{
    NSString *type;
    CGFloat cha;
    int pan;
}
@end

@implementation EditAdvisoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _gangwei.adjustsImageWhenHighlighted = NO;
    _qingjia.adjustsImageWhenHighlighted = NO;
    _qita.adjustsImageWhenHighlighted = NO;
    
    type =@"0";
    
    _textview.delegate =self;
    _textview.text = @"请编辑咨询内容";
    _textview.textColor = [UIColor grayColor];
    
    [self navagatio];
    [self  registerForKeyboardNotifications];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)navagatio{
    self.title =@"编辑咨询";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    //    UIButton *btnn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    //    [btnn setImage:[UIImage imageNamed:@"首页.png"] forState:UIControlStateNormal];
    //    [btnn addTarget:self action:@selector(Home:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:btnn];
    //    self.navigationItem.leftBarButtonItem =left;
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Post:(id)sender {
    type=@"1";
    [_gangwei setImage:[UIImage imageNamed:@"岗位.png"] forState:UIControlStateNormal];
    [_qingjia setImage:[UIImage imageNamed:@"请假2.png"] forState:UIControlStateNormal];
    [_qita setImage:[UIImage imageNamed:@"其他2.png"] forState:UIControlStateNormal];
}

- (IBAction)Leave:(id)sender {
    type=@"2";
    [_gangwei setImage:[UIImage imageNamed:@"岗位2.png"] forState:UIControlStateNormal];
    [_qingjia setImage:[UIImage imageNamed:@"请假.png"] forState:UIControlStateNormal];
    [_qita setImage:[UIImage imageNamed:@"其他2.png"] forState:UIControlStateNormal];
}

- (IBAction)Other:(id)sender {
    type=@"3";
    [_gangwei setImage:[UIImage imageNamed:@"岗位2.png"] forState:UIControlStateNormal];
    [_qingjia setImage:[UIImage imageNamed:@"请假2.png"] forState:UIControlStateNormal];
    [_qita setImage:[UIImage imageNamed:@"其他.png"] forState:UIControlStateNormal];
}

- (IBAction)Edit:(id)sender {
    [_textview becomeFirstResponder];
    _edit.hidden =YES;
}

- (IBAction)Publish:(id)sender {
    [_textview resignFirstResponder];
    _edit.hidden =NO;
    
//    if([type isEqualToString:@"0"]){
//        NSLog(@"%@",type);
//        NSLog(@"请选择咨询类型");
//    }else if ([_textview.text isEqualToString:@"请编辑咨询内容"]){
//       
//        NSLog(@"请编辑咨询内容");
//    }else{
//        NSLog(@"提交中");
//    }
    if([type isEqualToString:@"0"]||[_textview.text isEqualToString:@"请编辑咨询内容"]){
        NSLog(@"请选择咨询类型或编辑咨询内容");
    }else{
        
      NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString * Method = @"/consult/consul";
        NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",type,@"consultType",_textview.text,@"consultContent", nil];
        [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
            NSLog(@"11 学生咨询\n%@",responseObject);
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
        
        
        
     NSLog(@"提交中");
    }
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    _edit.hidden =NO;
}

#pragma mark-------TextViewdelegate

- (void)textViewDidEndEditing:(UITextView *)textView {
    if(_textview.text.length ==0){
        _textview.text = @"请编辑咨询内容";
        _textview.textColor = [UIColor grayColor];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if([_textview.text isEqualToString:@"请编辑咨询内容"]){
        _textview.text=@"";
        _textview.textColor=[UIColor blackColor];
        _edit.hidden =YES;
    }
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    _edit.hidden =YES;
    return YES;
}

#pragma  mark ---注册通知
- (void) registerForKeyboardNotifications
{
    cha=0.0;
    pan=0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(qkeyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(qkeyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark ----通知实现
- (void) qkeyboardWasShown:(NSNotification *) notif
{
    if (pan==0) {
        NSDictionary *info = [notif userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
        CGSize keyboardSize = [value CGRectValue].size;
        CGRect rect = CGRectMake(_fabu.frame.origin.x, _fabu.frame.origin.y, _fabu.frame.size.width,_fabu.frame.size.height);
        CGFloat kongjian=rect.origin.y+rect.size.height;
        CGFloat viewK=[UIScreen mainScreen].bounds.size.height;
        CGFloat jianpan=keyboardSize.height;
        if (viewK > kongjian+ jianpan) {
            cha=0;
        }else{
            cha=viewK-kongjian-jianpan;
        }
        pan=1;
        [self animateTextField:cha  up: YES];
    }
}
- (void) qkeyboardWasHidden:(NSNotification *) notif
{
    pan=0;
    [self animateTextField:cha up:NO];
}

#pragma mark------视图上移
- (void) animateTextField: (CGFloat) textField up: (BOOL) up
{
    
    //设置视图上移的距离，单位像素
    const int movementDistance = textField; // tweak as needed
    //三目运算，判定是否需要上移视图或者不变
    int movement = (up ? movementDistance : -movementDistance);
    //设置动画的名字
    [UIView beginAnimations: @"Animation" context: nil];
    //设置动画的开始移动位置
    [UIView setAnimationBeginsFromCurrentState: YES];
    //设置动画的间隔时间
    [UIView setAnimationDuration: 0.20];
    //设置视图移动的位移
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    //设置动画结束
    [UIView commitAnimations];
    
}



@end
