//
//  MainTableViewController.h
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/18.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

- (IBAction)Attendance:(id)sender;
- (IBAction)Notice:(id)sender;
- (IBAction)Advisory:(id)sender;
- (IBAction)Help:(id)sender;
- (IBAction)Appraise:(id)sender;
- (IBAction)Diary:(id)sender;
- (IBAction)Myself:(id)sender;
- (IBAction)Set:(id)sender;

@end
