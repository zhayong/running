//
//  ZYTableViewCell.m
//  Running
//
//  Created by Zhayong on 20/03/2017.
//  Copyright © 2017 Zha Yong. All rights reserved.
//

#import "ZYTableViewCell.h"

@implementation ZYTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
