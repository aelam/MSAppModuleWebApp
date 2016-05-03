//
//  MSViewController.m
//  MSAppModuleWebApp
//
//  Created by Ryan Wang on 03/09/2016.
//  Copyright (c) 2016 Ryan Wang. All rights reserved.
//

#import "MSViewController2.h"
#import "EMWebViewController.h"

static NSString *kURL = @"http://mt.emoney.cn/html/emstock/bbs/Index.html?topicId=4330969&&css=b&userId=10010144225&pd=15&vd=100&webAuthToken=ib4Wr4FQEFz%2Fr0Mm0K7YFEJabXV7CjHW7OJGPI7ryqMdx291zeKhSA7GUlJxSyIX4%2BE2J%2BwEo1%2FHFifT%2BKgdOQEG8kfXwxDvxFHW%2FB4zZ1hElJW96KuqrpHw03ifNUbiYiBNBc1MzFLsBicjFotFKPHSIiI2ufs3jBBYC59APZ0%3D&mv=2.8.4&systemVersion=9.3&guid=70962978-EAC3-40D8-BE97-85D4AB7C6590&ar=9&loginType=0";

@interface MSViewController2 ()

@property (nonatomic, assign) IBOutlet UITextField *textField;

@end

@implementation MSViewController2

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)open:(id)sender {
    
//    NSURL *url = [NSURL URLWithString:kURL];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    EMWebViewController *webViewController = [[EMWebViewController alloc] initWithURL:url];
    [self.navigationController pushViewController:webViewController animated:YES];
}

@end
