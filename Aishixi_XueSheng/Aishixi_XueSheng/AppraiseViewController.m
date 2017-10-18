//
//  AppraiseViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/25.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "AppraiseViewController.h"
#import "XL_TouWenJian.h"
@interface AppraiseViewController ()<UITextViewDelegate>
{
    NSString *type;
    CGFloat cha;
    int pan;
}
@end

@implementation AppraiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _haoping.adjustsImageWhenHighlighted = NO;
    _zhongping.adjustsImageWhenHighlighted = NO;
    _chaping.adjustsImageWhenHighlighted = NO;
    
    
    self.title =@"评价";
    
    
    
     type =@"0";
    
    _textview.delegate =self;
    _textview.text = @"请编辑评价内容";
    _textview.textColor = [UIColor grayColor];
    [self  registerForKeyboardNotifications];
    
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

- (IBAction)Good:(id)sender {
    type=@"1";
    [_haoping setImage:[UIImage imageNamed:@"011.png"] forState:UIControlStateNormal];
    [_zhongping setImage:[UIImage imageNamed:@"012.png"] forState:UIControlStateNormal];
    [_chaping setImage:[UIImage imageNamed:@"013.png"] forState:UIControlStateNormal];
    _haoping.adjustsImageWhenHighlighted = NO;
}

- (IBAction)Mid:(id)sender {
    type=@"2";
    [_haoping setImage:[UIImage imageNamed:@"016.png"] forState:UIControlStateNormal];
    [_zhongping setImage:[UIImage imageNamed:@"014.png"] forState:UIControlStateNormal];
    [_chaping setImage:[UIImage imageNamed:@"013.png"] forState:UIControlStateNormal];
}

- (IBAction)Bad:(id)sender {
    type=@"3";
    [_haoping setImage:[UIImage imageNamed:@"016.png"] forState:UIControlStateNormal];
    [_zhongping setImage:[UIImage imageNamed:@"012.png"] forState:UIControlStateNormal];
    [_chaping setImage:[UIImage imageNamed:@"015.png"] forState:UIControlStateNormal];
}

- (IBAction)Edit:(id)sender {
    [_textview becomeFirstResponder];
    _edit.hidden =YES;
}

- (IBAction)publist:(id)sender {
    [_textview resignFirstResponder];
     _edit.hidden =NO;
    
    if([type isEqualToString:@"0"]||[_textview.text isEqualToString:@"请编辑评价内容"]){
        NSLog(@"请选择咨询类型或编辑评价内容");
    }else{
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        NSString * Method = @"/homePageStu/evaluate";
        /*edUserId 被评人ID
         content 评价内容
         evaluateType 1 好评 2 中评 3 差评
         evaluatEdType 受评类型 1 企业 2 老师 3 学生
         */
        //被评价人和被评人ID没写那
        NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",@"14",@"edUserId",_textview.text,@"content",type,@"evaluateType",@"3",@"evaluatEdType", nil];
        [XL_WangLuo QianWaiWangQingqiuwithBizMethod:Method Rucan:Rucan type:Post success:^(id responseObject) {
            NSLog(@"4、评价\n%@",responseObject);
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
        _textview.text = @"请编辑评价内容";
        _textview.textColor = [UIColor grayColor];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if([_textview.text isEqualToString:@"请编辑评价内容"]){
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
