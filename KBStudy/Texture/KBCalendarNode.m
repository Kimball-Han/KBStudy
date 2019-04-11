//
//  KBCalendarNode.m
//  KBStudy
//
//  Created by 韩金波 on 2019/4/8.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBCalendarNode.h"
#import <FSCalendar.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>
@interface KBCalendarNode()

@property (nonatomic, strong) ASButtonNode *preButtonNode;

@property (nonatomic, strong) ASButtonNode *nextButtonNode;

@property (nonatomic, strong) ASTextNode *monthTextNode;

@property (nonatomic, strong) NSArray <ASButtonNode *> * dateNodeArray;

@property (nonatomic, weak) FSCalendar * calendar;

@property (nonatomic, strong) ASDisplayNode * calendarNode;

@end

@implementation KBCalendarNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadSubnodes];
    }
    return self;
}
-(void)loadSubnodes{
    self.automaticallyManagesSubnodes = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    self.preButtonNode = [[ASButtonNode alloc] init];
    [self.preButtonNode setImage:[UIImage imageNamed:@"pre"] forState:UIControlStateNormal];
    [self.preButtonNode setImage:[UIImage imageNamed:@"pre"] forState:UIControlStateDisabled];

    self.nextButtonNode = [[ASButtonNode alloc] init];
    [self.nextButtonNode setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    
    self.monthTextNode = [[ASTextNode alloc] init];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.calendarNode = [[ASDisplayNode alloc]initWithViewBlock:^UIView * _Nonnull{
        FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0,screenWidth, 241)];
        calendar.headerHeight = 0;
        calendar.weekdayHeight = 34;
        calendar.placeholderType = FSCalendarPlaceholderTypeFillHeadTail;
        calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
        calendar.backgroundColor = [UIColor whiteColor];
        calendar.clipsToBounds = YES;
        
//        calendar.appearance.weekdayTextColor = UIColorHex(0x666666);
        calendar.appearance.weekdayFont = [UIFont systemFontOfSize:12.0];
        
//        calendar.appearance.titleTodayColor = UIColorHex(0xFF2661);
        calendar.appearance.todayColor = [UIColor whiteColor];
        
        calendar.appearance.titleFont  = [UIFont boldSystemFontOfSize:14.0];
        calendar.appearance.titleSelectionColor = [UIColor whiteColor];
//        calendar.appearance.titleDefaultColor = UIColorHex(0x262626);
//        calendar.appearance.titlePlaceholderColor = UIColorHex(0x999999);
//        calendar.appearance.selectionColor =  UIColorHex(0xFF2661);
        
        calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
        calendar.appearance.separators = FSCalendarSeparatorNone;
        
//        calendar.dataSource = self;
//        calendar.delegate = self;

        return calendar;
    }];
}

//-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
//    
//}


@end
