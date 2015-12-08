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

NSString * myDB=@"myData.db";

@implementation ConverterViewController
@synthesize name;
@synthesize formula;
@synthesize listNames;
@synthesize ider;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Convert:(id)sender {
    if (_Distance.isFirstResponder) {
    double miles = [_Distance.text doubleValue];
    double kilometers = miles*1.609;
    NSString* resultString = [[NSString alloc] initWithFormat:@"%.2f Kilometers", kilometers];
    _Result.text = resultString;
    }
    else if (_Distance2.isFirstResponder) {
        double inches = [_Distance2.text doubleValue];
        double centimeters = inches*2.54;
        NSString* resultString = [[NSString alloc] initWithFormat:@"%.2f Centimeters", centimeters];
        _Result.text = resultString;
    }
    else {
        double feet = [_Distance3.text doubleValue];
        double meters = feet*.3048;
        NSString* resultString = [[NSString alloc] initWithFormat:@"%.2f Meters", meters];
        _Result.text = resultString;
    }
}
- (IBAction)view:(id)sender {
    
    NSString* formulaN;
    NSString * theID;
    NSString* userN;
    NSString * myLine=@" ";
    NSString * paths=[self getWritableDBPath];
    
    const char *dbpath =  [paths UTF8String];
    sqlite3_stmt    *statement;
    static sqlite3 *database = nil;
    
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT name, formula, id FROM users",nil];
        
        const char *query_stmt = [querySQL UTF8String];
        
        //  NSLog(@"Databasae opened = %@", userN);
        
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                userN = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                formulaN = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                theID = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                myLine= [NSString stringWithFormat:@"%@%@%@%@%@%@%@",myLine,userN,@": ",formulaN,@": ",theID,@" - "];
                
                
            }
            //  username.text=@"No Username";
            
            
            sqlite3_finalize(statement);
        }
        //  NSLog( @"Save Error: %s", sqlite3_errmsg(database) );
        
        sqlite3_close(database);
    }
    //  NSLog(@"user = %@", userN);
    
    listNames.text=myLine;
}

- (IBAction)deleteName:(id)sender {
    // Copy the database if needed
    [self createEditableCopyOfDatabaseIfNeeded];
    
    NSString *filePath = [self getWritableDBPath];
    
    sqlite3 *database;
    NSString * theID=ider.text;
    
    
    if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK) {
        
        NSString * sState=@"DELETE FROM users WHERE id='";
        
        
        NSString * s=  [NSString stringWithFormat:@"%@%@%@",sState,theID,@"';"];
        
        const char *sqlStatement = [s cStringUsingEncoding:NSUTF8StringEncoding];//"DELETE FROM users WHERE id='3';";
        sqlite3_stmt *compiledStatement;
        sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL);
        
        
        if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
            NSLog( @"Save Error: %s", sqlite3_errmsg(database) );
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}

- (IBAction)addName:(id)sender {
    [self saveUserInDatabase];
}

- (IBAction)update:(id)sender {
    // Copy the database if needed
    [self createEditableCopyOfDatabaseIfNeeded];
    
    NSString *filePath = [self getWritableDBPath];
    
    sqlite3 *database;
    NSString * theU=name.text;
    NSString * theE=formula.text;
    NSString * theID=ider.text;
    
    if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK) {
        NSString * sState=@"UPDATE users SET name='";
        NSString * sState2=@"', formula='";
        NSString * sState3=@"' WHERE id='";
        NSString * sState4=@"';";
        NSString * s=  [NSString stringWithFormat:@"%@%@%@%@%@%@%@",sState,theU,sState2,theE,sState3,theID,sState4];
        
        const char *sqlStatement =[s cStringUsingEncoding:NSUTF8StringEncoding];
        //"UPDATE users SET username='?', email='?' WHERE id='3';";
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)    {
            // sqlite3_bind_text( compiledStatement, 1,[theU UTF8String], -1, SQLITE_TRANSIENT);
            // sqlite3_bind_text( compiledStatement, 2,[theE UTF8String], -1, SQLITE_TRANSIENT);
            //sqlite3_bind_text( compiledStatement, 3,[theID UTF8String], -1, SQLITE_TRANSIENT);
            
            
        }
        if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
            NSLog( @"Save Error: %s", sqlite3_errmsg(database) );
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    // UPDATE users SET username='?', email='?' WHERE id='1';
}


-(void)saveUserInDatabase { //========================SAVE==============================
    
    // Copy the database if needed
    [self createEditableCopyOfDatabaseIfNeeded];
    
    NSString *filePath = [self getWritableDBPath];
    
    sqlite3 *database;
    NSString * theU=name.text;
    NSString * theE=formula.text;
    
    if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK) {
        
        //NSString *temp = [NSString stringWithFormat:@"insert into allusers (user_id,user_name) VALUES (%@,%@)",user_id,user_name];
        const char *sqlStatement = "insert into users (name,formula) VALUES (?,?)";
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)    {
            sqlite3_bind_text( compiledStatement, 1,[theU UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text( compiledStatement, 2,[theE UTF8String], -1, SQLITE_TRANSIENT);
            
            
        }
        if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
            NSLog( @"Save Error: %s", sqlite3_errmsg(database) );
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}

- (IBAction) clickedBackground
{
    [self.view endEditing:YES];    
}


//========================================WRITABLE DATABSE PATH=======================
- (NSString *) getWritableDBPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:myDB];
    
}

//================================================Copies database to appropriate location============

-(void)createEditableCopyOfDatabaseIfNeeded
{
    // Testing for existence
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:myDB];
    
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success)
        return;
    
    // The writable database does not exist, so copy the default to
    // the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath]
                               stringByAppendingPathComponent:myDB];
    success = [fileManager copyItemAtPath:defaultDBPath
                                   toPath:writableDBPath
                                    error:&error];
    if(!success)
    {
        NSAssert1(0,@"Failed to create writable database file with Message : '%@'.",
                  [error localizedDescription]);
    }
}
@end
