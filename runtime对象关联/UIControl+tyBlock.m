//
//  UIControl+tyBlock.m
//  runtime对象关联
//
//  Created by zty on 2016/10/25.
//  Copyright © 2016年 zty. All rights reserved.
//

#import "UIControl+tyBlock.h"
#import <objc/runtime.h>

static const void *ztyUIControlTouchUpEventBlockKey = "ztyUIControlTouchUpEventBlockKey";

@implementation UIControl (tyBlock)

- (void)setZty_block:(ZTYTouchBlock)zty_block{
    
    objc_setAssociatedObject(self, ztyUIControlTouchUpEventBlockKey, zty_block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self removeTarget:self
                action:@selector(ztyAction:)
      forControlEvents:UIControlEventTouchUpInside];
    
    if (zty_block) {
        [self addTarget:self
                 action:@selector(ztyAction:)
       forControlEvents:UIControlEventTouchUpInside];
    }
}

- (ZTYTouchBlock)zty_block{
    
    return objc_getAssociatedObject(self, ztyUIControlTouchUpEventBlockKey);
    
}

- (void)ztyAction:(id)sender{
    ZTYTouchBlock touchBlock = self.zty_block;
    UIButton *button = sender;
    if (touchBlock) {
        touchBlock(button.titleLabel.text);
    }
}



- (void)setName:(NSString *)name{
    objc_setAssociatedObject(self, "name", name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name{
    return objc_getAssociatedObject(self, "name");
}

@end
