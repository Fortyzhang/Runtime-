//
//  UIControl+tyBlock.h
//  runtime对象关联
//
//  Created by zty on 2016/10/25.
//  Copyright © 2016年 zty. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ZTYTouchBlock)(id sender);

@interface UIControl (tyBlock)

@property (nonatomic, copy) ZTYTouchBlock zty_block;
@property (nonatomic, strong) NSString *name;
@end
