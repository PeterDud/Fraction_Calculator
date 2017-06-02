//
//  ViewController.m
//  FractionCalculator
//
//  Created by Lavrin on 4/23/17.
//  Copyright © 2017 Lavrin. All rights reserved.
//

#import "ViewController.h"
#import "Calculator.h"

@interface ViewController ()

@end

@implementation ViewController
{
    char op;
    int currentNumber;
    BOOL firstOperand, isNumerator, isNegative, isChained;
    Calculator *myCalculator;
    NSMutableString *displayString;
}

@synthesize display;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    firstOperand = YES;
    isNumerator = YES;
    isNegative = NO;
    isChained = NO;
    displayString = [NSMutableString stringWithCapacity:40];
    myCalculator = [[Calculator alloc] init];
}

-(void) processDigit:(int)digit {
    
    currentNumber = currentNumber * 10 + digit;
    
    [displayString appendString:[NSString stringWithFormat:@"%i", digit]];
    display.text = displayString;
}

-(IBAction) clickDigit:(UIButton *)sender {
    
    int digit = sender.tag;
    
    if (isNumerator == NO) {
        if (digit == 0) {
            [displayString setString:@"Err: 0 as denom"];
            display.text = displayString;
            return;
        }
    }
    [self processDigit: digit];
    
}

-(void) processOp: (char) theOp {
    
    if (theOp == '-') {
        if ([displayString isEqualToString: @""] ||
            [[displayString substringFromIndex:[displayString length] - 1] isEqualToString:@" "]) {
            
            [displayString appendString: @"-"];
            display.text = displayString;
            
            isNegative = YES;
            
            return;
        }
    }
    
    NSString *opStr;
    
    op = theOp;
    
    switch (theOp) {
        case '+':
            opStr = @" + ";
            break;
           
        case '-':
            opStr = @" - ";
            break;
            
        case '*':
            opStr = @" × ";
            break;
            
        case '/':
            opStr = @" ÷ ";
            break;
    }
    
    [displayString appendString: opStr];
    display.text = displayString;
    
    [self storeFracPart];
    firstOperand = NO;
    isNumerator = YES;
    
}

-(void) storeFracPart {
    
    if (firstOperand) {
        if (isNumerator) {
            if (isNegative) {
                myCalculator.operand1.numerator = -currentNumber;
                myCalculator.operand1.denominator = 1;
            } else {
                myCalculator.operand1.numerator = currentNumber;
                myCalculator.operand1.denominator = 1;
            }
        }
        else {
            if (isNegative) {
                myCalculator.operand1.denominator = -currentNumber;
                isNegative = NO;
            } else {
                myCalculator.operand1.denominator = currentNumber;
            }
        }
    } else if (isNumerator) {
        if (isNegative) {
            myCalculator.operand2.numerator = -currentNumber;
            myCalculator.operand2.denominator = 1;
        } else {
            myCalculator.operand2.numerator = currentNumber;
            myCalculator.operand2.denominator = 1;
        }
    } else {
        if (isNegative) {
            if (!isChained) {
                myCalculator.operand2.denominator = -currentNumber;
            }
            firstOperand = YES;
        } else {
            if (!isChained) {
                myCalculator.operand2.denominator = currentNumber;
            }
            firstOperand = YES;
        }
    }
    currentNumber = 0;
}

-(IBAction) clickOver {
    
    [self storeFracPart];
    isNumerator = NO;
    [displayString appendString: @"/"];
    display.text  = displayString;
}

-(void) contrinueChainedCalculation {
    
    myCalculator.operand2.denominator = currentNumber;
    
    [myCalculator performOperation: op];
    myCalculator.operand1 = myCalculator.accumulator;
    [myCalculator.operand1 print];
    
    isChained = YES;

}

-(IBAction) clickPlus {
    
    if (firstOperand == NO) {

        [self contrinueChainedCalculation];
    }
    
    [self processOp: '+'];
}

-(IBAction) clickMinus {
    
    if (firstOperand == NO) {
        
        [self contrinueChainedCalculation];
    }
    
    [self processOp: '-'];
}

-(IBAction) clickMultiply {
    
    if (firstOperand == NO) {
        
        [self contrinueChainedCalculation];
    }
    
    [self processOp: '*'];
}

-(IBAction) clickDivide {
    
    if (firstOperand == NO) {
        
        [self contrinueChainedCalculation];
    }
    
    [self processOp: '/'];
}

-(IBAction) clickEquals {
    
    if (firstOperand == NO) {
        
        isChained = NO;
        
        [self storeFracPart];
        
        [myCalculator.operand1 print];
        [myCalculator.operand2 print];

        [myCalculator performOperation: op];
        
        [displayString appendString: @" = "];
        [displayString appendString: [myCalculator.accumulator convertToString]];
        display.text = displayString;
        
        currentNumber = 0;
        isNumerator = YES;
        firstOperand = YES;
        isNegative = NO;
        [displayString setString:@""];
    }
}

-(IBAction) clickClear {
    
    isNumerator = YES;
    firstOperand = YES;
    currentNumber = 0;
    [myCalculator clear];
    
    [displayString setString: @""];
    display.text = displayString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) clickConvert {
    
//    [self storeFracPart];
    myCalculator.operand1.denominator = currentNumber;

    double number = [myCalculator.operand1 convertToNum];
    [displayString setString:[NSString stringWithFormat:@"%.2f", number]];
    display.text = displayString;
}


/*
-(IBAction) clickConvert {
    
    double number;
    BOOL isResult = [displayString containsString:@" = "];
    
    NSLog(@"%i", isResult);
    
    if (firstOperand && isResult == NO) {
        
        [self storeFracPart];
        number = [myCalculator.operand1 convertToNum];
        [displayString setString:[NSString stringWithFormat:@"%.3f", number]];
        display.text = displayString;
        
    } else if (isResult) {
        
        [self storeFracPart];

        number = [myCalculator.accumulator convertToNum];
        NSRange range = [displayString rangeOfString:@" = "];
        NSRange range2 = NSMakeRange(range.location + range.length,
                                     [displayString length] - (range.location + range.length));
        [displayString replaceCharactersInRange:range2
                                     withString:[NSString stringWithFormat:@"%.2f", number]];
        display.text = displayString;
        
    } else {
        
        [self storeFracPart];
        firstOperand = NO;
        
        number = [myCalculator.operand2 convertToNum];
        [myCalculator.operand2 print];
        NSString *string = [NSString stringWithFormat:@" %c ", op];
        NSLog(@"%@", string);
        NSRange range = [displayString rangeOfString: string];
        NSRange range3 = NSMakeRange(range.location + range.length,
                                     [displayString length] - (range.location + range.length) );
        
        NSLog(@"range3: loc %i; length %i", range.location, range.length);
        
        [displayString replaceCharactersInRange: range3
                                     withString:[NSString stringWithFormat:@"%.2f", number]];
        display.text = displayString;
    }
}
*/

















@end
