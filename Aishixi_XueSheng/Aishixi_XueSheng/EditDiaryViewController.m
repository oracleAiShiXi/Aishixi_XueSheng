//
//  EditDiaryViewController.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "EditDiaryViewController.h"
#import "DiaryListViewController.h"
#import "XL_TouWenJian.h"
@interface EditDiaryViewController ()<UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate>{

    NSString *type;
    NSString*switchtype;
    int po;
}
@property (strong,nonatomic)UIImage *image;
@end

@implementation EditDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
//    [self initButton:self.btn1];
//    [self initButton:self.btn2];
//    [self initButton:self.btn3];
    po=0;
    type =@"1";
    [self navagat];
    [self swifda];
    [self Imagedel];
    _btn1.adjustsImageWhenHighlighted = NO;
    _btn2.adjustsImageWhenHighlighted = NO;
    _btn3.adjustsImageWhenHighlighted = NO;
   
    _textview.delegate =self;
    _textview.text = @"这一刻的想法...";
    _textview.textColor = [UIColor grayColor];
    
    // Do any additional setup after loading the view.
}

-(void)navagat{
    self.title =@"写日记";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    //    UIButton *btnn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    //    [btnn setImage:[UIImage imageNamed:@"首页.png"] forState:UIControlStateNormal];
    //    [btnn addTarget:self action:@selector(Home:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:btnn];
    //    self.navigationItem.leftBarButtonItem =left;
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*right=[[UIBarButtonItem alloc]initWithTitle:@"我的日记" style:UIBarButtonItemStyleDone target:self action:@selector(History)];
    [self.navigationItem setRightBarButtonItem:right];
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
    
}

-(void)fanhui{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)History{
    DiaryListViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DiaryList"];
    [self.navigationController pushViewController:his animated:YES];
    
}

-(void)Imagedel{
    NSFileManager *fm=[NSFileManager defaultManager];
    //完整的图片路径，如果图片是放在文件夹中的话，还要在中间加上文件夹的路径
    NSString *imagepath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/images"];
    
    //可以打印路径看看是什么情况
    if ([fm fileExistsAtPath:[NSString stringWithFormat:@"%@/1.jpg",imagepath]]) {
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/1.jpg",imagepath]];
        [_one setBackgroundImage:image forState:UIControlStateNormal];
    }
    if ([fm fileExistsAtPath:[NSString stringWithFormat:@"%@/2.jpg",imagepath]]) {
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/2.jpg",imagepath]];
        [_two setBackgroundImage:image forState:UIControlStateNormal];
    }
    if ([fm fileExistsAtPath:[NSString stringWithFormat:@"%@/3.jpg",imagepath]]) {
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/3.jpg",imagepath]];
        [_three setBackgroundImage:image forState:UIControlStateNormal];
    }
 

}


-(void)phone{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    actionSheet.tag = 255;
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:NO completion:^{}];
        
        //        [imagePickerController release];
    }
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    [picker dismissViewControllerAnimated:NO completion:^{}];
    
    _image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // 保存图片至本地，方法见下文
    
    //按时间为图片命名
    NSDateFormatter *forr=[[NSDateFormatter alloc] init];
    
    [forr setDateFormat:@"yyyyMMddHHmmss"];
    
    NSString *name=[NSString stringWithFormat:@"%d.jpg",po/*[forr stringFromDate:[NSDate date]]*/];
    
    [self saveImage:_image withName:name];
    
}
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSFileManager *fm=[NSFileManager defaultManager];
    NSString *dicpath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/images"];
    
    [fm createDirectoryAtPath:dicpath withIntermediateDirectories:NO attributes:nil error:nil];
    
    NSString *picpath=[NSString stringWithFormat:@"%@/%@",dicpath,imageName];
    [fm createFileAtPath:picpath contents:imageData attributes:nil];
    if (po==1) {
        
        [_one setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
    }else if(po==2){
        [_two setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
    }else if (po==3){
        [_three setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
    }else{
        
    }
}

//照片1
- (IBAction)one:(id)sender {
    [self.view endEditing:YES];
    po=1;
    [self phone];
}
//照片2
- (IBAction)two:(id)sender {
    [self.view endEditing:YES];
    po=2;
    [self phone];
}
//照片3
- (IBAction)three:(id)sender {
    [self.view endEditing:YES];
    po=3;
    [self phone];
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
        _textview.text = @"这一刻的想法...";
        _textview.textColor = [UIColor grayColor];
        _editbtn.hidden =NO;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if([_textview.text isEqualToString:@"这一刻的想法..."]){
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
        switchtype =@"2";
    }else{
       switchtype =@"1";
       [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"8A5BF7"] range:range1];
    }
    _kaiguan.attributedText=hintString;
    
}

- (IBAction)Publish:(id)sender {
    [_textview resignFirstResponder];
    _editbtn.hidden =NO;
    
    
    
    
    
    
  
    if(_textview.text.length==0||[_textview.text isEqualToString:@"这一刻的想法..."]){
     [WarningBox warningBoxModeText:@"请输入这一刻的想法" andView:self.view];
    }
    else{
        
        
        //拿图片
        NSMutableArray * heheda=[[NSMutableArray alloc] init];
        NSFileManager *fm1=[NSFileManager defaultManager];
        NSString *dicpath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/images"];
        NSString *picpath=[NSString stringWithFormat:@"%@/1.jpg",dicpath];
        NSString *picpath1=[NSString stringWithFormat:@"%@/2.jpg",dicpath];
        NSString *picpath2=[NSString stringWithFormat:@"%@/3.jpg",dicpath];
        UIImage *img =[UIImage imageNamed:picpath];
        UIImage *img1 =[UIImage imageNamed:picpath1];
        UIImage *img2 =[UIImage imageNamed:picpath2];
        NSArray*apq=[NSArray arrayWithObjects:picpath,picpath1,picpath2, nil];
        for (int i=0; i<apq.count; i++) {
            if ([fm1 fileExistsAtPath: apq[i]]) {
                [heheda addObject:apq[i]];
            }
        }
        
    
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString * Method = @"/diary/internshipPublic";
        NSDictionary *Rucan = [NSDictionary dictionaryWithObjectsAndKeys:[defaults objectForKey:@"userId"],@"userId",switchtype,@"quesionChapter",type,@"mood",_textview.text,@"content", nil];
//        UIImage *image = [UIImage imageNamed:@"对号2"];
        NSArray *arr = [NSArray arrayWithObjects:img,img1,img2, nil];
        
        [WarningBox warningBoxModeIndeterminate:@"正在保存" andView:self.view];
        
        [XL_WangLuo ShangChuanTuPianwithBizMethod:Method Rucan:Rucan type:Post image:arr key:@"imageUrl" success:^(id responseObject) {
            NSLog(@"15 学生日记发布\n%@",responseObject);
            [WarningBox warningBoxHide:YES andView:self.view];
            if ([[responseObject objectForKey:@"code"] isEqualToString:@"0000"]) {
            
            NSFileManager *defaultManager;
            defaultManager = [NSFileManager defaultManager];
            NSString*path=[NSString stringWithFormat:@"%@/Documents/images",NSHomeDirectory()];
            [defaultManager removeItemAtPath:path error:NULL];
                
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 DiaryListViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DiaryList"];
                 [self.navigationController pushViewController:his animated:YES];
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
@end
