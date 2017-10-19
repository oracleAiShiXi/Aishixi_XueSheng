//
//  AdvisoryInfoViewController.h
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvisoryInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *zixuntime;
@property (weak, nonatomic) IBOutlet UILabel *reporttime;
@property (weak, nonatomic) IBOutlet UILabel *consulname;
@property (weak, nonatomic) IBOutlet UILabel *reportname;
@property (weak, nonatomic) IBOutlet UILabel *context;
@property (weak, nonatomic) IBOutlet UILabel *reportcont;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIView *viewss;



@property (strong, nonatomic) NSString *ConsulId;
@property (strong, nonatomic) NSString *status;
@end
