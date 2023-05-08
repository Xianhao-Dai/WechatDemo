//
//  DDChatListTableViewCell.h
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DDChatListViewModel;

@interface DDChatListTableViewCell : UITableViewCell

- (void)configWithModel:(DDChatListViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
