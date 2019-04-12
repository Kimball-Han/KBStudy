//
//  KBEventCalendarView.m
//  KBStudy
//
//  Created by 韩金波 on 2019/4/12.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBEventCalendarView.h"
#import "KBCalendarMonthCell.h"

@interface KBEventCalendarView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * calendar;

@property (nonatomic, copy) NSString * reuseIdentifier;


@end

@implementation KBEventCalendarView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat itemWidth = screenWidth/7;
    CGFloat lineSpacing = 10;
    CGFloat calendarHeight = itemWidth * 6 + lineSpacing * 5;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize  = CGSizeMake(screenWidth, calendarHeight);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    
    Class cellClass = [KBCalendarMonthCell class];
    self.reuseIdentifier = NSStringFromClass(cellClass);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, screenWidth, calendarHeight) collectionViewLayout:flowLayout];
    [collectionView registerClass:cellClass forCellWithReuseIdentifier:self.reuseIdentifier];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self addSubview:collectionView];
    _calendar = collectionView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KBCalendarMonthCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.reuseIdentifier forIndexPath:indexPath];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

@end
