//
//  DDInputViewController.m
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/9.
//

#import "DDInputViewController.h"
#import <Masonry/Masonry.h>
#import <YYKit/YYKit.h>

@interface DDInputViewController ()<YYTextViewDelegate>

@property (nonatomic, strong) UIView *contentContainerView;
@property (nonatomic, strong) UIButton *audioBtn;
@property (nonatomic, strong) UIButton *emojiBtn;
@property (nonatomic, strong) UIButton *plusBtn;
@property (nonatomic, strong) YYTextView *textField;

@end

@implementation DDInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_setupUI];
    [self p_makeConstraints];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private Method

- (void)p_setupUI {
    self.view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.contentContainerView];
    [self.contentContainerView addSubview:self.audioBtn];
    [self.contentContainerView addSubview:self.emojiBtn];
    [self.contentContainerView addSubview:self.plusBtn];
    [self.contentContainerView addSubview:self.textField];
}

- (void)p_makeConstraints {
    [self.contentContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.audioBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentContainerView.mas_left).offset(14);
        make.centerY.equalTo(self.contentContainerView.mas_centerY).offset(-6);
        make.width.height.mas_equalTo(36);
    }];
    [self.plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentContainerView.mas_right).offset(-14);
        make.centerY.equalTo(self.contentContainerView.mas_centerY).offset(-6);
        make.width.height.mas_equalTo(36);
    }];
    [self.emojiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.plusBtn.mas_left).offset(-14);
        make.centerY.equalTo(self.contentContainerView.mas_centerY).offset(-6);
        make.width.height.mas_equalTo(36);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.audioBtn.mas_right).offset(14);
        make.right.equalTo(self.emojiBtn.mas_left).offset(-14);
        make.centerY.equalTo(self.contentContainerView.mas_centerY).offset(-6);
        make.height.mas_equalTo(36);
    }];
}

#pragma mark - YYTextViewDelegate

- (void)endEditing:(BOOL)force {
    [self.textField endEditing:YES];
}

- (void)textViewDidBeginEditing:(YYTextView *)textView {
    if (![textView isFirstResponder]) {
        [textView becomeFirstResponder];
    }
}

- (void)textViewDidEndEditing:(YYTextView *)textView {
    if ([textView isFirstResponder]) {
        [textView resignFirstResponder];
    }
}

- (void)handleKeyboardWillShow:(NSNotification *)noti {
    NSDictionary *userInfo = noti.userInfo;
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self.delegate moveInputViewWithKeyboardHeight:keyboardFrame.size.height duration:duration];
}

- (void)handleKeyboardWillHide:(NSNotification *)noti {
    NSDictionary *userInfo = noti.userInfo;
    NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self.delegate moveInputViewWithKeyboardHeight:0 duration:duration];
}

#pragma mark - Lazy Loader

- (UIView *)contentContainerView {
    if (!_contentContainerView) {
        _contentContainerView = [[UIView alloc] init];
    }
    return _contentContainerView;
}

- (UIButton *)audioBtn {
    if (!_audioBtn) {
        _audioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _audioBtn.backgroundColor = [UIColor redColor];
    }
    return _audioBtn;
}

- (UIButton *)emojiBtn {
    if (!_emojiBtn) {
        _emojiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _emojiBtn.backgroundColor = [UIColor redColor];
    }
    
    return _emojiBtn;
}

- (UIButton *)plusBtn {
    if (!_plusBtn) {
        _plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _plusBtn.backgroundColor = [UIColor redColor];
    }
    
    return _plusBtn;
}

- (YYTextView *)textField {
    if (!_textField) {
        _textField = [[YYTextView alloc] init];
        _textField.delegate = self;
        _textField.backgroundColor = [UIColor redColor];
    }
    
    return _textField;
}

@end
