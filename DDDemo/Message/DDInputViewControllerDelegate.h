//
//  DDInputViewControllerDelegate.h
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DDInputViewControllerDelegate <NSObject>

// 键盘弹起、落下时用于更新inputVC约束
- (void)moveInputViewWithKeyboardHeight:(CGFloat)height duration:(NSTimeInterval)duration;

// 用于接受inputVC消息并发送，现阶段仅支持文本发送
- (void)postMessageFromInputVC:(NSString *)message;

// 滑动messageVC至底部
- (void)scrollMessageListVCToLastRow:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
