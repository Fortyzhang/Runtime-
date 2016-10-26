//
//  ViewController.m
//  runtime对象关联
//
//  Created by zty on 2016/10/25.
//  Copyright © 2016年 zty. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+tyBlock.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *array1 = @[@"1",@"2",@"3"];

    objc_setAssociatedObject(self, @"dictionary123", array1,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn setFrame:CGRectMake(50, 50, 50, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(AlertContro:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *abcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [abcBtn setTitle:@"别摸我" forState:UIControlStateNormal];
    [self.view addSubview:abcBtn];
    [abcBtn setFrame:CGRectMake(250, 50, 50, 50)];
    abcBtn.backgroundColor = [UIColor greenColor];
    abcBtn.zty_block = ^(id sender){
        NSLog(@"%@",sender);
    };
    
    UIButton *bb = [[UIButton alloc] init];
    bb.name = @"runtime属性添加";
    NSLog(@"%@",bb.name);
}

- (void)AlertContro:(UIButton *)button{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你个流氓" message:@"嘿嘿" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"调戏你" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSArray *array1 = objc_getAssociatedObject(self, @"dictionary123");
        NSLog(@"%@",array1[0]);
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"放了你" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"放了你");
    }]];
    
    //取消
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    //    //    [cancel setValue:[UIColor blueColor] forKey:@"_titleTextColor"]; // 修改按钮标题颜色
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

//#import <objc/runtime.h>头文件
//objc_setAssociatedObject需要四个参数：源对象，关键字，关联的对象和一个关联策略。

//1 源对象alert
//2 关键字 唯一静态变量key associatedkey
//3 关联的对象 sender
//4 关键策略  OBJC_ASSOCIATION_ASSIGN
//    enum {
//        OBJC_ASSOCIATION_ASSIGN = 0,           若引用/**< Specifies a weak reference to the associated object. */
//        OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1, /**< Specifies a strong reference to the associated object.
//                                                *   The association is not made atomically. */
//        OBJC_ASSOCIATION_COPY_NONATOMIC = 3,   /**< Specifies that the associated object is copied.
//                                                *   The association is not made atomically. */
//        OBJC_ASSOCIATION_RETAIN = 01401,       /**< Specifies a strong reference to the associated object.
//                                                *   The association is made atomically. */
//        OBJC_ASSOCIATION_COPY = 01403          /**< Specifies that the associated object is copied.
//                                                *   The association is made atomically. */
//    };

//    objc_setAssociatedObject(<#id object#>, <#const void *key#>, <#id value#>, <#objc_AssociationPolicy policy#>)
//把alert和message字符串关联起来，作为alertview的一部分，关键词就是msgstr，之后可以使用objc_getAssociatedObject从alertview中获取到所关联的对象，便可以访问message或者btn了
//    即实现了关联传值


@end
