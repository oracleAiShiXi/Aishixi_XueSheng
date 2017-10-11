//
//  MySelfTableViewController.h
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/22.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySelfTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *qq;
@property (weak, nonatomic) IBOutlet UITextField *weixin;
@property (weak, nonatomic) IBOutlet UITextField *xinzi;
@property (weak, nonatomic) IBOutlet UITextField *hangye;
@property (weak, nonatomic) IBOutlet UITextField *mingcheng;
@property (weak, nonatomic) IBOutlet UITextField *dianhua;
@property (weak, nonatomic) IBOutlet UITextField *zhiwei;
@property (weak, nonatomic) IBOutlet UITextField *diqu;
@property (weak, nonatomic) IBOutlet UITextField *dizhi;
@property (weak, nonatomic) IBOutlet UITextField *xingming;
@property (weak, nonatomic) IBOutlet UITextField *lxdianhua;
@property (weak, nonatomic) IBOutlet UITextField *lxdiqu;
@property (weak, nonatomic) IBOutlet UITextField *lxdizhi;





@property (weak, nonatomic) IBOutlet UIButton *shi;
@property (weak, nonatomic) IBOutlet UIButton *fou;
- (IBAction)Yes:(id)sender;
- (IBAction)No:(id)sender;

@property (nonatomic,strong) NSArray *selections; //!< 选择的三个下标
@property (nonatomic,copy) NSString *pushAddress; //!< 展示的地址
@end
