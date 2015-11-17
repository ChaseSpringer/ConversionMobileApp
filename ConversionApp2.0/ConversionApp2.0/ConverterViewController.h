//
//  ConverterViewController.h
//  ConversionApp2.0
//
//  Created by Zachary Vargas on 11/16/15.
//  Copyright © 2015 Don't Let Your Teams Be Dreams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConverterViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *Distance;
@property (strong, nonatomic) IBOutlet UILabel *Result;
- (IBAction)Convert:(id)sender;


@end
