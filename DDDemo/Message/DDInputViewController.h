//
//  DDInputViewController.h
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/9.
//

#import <UIKit/UIKit.h>
#import "DDInputViewControllerDelegate.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDMesageInputType) {
    DDMesageInputTypeNone = 1,
    DDMesageInputTypeText,
};

@interface DDInputViewController : UIViewController

@property (nonatomic, weak) id<DDInputViewControllerDelegate> delegate;

- (void)endEditing:(BOOL)force;

@end

NS_ASSUME_NONNULL_END
