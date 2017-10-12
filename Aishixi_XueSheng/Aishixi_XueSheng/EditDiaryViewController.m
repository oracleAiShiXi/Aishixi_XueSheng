//
//  EditDiaryViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "EditDiaryViewController.h"
#import "DiaryListViewController.h"
#import "Color+Hex.h"
@interface EditDiaryViewController ()<UITextViewDelegate>{

    NSString *type;
    NSString*switchtype;
}

@end

@implementation EditDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"日记";
//    [self initButton:self.btn1];
//    [self initButton:self.btn2];
//    [self initButton:self.btn3];
    [self navagat];
    [self swifda];
    _btn1.adjustsImageWhenHighlighted = NO;
    _btn2.adjustsImageWhenHighlighted = NO;
    _btn3.adjustsImageWhenHighlighted = NO;
    
    _textview.delegate =self;
    _textview.text = @"请编辑评价内容";
    _textview.textColor = [UIColor grayColor];
    
    // Do any additional setup after loading the view.
}

-(void)navagat{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*right=[[UIBarButtonItem alloc]initWithTitle:@"我的日记" style:UIBarButtonItemStyleDone target:self action:@selector(History)];
    [self.navigationItem setRightBarButtonItem:right];
}

-(void)History{
    DiaryListViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DiaryList"];
    [self.navigationController pushViewController:his animated:YES];
    
}
-(void)swifda{
    switchtype =@"1";
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:@"公开/私密"];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:@"公开"];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"8A5BF7"] range:range1];
    _kaiguan.attributedText=hintString;
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

//-(void)initButton:(UIButton*)btn{
//    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height ,-btn.imageView.frame.size.width, 0,5)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(-15, 0.0,0.0, -btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    _editbtn.hidden =NO;
}
#pragma mark-------TextViewdelegate

- (void)textViewDidEndEditing:(UITextView *)textView {
    if(_textview.text.length ==0){
        _textview.text = @"请编辑评价内容";
        _textview.textColor = [UIColor grayColor];
        _editbtn.hidden =NO;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if([_textview.text isEqualToString:@"请编辑评价内容"]){
        _textview.text=@"";
        _textview.textColor=[UIColor blackColor];
        _editbtn.hidden =YES;
    }
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    _editbtn.hidden =YES;
    return YES;
}





- (IBAction)EditBtn:(id)sender {
    [_textview becomeFirstResponder];
    _editbtn.hidden =YES;
}

- (IBAction)Happy:(id)sender {
    type=@"1";
    [_btn1 setImage:[UIImage imageNamed:@"kaixin_light.png"] forState:UIControlStateNormal];
    [_btn2 setImage:[UIImage imageNamed:@"yiban_dark.png"] forState:UIControlStateNormal];
    [_btn3 setImage:[UIImage imageNamed:@"nanguo_dark.png"] forState:UIControlStateNormal];
    
    
}

- (IBAction)Common:(id)sender {
    type=@"2";
    [_btn1 setImage:[UIImage imageNamed:@"kaixin_dark.png"] forState:UIControlStateNormal];
    [_btn2 setImage:[UIImage imageNamed:@"yiban_light.png"] forState:UIControlStateNormal];
    [_btn3 setImage:[UIImage imageNamed:@"nanguo_dark.png"] forState:UIControlStateNormal];
    
}

- (IBAction)Bad:(id)sender {
    type=@"3";
    [_btn1 setImage:[UIImage imageNamed:@"kaixin_dark.png"] forState:UIControlStateNormal];
    [_btn2 setImage:[UIImage imageNamed:@"yiban_dark.png"] forState:UIControlStateNormal];
    [_btn3 setImage:[UIImage imageNamed:@"nanguo_light.png"] forState:UIControlStateNormal];
    
}

- (IBAction)Switcn:(id)sender {
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:@"公开/私密"];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:@"公开"];
    NSRange range2=[[hintString string]rangeOfString:@"私密"];
    
    
    if(_Swith.isOn ){
       [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"8A5BF7"] range:range2];
        switchtype =@"1";
    }else{
       switchtype =@"2";
       [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"8A5BF7"] range:range1];
    }
    _kaiguan.attributedText=hintString;
    
}

- (IBAction)Publish:(id)sender {
    [_textview resignFirstResponder];
    _editbtn.hidden =NO;
    
    if([type isEqualToString:@"0"]||[_textview.text isEqualToString:@"请编辑评价内容"]){
        NSLog(@"请选择咨询类型或编辑评价内容");
    }else{
        NSLog(@"提交中");
    }
    
}
@end
