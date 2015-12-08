/*!
*  ConverterViewController.h
*  ConversionApp2.0
*
*  Created by Zachary Vargas on 11/16/15.
*  Copyright © 2015 Don't Let Your Teams Be Dreams. All rights reserved.
*/

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ConverterViewController : UIViewController
/*!
 *@brief the first text field on the converter page
 */
@property (strong, nonatomic) IBOutlet UITextField *Distance;
/*!
 *@brief the converted value
 */
@property (strong, nonatomic) IBOutlet UILabel *Result;
/*!
 *@discussion The button converts the integer into either kilometers, meters, or centimeters
 *@result converted integer for the user to view
 */
- (IBAction)Convert:(id)sender;
/*!
 *@brief is a column in the sql table
 */
@property (strong, nonatomic) IBOutlet UITextField *name;
/*!
 *@brief column in the sql table for storing the formula
 */
@property (strong, nonatomic) IBOutlet UITextField *formula;
/*!
 *@discussion Shows the shit I gotta see
 *@result The list of formulas and their names currently stored in the database
 */
- (IBAction)view:(id)sender;
/*!
 *@discussion Deletes the selected data from the database
 *@result Selected formula and its name is deleted from the database
 */
- (IBAction)deleteName:(id)sender;
/*!
 *@discussion Adds a formula and its name as inputted by the user into the database
 *@result A new formula and its name is added to the database
 */
- (IBAction)addName:(id)sender;
/*!
 *@discussion Updates the database with new information designated by the user
 *@result The database is upadated with new information
 */
- (IBAction)update:(id)sender;
/*!
 *@brief variable for listing the sql information
 */
@property (strong, nonatomic) IBOutlet UILabel *listNames;
/*!
 *@brief variable used for storing the id of sql items
 */
@property (strong, nonatomic) IBOutlet UITextField *ider;
/*!
 *@brief the second text field on the converter page
 */
@property (strong, nonatomic) IBOutlet UITextField *Distance2;
/*!
 *@brief the third text field on the converter page
 */
@property (strong, nonatomic) IBOutlet UITextField *Distance3;




@end
