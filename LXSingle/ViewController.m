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

/** */
@property (nonatomic,strong) NSString *name;

/** */
@property (nonatomic,copy) void(^block)(void);

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    LXSignal *single1 = [LXSignal createSingle:^(id<LXSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendSingle:nil];
        });
    }];
    LXSignal *single2 = [LXSignal createSingle:^(id<LXSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendSingle:@"2"];
        });
    }];
    LXSignal *single3 = [LXSignal createSingle:^(id<LXSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendSingle:@"3"];
        });
    }];
    
    [self singleWithSelector:@[single1,single2,single3] target:self notificationSelector:@selector(run:param2:param3:)];
//
    NSLog(@"我就先下去了，拜拜");
}

- (void)run:(id)param1 param2:(id)param2 param3:(id)param3{
    if (param1 == nil) {
        NSLog(@"param1传入的是nil");
    }
    NSLog(@"我跑了,%@,%@,%@",param1,param2,param3);
}


- (void)dealloc{
    NSLog(@"我释放了");
}

@end
