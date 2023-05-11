//
//  DDMessageListTableViewCell.m
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/11.
//

#import "DDMessageListTableViewCell.h"
#import "DDMessageListViewModel.h"
#import <Masonry/Masonry.h>
#import <YYKit/YYKit.h>
#import "DDChatListViewModel.h"

@interface DDMessageListTableViewCell () <YYTextViewDelegate>

@property (nonatomic, strong) UIView *avatarContainerView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIView *messageContainerView;
@property (nonatomic, strong) YYTextView *textView;

@end

@implementation DDMessageListTableViewCell

#pragma mark - Life Cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self p_setupUI];
        [self p_makeConstraints];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.selectedBackgroundView = nil;
}

#pragma mark - Private Method

- (void)p_setupUI {
    [self.contentView addSubview:self.avatarContainerView];
    [self.avatarContainerView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.messageContainerView];
    [self.messageContainerView addSubview:self.textView];
    self.backgroundColor = [UIColor secondarySystemBackgroundColor];
}

- (void)p_makeConstraints {
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);

    [self.avatarContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom);
        make.width.height.mas_equalTo(60);
    }];

    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.avatarContainerView).insets(padding);
    }];

    [self.messageContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.lessThanOrEqualTo(self.contentView).offset(-10);
        make.left.greaterThanOrEqualTo(self.contentView).offset(10);
        make.right.equalTo(self.avatarContainerView.mas_left);
    }];
    
    padding = UIEdgeInsetsMake(0, 5, 0, 5);
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.messageContainerView).insets(padding);
    }];
}

#pragma mark - YYTextViewDelegate

- (void)textViewDidChange:(YYTextView *)textView {
    CGFloat maxHeight = 200.0f;
    CGSize sizeThatFits = [textView sizeThatFits:CGSizeMake(334, MAXFLOAT)];
    CGFloat newHeight = MIN(sizeThatFits.height, maxHeight);
    CGFloat heightPadding = MAX(0, (40 - newHeight) / 2);
    CGFloat newWidth = sizeThatFits.width;
    UIEdgeInsets padding = UIEdgeInsetsMake(heightPadding, 5, heightPadding, 5);
    [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.messageContainerView).insets(padding);
        make.height.mas_equalTo(newHeight);
        make.width.mas_equalTo(newWidth + 6);
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
        _avatarImageView.layer.cornerRadius = 3.0f;
        _avatarImageView.layer.masksToBounds = YES;
    }
    return _avatarImageView;
}

- (UIView *)messageContainerView {
    if (!_messageContainerView) {
        _messageContainerView = [[UIView alloc] init];
        _messageContainerView.backgroundColor = [UIColor systemGreenColor];
        _messageContainerView.layer.cornerRadius = 3.0f;
        _messageContainerView.contentMode = UIViewContentModeCenter;
    }
    return _messageContainerView;
}

- (YYTextView *)textView {
    if (!_textView) {
        _textView = [[YYTextView alloc] init];
        _textView.delegate = self;
        _textView.editable = NO;
        _textView.font = [UIFont systemFontOfSize:18];
    }
    return _textView;
}

- (void)configWithModel:(DDMessageListViewModel *)viewModel {
    [self.avatarImageView setImage:[UIImage imageNamed:@"IMG_06"]];
    self.textView.text = viewModel.message;
}

@end
