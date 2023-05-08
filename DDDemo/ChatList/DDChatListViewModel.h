//
//  DDChatListViewModel.h
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDChatListViewModel : NSObject

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *avatarImgUrl;

- (instancetype)initWithUserId:(NSString *)userId name:(NSString *)name avatarImgUrl:(NSString *)avatarImgUrl;

@end

NS_ASSUME_NONNULL_END
