//
//  DDChatListTableViewCell.m
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/7.
//

#import "DDChatListTableViewCell.h"
#import "DDChatListViewModel.h"
#import <Masonry/Masonry.h>

@interface DDChatListTableViewCell ()

@property (nonatomic, strong) UIView *avatarContainerView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *hintLabel;
@property (nonatomic, strong) UIView *separatorView;

@end

CGFloat const kSeparatorHeight = 1.0f;

@implementation DDChatListTableViewCell

#pragma mark - Life Cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self p_setupUI];
        [self p_makeConstraints];
    }
    return self;
}

#pragma mark - Private Method

- (void)p_setupUI {
    [self.contentView addSubview:self.avatarContainerView];
    [self.avatarContainerView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.separatorView];
    self.avatarImageView.layer.cornerRadius = 8.0f;
    self.avatarImageView.layer.masksToBounds = YES;
    self.nameLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16.0];
    self.separatorView.backgroundColor = [UIColor systemGray6Color];
}

- (void)p_makeConstraints {
    [self.avatarContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(12);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
        make.width.mas_equalTo(44);
    }];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.avatarContainerView);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarContainerView.mas_top);
        make.left.equalTo(self.avatarContainerView.mas_right).offset(16);
        make.bottom.equalTo(self.contentView.mas_centerY);
        make.right.lessThanOrEqualTo(self.contentView.mas_right);
    }];
    [self.separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.avatarContainerView.mas_right);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(kSeparatorHeight);
    }];
}

#pragma mark - Lazy Loader

- (UIView *)avatarContainerView {
    if (!_avatarContainerView) {
        _avatarContainerView = [[UIView alloc] init];
    }
    return _avatarContainerView;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
    }
    return _avatarImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
    }
    return _nameLabel;
}

- (UIView *)separatorView {
    if (!_separatorView) {
        _separatorView = [[UILabel alloc] init];
    }
    return _separatorView;
}

- (void)configWithModel:(nonnull DDChatListViewModel *)viewModel {
    [self.avatarImageView setImage:[UIImage imageNamed:viewModel.avatarImgUrl]];
    self.nameLabel.text = viewModel.name;
}

@end
