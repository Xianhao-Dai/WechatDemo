//
//  DDMessageListViewController.m
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/9.
//

#import "DDMessageListViewController.h"
#import <Masonry/Masonry.h>
#import "DDMessageListTableViewCell.h"
#import "DDMessageListViewModel.h"

@interface DDMessageListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITapGestureRecognizer *tapGes;
@property (nonatomic, strong) UIView *contentContainerView;
@property (nonatomic, strong) UITableView *messageListTableView;

@end

NSString * const messageListTableViewCellIdentifier = @"DDMessageListTableViewCellIdentifier";
CGFloat const kMessageListTableViewCellHeight = 64.0f;

@implementation DDMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor secondarySystemBackgroundColor];
    [self.messageListTableView registerClass:[DDMessageListTableViewCell class] forCellReuseIdentifier:messageListTableViewCellIdentifier];
    [self p_addGestures];
    [self p_loadViewModel];
    [self p_setupUI];
    [self p_makeConstraints];
}

#pragma mark - Private Method

- (void)p_setupUI {
    [self.view addSubview:self.contentContainerView];
    [self.contentContainerView addSubview:self.messageListTableView];
}

- (void)p_makeConstraints {
    [self.contentContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.messageListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentContainerView);
    }];
}

- (void)p_loadViewModel {
    self.viewModel = [NSArray array];
}

- (void)postMessage:(NSString *)message {
    NSDate *currentTime = [NSDate date];
    DDMessageListViewModel *singleModel = [[DDMessageListViewModel alloc] init];
    singleModel.date = currentTime;
    singleModel.message = message;
    NSMutableArray<DDMessageListViewModel *> *models = [self.viewModel mutableCopy];
    [models addObject:singleModel];
    self.viewModel = [models copy];
    [self.messageListTableView reloadData];
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDMessageListTableViewCell *cell = [self.messageListTableView dequeueReusableCellWithIdentifier:messageListTableViewCellIdentifier];
    [cell configWithModel:[self.viewModel objectAtIndex:[self realIndexWithIndexPath:indexPath]]];
    return cell;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.count;
}

- (NSInteger)realIndexWithIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row;
}

#pragma mark - Gesture Recognizer

- (void)p_addGestures {
    self.tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_handleTapGes:)];
    [self.view addGestureRecognizer:self.tapGes];
}

#pragma mark - Private Method

- (void)p_handleTapGes:(UITapGestureRecognizer *) ges {
    [self.delegate handleMessageListVCTapGes];
}

#pragma mark - Lazy Loader

- (UIView *)contentContainerView {
    if (!_contentContainerView) {
        _contentContainerView = [[UIView alloc] init];
    }
    return _contentContainerView;
}

- (UITableView *)messageListTableView {
    if (!_messageListTableView) {
        _messageListTableView = [[UITableView alloc] init];
        _messageListTableView.backgroundColor = [UIColor secondarySystemBackgroundColor];
        _messageListTableView.delegate = self;
        _messageListTableView.dataSource = self;
        _messageListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _messageListTableView;
}

@end
