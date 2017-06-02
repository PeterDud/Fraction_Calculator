//
//  Calculator.m
//  FractionCalculator
//
//  Created by Lavrin on 4/23/17.
//  Copyright © 2017 Lavrin. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

@synthesize operand1, operand2, accumulator;

- (instancetype)init
{
    self = [super init];
    if (self) {
        operand1 = [[Fraction alloc] init];
        operand2 = [[Fraction alloc] init];
        accumulator = [[Fraction alloc] init];
    }
    return self;
}

-(void) clear {
    
    accumulator.numerator = 0;
    accumulator.denominator = 0;
}

-(Fraction *) performOperation:(char)op {
    
    Fraction *result;
    
    switch (op) {
        case '+':
            
            if (operand1.numerator < 0 && operand2.numerator > 0) {
                
                operand1.numerator = -operand1.numerator;
                operand1.denominator = -operand1.denominator;

                result = [operand2 subtract: operand1];
                result.denominator = -result.denominator;
                break;
                
            } else if (operand2.numerator < 0 && operand1.numerator > 0) {
                
                operand2.numerator = -operand2.numerator;
                operand2.denominator = -operand2.denominator;

                result = [operand1 subtract: operand2];
                break;
            }
            
            result = [operand1 add: operand2];
            break;
           
        case '-':
            result = [operand1 subtract: operand2];
            break;
            
        case '*':
            result = [operand1 multiply: operand2];
            break;
            
        case '/':
            result = [operand1 divide: operand2];
            break;
    }
    accumulator.numerator = result.numerator;
    accumulator.denominator = result.denominator;
    
    return result;
}

@end
