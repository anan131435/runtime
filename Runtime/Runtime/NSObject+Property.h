//
//  NSObject+Property.h
//  Runtime
//
//  Created by 韩志峰 on 2016/10/12.
//  Copyright © 2016年 韩志峰. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 给系统的类添加属性可以使用runtime动态添加属性的方法  原理：给一个类声明属性，其实本质是给这个类添加关联，并不是知己把这个值的内存空间添加到类的内存空间*/
@interface NSObject (Property)
//属性分类只会生成get set方法声明，不会生成实现，也不会生成下划线成员属性
@property (nonatomic, copy) NSString *name;
@end
