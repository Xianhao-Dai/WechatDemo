//
//  DDInputViewControllerDelegate.h
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DDInputViewControllerDelegate <NSObject>

- (void)moveInputViewWithKeyboardHeight:(CGFloat)height duration:(NSTimeInterval)duration;

@end

NS_ASSUME_NONNULL_END
