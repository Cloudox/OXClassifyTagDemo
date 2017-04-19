//
//  ViewController.m
//  OXClassifyTagDemo
//
//  Created by Cloudox on 2017/4/19.
//  Copyright © 2017年 Cloudox. All rights reserved.
//

#import "ViewController.h"
#import "OXClassifyHeaderView.h"
#import "OXTagModel.h"

//根据十六进制数来设置颜色
#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 设备的宽高
#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, OXClassifyHeaderViewDelegate>

@property (nonatomic, strong) NSMutableArray *tagArray;// 指标数组

@property (nonatomic, strong) UITableView *tableView;// 列表
@property (nonatomic, strong) NSMutableArray *firstArray;// 一级指标数组
@property (nonatomic, strong) NSMutableArray *secondArray;// 二级指标数组
@property (nonatomic, strong) NSMutableArray *thirdArray;// 三级指标数组
@property (nonatomic, strong) NSMutableArray *isShowEachContent;// 是否显示各级指标内容，1表示显示，0表示不显示

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分类指标";
    self.view.backgroundColor = kUIColorFromRGB(0xFA7777);
    
    self.tagArray = [[NSMutableArray alloc] init];
    self.firstArray = [[NSMutableArray alloc] init];
    self.secondArray = [[NSMutableArray alloc] init];
    self.thirdArray = [[NSMutableArray alloc] init];
    self.isShowEachContent = [[NSMutableArray alloc] initWithObjects:@1, @0, @0, nil];
    
    [self initData];// 测试数据
    
    [self initTableView];// 初始化列表
}

// 测试数据
- (void)initData {
    OXTagModel *tagModel1 = [[OXTagModel alloc] init];
    tagModel1.tagName = @"文学";
    tagModel1.isLeaf = NO;
    OXTagModel *tagModel2 = [[OXTagModel alloc] init];
    tagModel2.tagName = @"中国文学";
    tagModel2.isLeaf = NO;
    OXTagModel *tagModel4 = [[OXTagModel alloc] init];
    tagModel4.tagName = @"古文学";
    tagModel4.isLeaf = YES;
    OXTagModel *tagModel5 = [[OXTagModel alloc] init];
    tagModel5.tagName = @"小说文学";
    tagModel5.isLeaf = YES;
    tagModel2.children = [[NSMutableArray alloc] initWithObjects:tagModel4, tagModel5, nil];
    OXTagModel *tagModel3 = [[OXTagModel alloc] init];
    tagModel3.tagName = @"外国文学";
    tagModel3.isLeaf = NO;
    OXTagModel *tagModel6 = [[OXTagModel alloc] init];
    tagModel6.tagName = @"戏剧";
    tagModel6.isLeaf = YES;
    tagModel3.children = [[NSMutableArray alloc] initWithObjects:tagModel6, nil];
    tagModel1.children = [[NSMutableArray alloc] initWithObjects:tagModel2, tagModel3, nil];
    [self.tagArray addObject:tagModel1];
    
    [self.firstArray addObjectsFromArray:self.tagArray];
}

// 初始化列表
- (void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SCREENWIDTH, SCREENHEIGHT)];
    self.tableView.backgroundColor = kUIColorFromRGB(0xECE7E5);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];// 去除多余的列表线条
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *titleName = @"";
    NSInteger number = 0;
    switch (section) {
        case 0:
            titleName = @"一级指标";
            number = [self.firstArray count];
            break;
            
        case 1:
            titleName = @"二级指标";
            number = [self.secondArray count];
            break;
            
        case 2:
            titleName = @"三级指标";
            number = [self.thirdArray count];
            break;
            
        default:
            break;
    }
    OXClassifyHeaderView *classifyHeader = [[OXClassifyHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40) withTitle:titleName number:number isShow:[[self.isShowEachContent objectAtIndex:section] isEqualToNumber:@1] sectionIndex:section];
    classifyHeader.delegate = self;
    return classifyHeader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger number = 0;
    if ([[self.isShowEachContent objectAtIndex:section] isEqualToNumber:@1]) {
        switch (section) {
            case 0:
                number = [self.firstArray count];
                break;
                
            case 1:
                number = [self.secondArray count];
                break;
                
            case 2:
                number = [self.thirdArray count];
                break;
                
            default:
                break;
        }
    }
    
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *SimpleCell = @"SimpleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SimpleCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SimpleCell];
    }
    
    switch (indexPath.section) {
        case 0:
        {
            OXTagModel *tagModel = (OXTagModel *)[self.firstArray objectAtIndex:indexPath.row];
            cell.textLabel.text = tagModel.tagName;
            break;
        }
            
        case 1:
        {
            OXTagModel *tagModel = (OXTagModel *)[self.secondArray objectAtIndex:indexPath.row];
            cell.textLabel.text = tagModel.tagName;
            break;
        }
            
        case 2:
        {
            OXTagModel *tagModel = (OXTagModel *)[self.thirdArray objectAtIndex:indexPath.row];
            cell.textLabel.text = tagModel.tagName;
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 选中后取消选中的颜色
    
    // 已选的标记颜色
    for (int i = 0; i < [tableView numberOfRowsInSection:indexPath.section]; i++) {
        NSUInteger index[] = {indexPath.section, i};
        NSIndexPath *tempIndexPath = [[NSIndexPath alloc] initWithIndexes:index length:2];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:tempIndexPath];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = kUIColorFromRGB(0xFA7777);
    
    // 选中后的操作
    switch (indexPath.section) {
        case 0:
            [self chooseTag:[self.firstArray objectAtIndex:indexPath.row] atIndex:indexPath.section];
            break;
            
        case 1:
            [self chooseTag:[self.secondArray objectAtIndex:indexPath.row] atIndex:indexPath.section];
            break;
            
        default:
            break;
    }
}

// 选择某个指标
- (void)chooseTag:(OXTagModel *)tagModel atIndex:(NSInteger)sectionIndex  {
    if (!tagModel.isLeaf) {// 还有子节点
        switch (sectionIndex) {
            case 0:
                [self.secondArray removeAllObjects];
                [self.secondArray addObjectsFromArray:tagModel.children];
                break;
                
            case 1:
                [self.thirdArray removeAllObjects];
                [self.thirdArray addObjectsFromArray:tagModel.children];
                break;
                
            default:
                break;
        }
        // 打开下一个section
        if (sectionIndex < 2) {
            [self.isShowEachContent replaceObjectAtIndex:sectionIndex+1 withObject:@1];
            [self.tableView reloadData];
        }
    } else {// 没有子节点，收起下面的section
        for (int i = (int)sectionIndex+1; i < [self.isShowEachContent count]; i++) {
            [self.isShowEachContent replaceObjectAtIndex:i withObject:@0];
        }
        [self.tableView reloadData];
    }
}

#pragma mark - OXClassifyHeaderView Delegate
// 打开或关闭一个指标体系
- (void)changeSectionState:(BOOL)oldState sectionIndex:(NSInteger)index {
    if (oldState) {// 要执行关闭操作，则关闭下属所有section
        for (int i = (int)index; i < [self.isShowEachContent count]; i++) {
            [self.isShowEachContent replaceObjectAtIndex:i withObject:@0];
        }
    } else {// 要执行打开操作，则检查上一个section是否已打开
        if (index == 0 || [self.isShowEachContent[index-1] isEqualToNumber:@1]) {
            [self.isShowEachContent replaceObjectAtIndex:index withObject:@1];
        }
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
