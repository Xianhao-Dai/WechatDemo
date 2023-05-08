//
//  DDChatListViewModel.m
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/6.
//

#import "DDChatListViewModel.h"

@implementation DDChatListViewModel

- (instancetype)initWithUserId:(NSString *)userId name:(NSString *)name avatarImgUrl:(nonnull NSString *)avatarImgUrl{
    self = [super init];
    if (self) {
        self.userId = userId;
        self.name = name;
        self.avatarImgUrl = avatarImgUrl;
    }
    return self;
}

@end
