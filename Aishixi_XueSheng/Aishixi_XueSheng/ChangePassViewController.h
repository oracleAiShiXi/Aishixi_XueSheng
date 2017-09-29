//
//  ChangePassViewController.h
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/29.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePassViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *oldPass;
@property (weak, nonatomic) IBOutlet UITextField *mewPass;
@property (weak, nonatomic) IBOutlet UITextField *rePass;
- (IBAction)Sure:(id)sender;

@end
