//
//  DDMessageListViewController.m
//  DDDemo
//
//  Created by  dxh最爱芋头 on 2023/5/9.
//

#import "DDMessageListViewController.h"

@interface DDMessageListViewController ()

@property (nonatomic, strong) UITapGestureRecognizer *tapGes;

@end

@implementation DDMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_addGestures];
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

@end
