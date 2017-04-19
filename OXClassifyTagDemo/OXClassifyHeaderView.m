//
//  OXClassifyHeaderView.m
//  OXClassifyTagDemo
//
//  Created by Cloudox on 2017/4/19.
//  Copyright © 2017年 Cloudox. All rights reserved.
//

#import "OXClassifyHeaderView.h"

//根据十六进制数来设置颜色
#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// block解决循环引用
#define WeakSelf   __typeof(&*self) __weak weakSelf = self;
#define StrongSelf __typeof(&*self) __strong strongSelf = weakSelf;

@interface OXClassifyHeaderView()

@property BOOL isRowDown;
@property (nonatomic, strong) UIButton *rowBtn;
@property NSInteger index;// 节序号

@end

@implementation OXClassifyHeaderView

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)titleName number:(NSInteger)number isShow:(BOOL)isShow sectionIndex:(NSInteger)index {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kUIColorFromRGB(0xFA7777);
        
        self.isRowDown = isShow;
        self.index = index;
        
        // 回形针图片
        UIImageView *titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, 11, 18, 18)];
        titleImg.image = [UIImage imageNamed:@"ic_classify_title"];
        [self addSubview:titleImg];
        
        // 标题文字
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 200, 20)];
        titleLabel.text = titleName;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:titleLabel];
        
        // 数量
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 80, 11, 40, 18)];
        numberLabel.text = [NSString stringWithFormat:@"(%ld)", (long)number];
        numberLabel.textColor = [UIColor whiteColor];
        numberLabel.font = [UIFont systemFontOfSize:14];
        numberLabel.textAlignment = NSTextAlignmentRight;
        numberLabel.alpha = isShow ? 1.0 : 0.0;
        [self addSubview:numberLabel];
        
        // 下拉按钮
        self.rowBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 32, 10, 20, 20)];
        [self.rowBtn setImage:[UIImage imageNamed:@"ic_classify_down_row"] forState:UIControlStateNormal];
        if (!self.isRowDown) {// 应该向左
            self.rowBtn.transform = CGAffineTransformMakeRotation(-M_PI/2);
        }
        [self.rowBtn addTarget:self action:@selector(changeRow) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rowBtn];
    }
    return self;
}

// 动画改变箭头方向
- (void)changeRow {
    BOOL oldState = self.isRowDown;
    
    WeakSelf
    [UIView animateWithDuration:0.2 animations:^{
        StrongSelf
        if (strongSelf) {
            if (strongSelf.isRowDown) {// 当前是向下的
                strongSelf.rowBtn.transform = CGAffineTransformMakeRotation(-M_PI/2);
                strongSelf.isRowDown = NO;
            } else {// 当前是向右的
                strongSelf.rowBtn.transform = CGAffineTransformMakeRotation(0);
                strongSelf.isRowDown = YES;
            }
        }
    }];
    
    // 延迟执行
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        StrongSelf
        if (strongSelf) {
            // 传递消息
            if ([strongSelf.delegate respondsToSelector:@selector(changeSectionState:sectionIndex:)]) {
                [strongSelf.delegate changeSectionState:oldState sectionIndex:strongSelf.index];
            }
        }
    });
}

@end
