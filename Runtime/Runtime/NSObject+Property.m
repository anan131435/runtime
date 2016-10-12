//
//  NSObject+Property.m
//  Runtime
//
//  Created by 韩志峰 on 2016/10/12.
//  Copyright © 2016年 韩志峰. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>
//定义关联的key
static const char *key = "name";

@implementation NSObject (Property)
- (void)setName:(NSString *)name{
    objc_setAssociatedObject(self, &key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)name{
    return objc_getAssociatedObject(self, &key);
}
@end
