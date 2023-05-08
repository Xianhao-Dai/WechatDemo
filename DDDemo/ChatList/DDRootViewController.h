//
//  DDRootViewController.h
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DDChatListViewModel;

@interface DDRootViewController : UIViewController

@property (nonatomic, strong) NSArray<DDChatListViewModel *> *viewModel;

@end

NS_ASSUME_NONNULL_END
