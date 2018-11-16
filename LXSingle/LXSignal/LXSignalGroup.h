//
//  LXSingleGroup.h
//  LXSingle
//
//  Created by iOS on 2018/11/15.
//  Copyright © 2018 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXSignal.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXSignalGroup : NSObject

+ (instancetype)groupWithSingles:(NSArray<LXSignal *> *)signals target:(id)target selector:(SEL)selector;

@property (nonatomic,strong,readonly) NSString *identifier;

@property (nonatomic,copy) NSArray<LXSignal *> *signalArray;

@property (nonatomic,assign) NSInteger signalCount;

@property (nonatomic,strong) id target;

@property (nonatomic,assign) SEL selector;


@end

NS_ASSUME_NONNULL_END
