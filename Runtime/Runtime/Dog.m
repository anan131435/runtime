//
//  Dog.m
//  Runtime
//
//  Created by 韩志峰 on 2016/10/12.
//  Copyright © 2016年 韩志峰. All rights reserved.
//

#import "Dog.h"
#import <objc/runtime.h>
@implementation Dog
void aaa(id self,SEL _cmd,NSNumber *meter){
    NSLog(@"跑了%@",meter);
}
+(BOOL)resolveInstanceMethod:(SEL)sel{
    
    if (sel == @selector(run:)) {
        class_addMethod(self, sel, (IMP)aaa, "V@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
@end
