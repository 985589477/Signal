//
//  LXSingle.m
//  LXSingle
//
//  Created by iOS on 2018/11/12.
//  Copyright © 2018 Jason. All rights reserved.
//

#import "LXSignal.h"
#import "NSObject+Signal.h"
#import "LXSignalGroup.h"

@interface LXSignal ()

@property (nonatomic,copy) FinishBlock finish;

@property (nonatomic,strong) NSMutableArray<NextBlock> *nextArray;

@end

@implementation LXSignal

+ (instancetype)createSingle:(SignalBlock)task{
    LXSignal *single = [[self class] new];
    single.task = task;
    return single;
}

- (void)sendSingle:(id)result{
    self.result = result;
    if (self.finish && self.nextArray.count == 0) {
        self.finish(result);
    }
    if (self.nextArray.count > 0) {
        NextBlock block = self.nextArray.firstObject;
        [self.nextArray removeObjectAtIndex:0];
        block(self, self.result);
    }
}

- (LXSignal *)doNext:(NextBlock)next{
    [self.nextArray addObject:next];
    return self;
}

- (void)finish:(FinishBlock)finish{
    _finish = finish;
    if (self.task) {
        self.task(self);
    }
}

- (NSMutableArray *)nextArray{
    if (!_nextArray) {
        _nextArray = [NSMutableArray array];
    }
    return _nextArray;
}

@end
