//
//  DDMessageListTableViewCell.h
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DDMessageListViewModel;
@class DDChatListViewModel;

@interface DDMessageListTableViewCell : UITableViewCell

- (void)configWithModel:(DDMessageListViewModel *)viewModel andChatListModel:(DDChatListViewModel *)chatListViewModel;

@end

NS_ASSUME_NONNULL_END
