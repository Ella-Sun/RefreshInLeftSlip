//
//  ShowInfoView.m
//  RefreshInLeftSlip
//
//  Created by sunhong on 2016/12/29.
//  Copyright © 2016年 sunhong. All rights reserved.
//

#import "ShowInfoView.h"

#import "ItemCollectionViewCell.h"
#import "RefreshView.h"

#define RefreshColor [UIColor orangeColor]

static NSString *identifier = @"CollectionView";
static CGFloat LeftSpace = 20.f;
static CGFloat ItemMinSpace = 15.f;
//static NSInteger maxItemCount = 10;

@interface ShowInfoView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView * collView;

@property (nonatomic, weak) UIView * showView;
@property (nonatomic, weak) RefreshView * refreshView;
@property (nonatomic, weak) UILabel * alertLabel;


@end

@implementation ShowInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //展示视图
        [self setupMainView];
        //刷新视图
        [self setupRefreshView];
    }
    return self;
}

- (void)setupRefreshView
{
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat showHeight = kItemHeight;
    CGFloat showWidth = 11.f;
    CGFloat showY = (viewHeight - showHeight) * 0.5;
    CGRect showFrame = CGRectMake(viewWidth, showY, showWidth, showHeight);
    UIView *showView = [[UIView alloc] initWithFrame:showFrame];
    showView.backgroundColor = RefreshColor;
    [self addSubview:showView];
    self.showView = showView;
    
    CGFloat rWidth = 1;
    CGFloat rHeight = showHeight;
    CGFloat xPixel = 0;
    CGFloat yPixel = 0;
    CGRect refreshFrame = CGRectMake(xPixel, yPixel, rWidth, rHeight);
    RefreshView *aView = [[RefreshView alloc]initWithFrame:refreshFrame];
    [showView addSubview:aView];
    self.refreshView = aView;
    
    aView.trackColor = RefreshColor;
    aView.progress= 0.0;
    
    CGRect titleFrame = CGRectMake(-2, 0, showWidth, showHeight);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"查看更多";
    titleLabel.numberOfLines = 4;
    titleLabel.font = [UIFont systemFontOfSize:10.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [showView addSubview:titleLabel];
    self.alertLabel = titleLabel;
}

- (void)setupMainView
{
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat collY = (viewHeight - kItemHeight) * 0.5;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置最小行间距
    layout.minimumLineSpacing = ItemMinSpace;
    //设置Cell之间的最小间距
//    layout.minimumInteritemSpacing = 15;
    //设置布局方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGRect frame = CGRectMake(0, collY, viewWidth, kItemHeight);
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    collectionView.contentInset = UIEdgeInsetsMake(0, LeftSpace, 0, 0);
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:collectionView];
    self.collView = collectionView;
    
    //注册
    [self.collView registerClass:[ItemCollectionViewCell class]
       forCellWithReuseIdentifier:identifier];
}

#pragma mark - collectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 设置每个item的大小
    return CGSizeMake(kItemWidth, kItemHeight);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat maxWidth = (kItemWidth + ItemMinSpace) * maxItemCount - ItemMinSpace;//75*10 - 15
//    CGFloat maxOffsetX = maxWidth - self.bounds.size.width;
//    CGFloat shouldOffsetX = maxWidth - maxOffsetX;
    
    CGFloat maxOffsetX = 360.f;
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    CGFloat diffX = offsetX - maxOffsetX;
    CGRect showFrame = self.showView.frame;
    CGRect alertFrame = self.alertLabel.frame;
    
    NSLog(@"%f",diffX);
    //如果未超出最大值 不做操作
    if (diffX <= 10) {
        showFrame.origin.x = self.bounds.size.width;
        self.showView.frame = showFrame;
        alertFrame.origin.x = -1;
        self.alertLabel.frame = alertFrame;
        self.refreshView.progress = 0;
        return;
    }
    
    if (diffX < 15) {
        showFrame.origin.x = self.bounds.size.width - 1;
        self.showView.frame = showFrame;
        alertFrame.origin.x = -2;
        self.alertLabel.frame = alertFrame;
        self.refreshView.progress = 0.03;
        return;
    }
    
    if (diffX < 20) {
        showFrame.origin.x = self.bounds.size.width - 10;
        self.showView.frame = showFrame;
        alertFrame.origin.x = -3;
        self.alertLabel.frame = alertFrame;
        self.refreshView.progress = 0.05;
        return;
    }
    
    if (diffX < 30) {
        alertFrame.origin.x = -5;
        self.alertLabel.frame = alertFrame;
        self.refreshView.progress = diffX * 0.003;
        return;
    }
    
    if (diffX < 40) {
        alertFrame.origin.x = -8;
        self.alertLabel.frame = alertFrame;
        self.refreshView.progress = diffX * 0.005;
        return;
    }
    
    if (diffX < 50) {
        self.refreshView.progress = diffX * 0.007;
        return;
    }
    
    if (self.JumpToNewBlock) {
        self.JumpToNewBlock();
    }
    
    
    //TODO:为啥这俩值不想等 呢？
//    NSLog(@"maxOffsetX:%f",shouldOffsetX);
//    NSLog(@"maxOffsetX:%f",maxOffsetX);
//    NSLog(@"offsetX:%f",offsetX);
}


@end
