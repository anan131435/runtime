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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *fileString = [[NSBundle mainBundle] pathForResource:@"han.plist" ofType:nil];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:fileString];
    NSMutableArray *statusArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in dictArray) {
        Status *status = [Status createModelWithDict:dict];
        [statusArray addObject:status];
    }
    NSLog(@"%@",statusArray);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
