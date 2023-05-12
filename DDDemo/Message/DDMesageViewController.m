//
//  DDMesageViewController.m
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/8.
//

#import "DDMesageViewController.h"
#import "DDChatListViewModel.h"
#import "DDMessageListViewController.h"
#import "DDInputViewController.h"
#import "DDInputViewControllerDelegate.h"
#import <Masonry/Masonry.h>

@interface DDMesageViewController () <
DDMessageListViewControllerDelegate,
DDInputViewControllerDelegate
>

@property (nonatomic, strong) UIView *contentContainerView;
@property (nonatomic, strong) DDMessageListViewController *messageListVC;
@property (nonatomic, strong) DDInputViewController *inputVC;

@end

@implementation DDMesageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_setMessageListVC];
    [self p_setInputVC];
    [self p_setupUI];
    [self p_makeConstraints];
}

#pragma mark - DDInputViewControllerDelegate

- (void)moveInputViewWithKeyboardHeight:(CGFloat)height duration:(NSTimeInterval)duration {
    __weak typeof(self) weakSelf = self;
    CGFloat safeAreaHeight = self.view.safeAreaInsets.bottom;
    height = height > safeAreaHeight ? height :safeAreaHeight;
    [UIView animateWithDuration:duration animations:^{
        __strong typeof(weakSelf) strongSelf = self;
        [strongSelf.contentContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.mas_equalTo(strongSelf.view.mas_bottom).offset(-height);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        }];
        [self.view layoutIfNeeded];
    }];
}

- (void)postMessageFromInputVC:(NSString *)message {
    [self.messageListVC postMessage:message];
}

- (void)scrollMessageListVCToLastRow:(BOOL)animated {
    [self.view layoutIfNeeded];
    [self.messageListVC scrollToLastRow:animated];
}

#pragma mark - DDMessageListViewControllerDelegate

- (void)handleMessageListVCTapGes {
    [self.inputVC endEditing:YES];
}

#pragma mark - Private Method

- (void)p_setupUI {
    self.view.backgroundColor = [UIColor secondarySystemBackgroundColor];
    self.navigationItem.title = self.viewModel.name;
    [self.view addSubview:self.contentContainerView];
    [self addChildViewController:self.messageListVC];
    [self.contentContainerView addSubview:self.messageListVC.view];
    [self addChildViewController:self.inputVC];
    [self.contentContainerView addSubview:self.inputVC.view];
}

- (void)p_makeConstraints {
    [self.contentContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
        make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
    }];
    [self.messageListVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentContainerView);
        make.right.equalTo(self.contentContainerView);
        make.top.equalTo(self.contentContainerView);
        make.bottom.equalTo(self.inputVC.view.mas_top);
    }];
    [self.inputVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentContainerView);
        make.right.equalTo(self.contentContainerView);
        make.bottom.equalTo(self.contentContainerView);
    }];
}

- (void)p_setMessageListVC {
    self.messageListVC = [[DDMessageListViewController alloc] init];
    self.messageListVC.delegate = self;
    self.messageListVC.chatListModel = self.viewModel;
}

- (void)p_setInputVC {
    self.inputVC = [[DDInputViewController alloc] init];
    self.inputVC.delegate = self;
}

#pragma mark - Lazy Loader

- (UIView *)contentContainerView {
    if (!_contentContainerView) {
        _contentContainerView = [[UIView alloc] init];
    }
    return _contentContainerView;
}
@end
