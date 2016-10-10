//
//  DicToModel.m
//  Runtime
//
//  Created by 韩志峰 on 2016/10/10.
//  Copyright © 2016年 韩志峰. All rights reserved.
//

#import "DicToModel.h"
#import <objc/message.h>
@implementation NSObject(DicToModel)
+ (instancetype)createModelWithDict:(NSDictionary *)dict{
    //创建对应的类对象
    id model = [[self alloc] init];
    //runtime:遍历模型中所有成员属性，去字典中查找。属性定义在类，类里面有个属性列表
    //遍历模型所有成员属性
    //ivar 成员属性 class_copyIvarList：成员属性列表复制一份
    //Ivar *指向Ivar指针
    // count：成员属性总数
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        //获取成员属性
        Ivar ivar = ivarList[i];
        //获取成员名
        NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //获取key
        NSString *key = [propertyName substringFromIndex:1];
        //user value:字典
        //获取字典的value
        id value = dict[key];
        
        //成员属性类型
        NSString *propertyType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        //二级转换
        //值是字典，成员属性的类型不是字典，才需要转换为模型
        if ([value isKindOfClass:[NSDictionary class]] && ![propertyType containsString:@"NSDictionary"]) {//需要字典转换为模型
            //截取类名字符串
            NSRange range = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringFromIndex:range.location + range.length];
            range = [propertyType rangeOfString:@"\""];
            propertyType = [propertyType substringToIndex:range.location];
            //获取需要转换类的类对象
            Class modelClass = NSClassFromString(propertyType);
            if (modelClass) {
                value = [modelClass createModelWithDict:value];
            }
            
        }
        //KVC赋值不能传空
        if (value) {
            [model setValue:value forKey:key];
        }
    }
    return model;
}
@end
