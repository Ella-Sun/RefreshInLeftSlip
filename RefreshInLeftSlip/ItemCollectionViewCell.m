//
//  ItemCollectionViewCell.m
//  RefreshInLeftSlip
//
//  Created by sunhong on 2016/12/29.
//  Copyright © 2016年 sunhong. All rights reserved.
//

#import "ItemCollectionViewCell.h"

static CGFloat iconPercent = 0.95;

@interface ItemCollectionViewCell ()

//头像
@property (nonatomic, weak) UIView * iconView;
//名称
@property (nonatomic, weak) UILabel * nameLabel;

@end

@implementation ItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupDefaultViews];
        [self setNeedsLayout];
    }
    return self;
}

- (void)setupDefaultViews
{
    //图标
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectZero];
    iconView.backgroundColor = [UIColor orangeColor];
    iconView.userInteractionEnabled = NO;
    iconView.layer.cornerRadius = kItemWidth * iconPercent * 0.5;
    iconView.layer.masksToBounds = YES;
    [self addSubview:iconView];
    self.iconView = iconView;
    
    //姓名
    UILabel *nameLabel = [self generalCommonLabel];
    nameLabel.text = @"马走日";
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
}

- (UILabel *)generalCommonLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12.f];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
    return label;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //图标
    CGFloat iconWidth = kItemWidth * iconPercent;
    CGFloat iconX = (kItemWidth - iconWidth) * 0.5;
    CGFloat iconY = (kItemWidth - iconWidth) * 0.5;
    CGRect iconFrame = CGRectMake(iconX, iconY, iconWidth, iconWidth);
    self.iconView.frame = iconFrame;
    
    CGFloat labelH = 15.f;
    CGFloat labelspace = 10.f;
    CGFloat labelY = kItemHeight - labelH - labelspace;
    //姓名
    CGRect nameFrame = CGRectMake(0, labelY, kItemWidth, labelH);
    self.nameLabel.frame = nameFrame;
    
}

@end
