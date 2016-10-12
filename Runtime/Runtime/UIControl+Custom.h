//
//  UIControl+Custom.h
//  Runtime
//
//  Created by 韩志峰 on 2016/10/10.
//  Copyright © 2016年 韩志峰. All rights reserved.
//

#import <UIKit/UIKit.h>
/** runtime 解决点击按钮重复跳转*/
@interface UIControl (Custom)
@property (nonatomic, assign) NSTimeInterval custom_acceptEventInterval;
@end
