//
//  UIControl+Custom.m
//  Runtime
//
//  Created by 韩志峰 on 2016/10/10.
//  Copyright © 2016年 韩志峰. All rights reserved.
//

#import "UIControl+Custom.h"
#import <objc/runtime.h>
NSString *acceptEventInterval = @"UIControl_acceptEventInterval";
NSString *acceptEventTime = @"UIControl_acceptEventTime";
@interface UIControl ()
@property (nonatomic, assign) NSTimeInterval custom_acceptEventTime;
@end

@implementation UIControl (Custom)//实现方法交换，先添加方法，方法存在则替换原方法
+ (void)load{
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));//类里面由selector得到方法的实现
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    Method customMethod = class_getInstanceMethod(self, @selector(custom_sendAction:to:forEvent:));
    SEL customSEL = @selector(custom_sendAction:to:forEvent:);
    //cls 被添加方法的类，被添加的方法的名称，被添加方法的实现函数，被添加方法的实现函数的返回值类型和参数类型的字符串
    //class_addMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>, <#IMP imp#>, <#const char *types#>)
    BOOL didAddMethod = class_addMethod(self, customSEL, method_getImplementation(customMethod), method_getTypeEncoding(systemMethod));
    
    if (didAddMethod) {
        class_replaceMethod(self, customSEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(systemMethod, customMethod);
    }
    //iOS方法调用流程
    //方法调用的核心是objc_msgSend方法
//    objc_msgSend(recevier,selector,arg1,arg2) 先找到selector对应方法的实现(IMP),
    // 2.找不到时方法返回_objc_msgForward对象，转入消息转发流程
    //3.将IMP的返回值作为自己的返回值
    //补充： 当消息发送给一个对象时，objc_msgSend通过对象的ISA指针获取到类的结构体，然后在cache和methodList里面查找，没有找到就找其父类，以此类推直到NSObject类，如果没有找到就走消息转发流程
//     class_getMethodImplementation(<#__unsafe_unretained Class cls#>, <#SEL name#>)
    //消息转发流程 从上文我们看出当obj无法查找IMP时，会返回一个特定的IMP _objc_msgForward 然后进入消息转发流程，具体流程如下
    /*
     1.动态方法解析
     resolveInstanceMethod:解析实例方法
     resolveClassMethod:解析类方法
     通过class_addMethod的方式将缺少的selector动态创建出来，前提是有实现好的IMP（method_types一致）
     [object message] 一个消息发送给对象时，objc_msgSend 通过对象的isa指针找到类的结构体，cache methodlist imp
     */
}
- (NSTimeInterval)custom_acceptEventInterval{
    
    return [objc_getAssociatedObject(self, "UIControl_acceptEventInterval") doubleValue];
}
- (void)setCustom_acceptEventInterval:(NSTimeInterval)custom_acceptEventInterval{
    objc_setAssociatedObject(self, "UIControl_acceptEventInterval", @(custom_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)custom_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.custom_acceptEventTime >= self.custom_acceptEventInterval);
    if (needSendAction) {
        [self custom_sendAction:action to:target forEvent:event];
    }
}
@end
