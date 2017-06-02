//
//  ViewController.h
//  FractionCalculator
//
//  Created by Lavrin on 4/23/17.
//  Copyright © 2017 Lavrin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *display;

-(void) processDigit: (int) digit;
-(void) processOp: (char) theOp;
-(void) storeFracPart;

-(IBAction) clickDigit:(UIButton *) sender;

-(IBAction) clickPlus;
-(IBAction) clickMinus;
-(IBAction) clickMultiply;
-(IBAction) clickDivide;

-(IBAction) clickOver;
-(IBAction) clickEquals;
-(IBAction) clickClear;
-(IBAction) clickConvert;


@end

