//
//  DDMessageListViewController.h
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/9.
//

#import <UIKit/UIKit.h>
#import "DDMessageListViewControllerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@class DDMessageListViewModel;
@class DDChatListViewModel;

@interface DDMessageListViewController : UIViewController

@property (nonatomic, weak) id<DDMessageListViewControllerDelegate> delegate;
@property (nonatomic, copy) NSArray<DDMessageListViewModel *> *viewModel;
@property (nonatomic, weak) DDChatListViewModel *chatListModel;

- (void)postMessage:(NSString *)message;

// messageList滑动到底部
- (void)scrollToLastRow:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
