//
//  EditAdvisoryViewController.h
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/20.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditAdvisoryViewController : UIViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *gangwei;
@property (weak, nonatomic) IBOutlet UIButton *qingjia;
@property (weak, nonatomic) IBOutlet UIButton *qita;

@property (weak, nonatomic) IBOutlet UIButton *edit;
@property (weak, nonatomic) IBOutlet UIButton *fabu;

@property (weak, nonatomic) IBOutlet UITextView *textview;
- (IBAction)Post:(id)sender;
- (IBAction)Leave:(id)sender;
- (IBAction)Other:(id)sender;


- (IBAction)Edit:(id)sender;

- (IBAction)Publish:(id)sender;

@end
