//
//  DicToModel.h
//  Runtime
//
//  Created by 韩志峰 on 2016/10/10.
//  Copyright © 2016年 韩志峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(DicToModel)
+(instancetype)createModelWithDict:(NSDictionary *)dict;
@end
