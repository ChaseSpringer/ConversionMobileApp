//
//  ConverterViewController.h
//  ConversionApp2.0
//
//  Created by Zachary Vargas on 11/16/15.
//  Copyright © 2015 Don't Let Your Teams Be Dreams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ConverterViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *Distance;
@property (strong, nonatomic) IBOutlet UILabel *Result;
- (IBAction)Convert:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *formula;
- (IBAction)view:(id)sender;
- (IBAction)deleteName:(id)sender;
- (IBAction)addName:(id)sender;
- (IBAction)update:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *listNames;
@property (strong, nonatomic) IBOutlet UITextField *ider;
@property (strong, nonatomic) IBOutlet UITextField *Distance2;
@property (strong, nonatomic) IBOutlet UITextField *Distance3;



@end
