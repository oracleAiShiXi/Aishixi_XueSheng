//
//  maincellTableViewCell.m
//  Aishixi_XueSheng
//
//  Created by newmac on 2017/9/19.
//  Copyright © 2017年 GuoYun. All rights reserved.
//

#import "maincellTableViewCell.h"

@implementation maincellTableViewCell
@synthesize userImage = _userImage;
@synthesize TitleLabel = _TitleLabel;
@synthesize TimeLabel = _TimeLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
