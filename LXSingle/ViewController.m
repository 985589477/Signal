//
//  ViewController.m
//  LXSingle
//
//  Created by iOS on 2018/11/12.
//  Copyright © 2018 Jason. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Signal.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self signalQueue];
}

- (void)signalQueue{

    [[[[LXSignal createSingle:^(id<LXSubscriber> subscriber) {
        NSLog(@"我开始走了");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendSingle:@"1"];
        });
    }] doNext:^(id<LXSubscriber> subscriber, id result) {
        NSLog(@"接受上一结果%@",result);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendSingle:@"2"];
        });
    }] doNext:^(id<LXSubscriber> subscriber, id result) {
        NSLog(@"接受上一结果%@",result);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendSingle:@"3"];
        });
    }] finish:^(id result) {
        NSLog(@"最终结果%@",result);
    }];
    NSLog(@"我先下去了，拜拜");
}

/**测试信号组*/
- (void)signalGroup{
    LXSignal *signal1 = [LXSignal createSingle:^(id<LXSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendSingle:nil];
        });
    }];
    LXSignal *signal2 = [LXSignal createSingle:^(id<LXSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendSingle:@"2"];
        });
    }];
    LXSignal *signal3 = [LXSignal createSingle:^(id<LXSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendSingle:@"3"];
        });
    }];
    
    [self singleWithSelector:@[signal1,signal2,signal3] target:self notificationSelector:@selector(run:param2:param3:)];
    
    NSLog(@"我就先下去了，拜拜");
}

- (void)run:(id)param1 param2:(id)param2 param3:(id)param3{
    if (param1 == nil) {
        NSLog(@"param1传入的是nil");
    }
    NSLog(@"我跑了,%@,%@,%@",param1,param2,param3);
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self destructionSignal];
}

- (void)dealloc{
    NSLog(@"我释放了");
}

@end
