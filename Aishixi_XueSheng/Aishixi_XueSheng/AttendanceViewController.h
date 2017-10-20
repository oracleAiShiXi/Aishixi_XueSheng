//
//  AttendanceViewController.h
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendanceViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *Img;
- (IBAction)Attendan:(id)sender;



@property (strong, nonatomic) NSString *jingdu;
@property (strong, nonatomic) NSString *weidu;
@property (strong, nonatomic) NSString *dizhi;


@end
