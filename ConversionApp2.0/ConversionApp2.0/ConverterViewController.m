//
//  ConverterViewController.m
//  ConversionApp2.0
//
//  Created by Zachary Vargas on 11/16/15.
//  Copyright © 2015 Don't Let Your Teams Be Dreams. All rights reserved.
//

#import "ConverterViewController.h"

@interface ConverterViewController ()

@end

@implementation ConverterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Convert:(id)sender {
    double miles = [_Distance.text doubleValue];
    double kilometers = miles*1.609;
    NSString* resultString = [[NSString alloc] initWithFormat:@"%.2f Kilometers", kilometers];
    _Result.text = resultString;
}
@end
