//
//  DDMessageListViewModel.h
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DDChatListViewModel;

@interface DDMessageListViewModel : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *message;

- (instancetype)initWithDate:(NSDate *)date message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
