//
//  RefreshView.m
//  RefreshInLeftSlip
//
//  Created by sunhong on 2016/12/29.
//  Copyright © 2016年 sunhong. All rights reserved.
//

#import "RefreshView.h"


//static CGFloat layerWidth = 1.f;
@interface RefreshView ()
{
    
    CAShapeLayer *_trackLayer;
    UIBezierPath *_trackPath;
    CAShapeLayer *_progressLayer;
    UIBezierPath *_progressPath;
}

@end

@implementation RefreshView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _trackLayer = [CAShapeLayer new];
        [self.layer addSublayer:_trackLayer];
        _trackLayer.fillColor = [UIColor orangeColor].CGColor;
        _trackLayer.lineCap = kCALineCapRound;
        _trackLayer.frame = self.bounds;
        
        self.progress = 1.0;//默认是1
    }
    return self;
}


-(void)setupBezierPath
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat pathWidth = height * 2 * self.progress;
    CGFloat pathHeight = height;
    CGFloat pathX = (width - pathWidth) * 0.5;
    
    CGFloat pathY = (height - pathHeight) * 0.5;
    CGRect pathFrame = CGRectMake(pathX, pathY, pathWidth, pathHeight);
    
    //贝塞尔曲线
    _trackPath = [UIBezierPath bezierPathWithOvalInRect:pathFrame];
    
    _trackLayer.path = _trackPath.CGPath;
}


-(void)setTrackColor:(UIColor *)trackColor
{
    _trackLayer.strokeColor = trackColor.CGColor;
    _trackLayer.fillColor = trackColor.CGColor;
}

-(void)setProgress:(float)progress
{
    _progress = progress;
    [self setupBezierPath];
}


@end
