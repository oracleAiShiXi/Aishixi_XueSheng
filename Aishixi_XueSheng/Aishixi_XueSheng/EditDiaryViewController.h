//
//  EditDiaryViewController.h
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditDiaryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UIButton *editbtn;
@property (weak, nonatomic) IBOutlet UIImageView *Img1;
@property (weak, nonatomic) IBOutlet UIImageView *Img2;
@property (weak, nonatomic) IBOutlet UIImageView *Img3;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UISwitch *Swith;
@property (weak, nonatomic) IBOutlet UILabel *kaiguan;



- (IBAction)EditBtn:(id)sender;
- (IBAction)Happy:(id)sender;
- (IBAction)Common:(id)sender;
- (IBAction)Bad:(id)sender;
- (IBAction)Switcn:(id)sender;
- (IBAction)Publish:(id)sender;

@end
