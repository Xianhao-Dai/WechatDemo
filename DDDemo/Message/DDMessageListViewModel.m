//
//  DDMessageListViewModel.m
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/11.
//

#import "DDMessageListViewModel.h"

@implementation DDMessageListViewModel

- (instancetype)initWithDate:(NSDate *)date message:(NSString *)message {
    self = [super init];
    if (self) {
        self.date = date;
        self.message = message;
    }
    return self;
}

@end
