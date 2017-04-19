//
//  OXTagModel.h
//  OXClassifyTagDemo
//
//  Created by Cloudox on 2017/4/19.
//  Copyright © 2017年 Cloudox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OXTagModel : NSObject

@property (nonatomic, copy) NSString *tagId;// 指标id

@property (nonatomic, copy) NSString *tagName;// 指标名

@property (nonatomic, strong) NSMutableArray *children;// 子指标数组

@property BOOL isLeaf;// 是否是叶子节点（叶子节点没有子指标）

@end
