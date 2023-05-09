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
#import <Masonry/Masonry.h>

@interface DDMesageViewController ()

@property (nonatomic, strong) UIView *contentContainerView;
@property (nonatomic, strong) DDMessageListViewController *messageListVC;
@property (nonatomic, strong) DDInputViewController *inputVC;

@end

@implementation DDMesageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_setupUI];
    [self p_makeConstraints];
}

#pragma mark - Private Method

- (void)p_setupUI {
    self.messageListVC = [[DDMessageListViewController alloc] init];
    self.inputVC = [[DDInputViewController alloc] init];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
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
        make.height.mas_equalTo(64);
    }];
}

#pragma mark - Lazy Loader

- (UIView *)contentContainerView {
    if (!_contentContainerView) {
        _contentContainerView = [[UIView alloc] init];
    }
    return _contentContainerView;
}
@end
