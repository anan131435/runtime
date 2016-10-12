//
//  ViewController.m
//  Runtime
//
//  Created by 韩志峰 on 2016/10/10.
//  Copyright © 2016年 韩志峰. All rights reserved.
//

#import "ViewController.h"
#import "DicToModel.h"
#import "Status.h"
#import "Person.h"
#import "Dog.h"
#import "NSObject+Property.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString *fileString = [[NSBundle mainBundle] pathForResource:@"han.plist" ofType:nil];
//    NSArray *dictArray = [NSArray arrayWithContentsOfFile:fileString];
//    NSMutableArray *statusArray = [[NSMutableArray alloc] init];
//    for (NSDictionary *dict in dictArray) {
//        Status *status = [Status createModelWithDict:dict];
//        [statusArray addObject:status];
//    }
//    NSLog(@"%@",statusArray);
//    UIImage *image = [UIImage imageNamed:@"hah"];
//    NSLog(@"%@",image);
    /*
    Person *person = [[Person alloc] init];
    //没有声明实现eat方法调用会报错，动态的添加不会报错
    [person performSelector:@selector(eat)];
    Dog *dog = [[Dog alloc] init];
    [dog performSelector:@selector(run:) withObject:@10];
     */
    NSObject *status = [[NSObject alloc] init];
    
    status.name = @"hanzhifeng";
    NSLog(@"name：%@",status.name);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
