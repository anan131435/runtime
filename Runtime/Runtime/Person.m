//
//  Person.m
//  Runtime
//
//  Created by 韩志峰 on 2016/10/12.
//  Copyright © 2016年 韩志峰. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
@implementation Person
//默认方法都有两个隐式参数
void eat(id self,SEL sel){
    
    NSLog(@"%@ %@",self,NSStringFromSelector(sel));
    NSLog(@"吃东西");
}
//当一个对象调用未实现的方法，会调用这个方法处理，并且把对应的方法列表传过来
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(eat)) {
        class_addMethod(self, @selector(eat), (IMP)eat, "V@:");
    }
    return [super resolveInstanceMethod:sel];
}
@end
