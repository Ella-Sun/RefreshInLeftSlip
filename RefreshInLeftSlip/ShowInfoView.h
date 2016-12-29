//
//  ShowInfoView.h
//  RefreshInLeftSlip
//
//  Created by sunhong on 2016/12/29.
//  Copyright © 2016年 sunhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowInfoView : UIView

/**
 跳转到新界面
 */
@property (nonatomic, copy) void(^JumpToNewBlock)();

@end
