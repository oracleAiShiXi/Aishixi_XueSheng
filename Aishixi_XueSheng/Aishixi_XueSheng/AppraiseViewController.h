//
//  AppraiseViewController.h
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/25.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppraiseViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *haoping;
@property (weak, nonatomic) IBOutlet UIButton *zhongping;
@property (weak, nonatomic) IBOutlet UIButton *chaping;
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UIButton *edit;
@property (weak, nonatomic) IBOutlet UIButton *fabu;


- (IBAction)Good:(id)sender;

- (IBAction)Mid:(id)sender;

- (IBAction)Bad:(id)sender;

- (IBAction)Edit:(id)sender;

- (IBAction)publist:(id)sender;

@property (strong, nonatomic) NSString *EvaluatEdType;

@end
