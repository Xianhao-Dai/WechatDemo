//
//  DDMesageViewController.h
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DDChatListViewModel;

@interface DDMesageViewController : UIViewController

@property (nonatomic, strong) DDChatListViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
