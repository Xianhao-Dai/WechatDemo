//
//  DDRootViewController.m
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/6.
//

#import "DDRootViewController.h"
#import "DDChatListTableViewCell.h"
#import "DDChatListViewModel.h"
#import "DDMesageViewController.h"
#import <Masonry/Masonry.h>

@interface DDRootViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) UIView *contentContainerView;
@property (nonatomic, strong) UIView *searchBarContainerView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *chatListTableView;

@end

NSString * const chatListTableViewCellIdentifier = @"DDChatListTableViewCellIdentifier";
CGFloat const kChatListTableViewCellHeight = 68.0f;
CGFloat const kHeaderViewHeight = 64.0f;

@implementation DDRootViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.chatListTableView registerClass:[DDChatListTableViewCell class] forCellReuseIdentifier:chatListTableViewCellIdentifier];
    [self p_loadViewModel];
    [self p_setupUI];
    [self p_makeConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [self.chatListTableView indexPathForSelectedRow];
    if (indexPath) {
        [self.chatListTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self p_saveViewModel];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.view layoutIfNeeded];
    CGFloat contentHeight = self.chatListTableView.contentSize.height;
    CGFloat viewHeight = self.contentContainerView.frame.size.height;
    self.chatListTableView.contentInset = UIEdgeInsetsMake(0, 0, contentHeight >= viewHeight + kHeaderViewHeight ? 0 : viewHeight + kHeaderViewHeight - contentHeight, 0);
}

#pragma mark - Private Method

- (void)p_setupUI {
    [self.view addSubview:self.contentContainerView];
    [self.contentContainerView addSubview:self.chatListTableView];
    self.chatListTableView.tableHeaderView = self.searchBarContainerView;
    [self.searchBarContainerView addSubview:self.searchBar];
    self.view.backgroundColor = [UIColor systemGray5Color];
    self.navigationItem.title = @"微信";
    self.navigationItem.backButtonTitle = @"";
    self.navigationController.navigationBar.tintColor = [UIColor labelColor];
}

- (void)p_makeConstraints {
    [self.contentContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
        make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
    }];
    [self.chatListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentContainerView.mas_top);
        make.left.mas_equalTo(self.contentContainerView.mas_left);
        make.right.mas_equalTo(self.contentContainerView.mas_right);
        make.bottom.mas_equalTo(self.contentContainerView.mas_bottom);
    }];
}

- (void)p_loadViewModel {
    NSMutableArray *viewModel = [[NSMutableArray alloc] init];
    [viewModel addObject:[[DDChatListViewModel alloc] initWithUserId:@"001" name:@"曈💕" avatarImgUrl:@"IMG_01"]];
    [viewModel addObject:[[DDChatListViewModel alloc] initWithUserId:@"002" name:@"古丽江" avatarImgUrl:@"IMG_02"]];
    [viewModel addObject:[[DDChatListViewModel alloc] initWithUserId:@"003" name:@"羊" avatarImgUrl:@"IMG_03"]];
    [viewModel addObject:[[DDChatListViewModel alloc] initWithUserId:@"004" name:@"蒋" avatarImgUrl:@"IMG_04"]];
    [viewModel addObject:[[DDChatListViewModel alloc] initWithUserId:@"005" name:@"王怡心" avatarImgUrl:@"IMG_05"]];
    self.viewModel = [viewModel copy];
}

- (void)p_saveViewModel {
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectedBackgroundView.backgroundColor = [UIColor systemGray6Color];
    DDMesageViewController *messageViewController = [[DDMesageViewController alloc] init];
    messageViewController.viewModel = [self.viewModel objectAtIndex:[self realIndexWithIndexPath:indexPath]];
    [self.navigationController pushViewController:messageViewController animated:YES];
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDChatListTableViewCell *cell = [self.chatListTableView dequeueReusableCellWithIdentifier:chatListTableViewCellIdentifier];
    [cell configWithModel:[self.viewModel objectAtIndex:[self realIndexWithIndexPath:indexPath]]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kChatListTableViewCellHeight;
}

- (NSInteger)realIndexWithIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
}

#pragma mark - Lazy Loader

- (UITableView *)chatListTableView {
    if (!_chatListTableView) {
        _chatListTableView = [[UITableView alloc] init];
        _chatListTableView.backgroundColor = [UIColor systemBackgroundColor];
        _chatListTableView.delegate = self;
        _chatListTableView.dataSource = self;
        _chatListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _chatListTableView;
}

- (UIView *)searchBarContainerView {
    if (!_searchBarContainerView) {
        _searchBarContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kHeaderViewHeight)];
    }
    return _searchBarContainerView;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kHeaderViewHeight)];
        _searchBar.delegate = self;
        _searchBar.searchBarStyle = UISearchBarStyleDefault;
        _searchBar.placeholder = @"搜索";
        _searchBar.barTintColor = [UIColor systemGray5Color];
        _searchBar.tintColor = [UIColor systemBlueColor];
        _searchBar.searchTextField.backgroundColor = [UIColor systemBackgroundColor];
        _searchBar.searchTextField.layer.cornerRadius = 3.0f;
        _searchBar.searchTextField.clipsToBounds = YES;
        _searchBar.searchTextField.borderStyle = UITextBorderStyleNone;
        NSDictionary *attrDict = @{NSFontAttributeName : _searchBar.searchTextField.font};
        CGSize size = [@"搜索" sizeWithAttributes:attrDict];
        CGFloat offsetX = (_searchBar.frame.size.width - _searchBar.searchTextField.leftView.frame.size.width - size.width - 30) / 2.0;
        [_searchBar setPositionAdjustment:UIOffsetMake(offsetX, 0) forSearchBarIcon:UISearchBarIconSearch];
        _searchBar.layer.borderWidth = 1.0f;
        _searchBar.layer.borderColor = [UIColor systemGray5Color].CGColor;
    }
    return _searchBar;
}

- (UIView *)contentContainerView {
    if (!_contentContainerView) {
        _contentContainerView = [[UIView alloc] init];
    }
    return _contentContainerView;
}

@end
