//
//  UIImage+Image.m
//  Runtime
//
//  Created by 韩志峰 on 2016/10/12.
//  Copyright © 2016年 韩志峰. All rights reserved.
//

#import "UIImage+Image.h"
#import <objc/message.h>
/*
 runtime 的作用：
 1.发送消息
   方法调用的本质就是让对象发送消息 使用消息机制的前提是导入#import <objc/message.h>
   在.h没有声明某个私有方法，通过runtime的objc_msgSend方法也能够调用到私有方法
 2.交换方法
 
 */

@implementation UIImage (Image)
//只执行一次   加载分类到内存的时候调用
+(void)load{
    // 交换方法
    //获取imageWithName方法地址,找到selector对应的方法的实现
    Method imageWithName = class_getClassMethod(self, @selector(imageWithName:));
    Method imageName = class_getClassMethod(self, @selector(imageNamed:));
    //交互方法地址，相当于交换实现方式 外界调用imagenamed相当于调用imageWithName
    method_exchangeImplementations(imageWithName, imageName);
}
+(instancetype)imageWithName:(NSString *)name{
    //这里调用imageWithName相当于调用imageName
    UIImage *image = [UIImage imageWithName:name];
    if (!image) {
        NSLog(@"加载的空图片");
    }else{
        NSLog(@"图片加载成功");
    }
    return image;
}


@end
