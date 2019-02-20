//
//  KBTextureViewController.m
//  KBStudy
//
//  Created by 韩金波 on 2019/2/18.
//  Copyright © 2019 韩金波. All rights reserved.
//

#import "KBTextureViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "KBTetureCell.h"
@interface KBTextureViewController ()<ASTableDelegate,ASTableDataSource>
@property (nonatomic, strong)ASTableNode *tableNode;
@end



@implementation KBTextureViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tableNode = [ASTableNode new];
        _tableNode.dataSource = self;
        _tableNode.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubnode:_tableNode];
    self.view.backgroundColor = [UIColor whiteColor];
    
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _tableNode.frame = self.view.bounds;

}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section;
{
    return 100;
}
-(ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ^ASCellNode * (){
        return [KBTetureCell new]; 
    };
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
