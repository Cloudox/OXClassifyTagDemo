//
//  OXClassifyHeaderView.h
//  OXClassifyTagDemo
//
//  Created by Cloudox on 2017/4/19.
//  Copyright © 2017年 Cloudox. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OXClassifyHeaderViewDelegate <NSObject>

// 打开或关闭section
- (void)changeSectionState:(BOOL)oldState sectionIndex:(NSInteger)index;

@end

@interface OXClassifyHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)titleName number:(NSInteger)number isShow:(BOOL)isShow sectionIndex:(NSInteger)index;

@property (nonatomic, weak) id<OXClassifyHeaderViewDelegate> delegate;

@end
