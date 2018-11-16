//
//  NewViewController.m
//  LXSingle
//
//  Created by iOS on 2018/11/13.
//  Copyright © 2018 Jason. All rights reserved.
//

#import "NewViewController.h"
#import "ViewController.h"
@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)click:(id)sender {
    ViewController *vc = [ViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
