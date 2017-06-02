//
//  Fraction.m
//  FractionCalculator
//
//  Created by Lavrin on 4/23/17.
//  Copyright © 2017 Lavrin. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction

@synthesize numerator, denominator;

-(void) setTo:(int)n over:(int)d {
    
    numerator = n;
    denominator = d;
}

-(void) print {
    
    NSLog(@"%i/%i", numerator, denominator);
}

-(double) convertToNum {
    
    if (denominator != 0) {
        
        double number = (double) numerator / denominator;
//        NSLog(@"numerator: %i; denominator: %i", numerator, denominator);
        return number;
    } else
        return NAN;
}

-(NSString *) convertToString {
    
    if (numerator < 0) {
        if (numerator == denominator) {
            return @"-1";
        } else if (denominator == -1) {
            return [NSString stringWithFormat:@"%i", numerator];
        } else {
//            NSLog(@"%i %i", numerator, denominator);
            return [NSString stringWithFormat:@"%i/%i", numerator, -denominator];
        }
    } else if (numerator == denominator) {
        if (numerator == 0) {
            return @"0";
        } else {
            return @"1";
        }
    } else if (denominator == 1) {
        return [NSString stringWithFormat: @"%i", numerator];
    } else
        return [NSString stringWithFormat: @"%i/%i", numerator, denominator];
}

-(Fraction *) add:(Fraction *)f {
    
    Fraction* result = [[Fraction alloc] init];
    
//    NSLog(@"%i %i", numerator, denominator);
//    NSLog(@"%i %i", f.numerator, f.denominator);

    result.numerator = numerator * f.denominator + denominator * f.numerator;
//    NSLog(@"%i", result.numerator);
    result.denominator = denominator * f.denominator;
    
//    [result print];
    
    [result reduce];
    
//    [result print];

    return result;
}

-(Fraction *) subtract:(Fraction *)f {
    
    Fraction *result = [[Fraction alloc] init];
    
    result.numerator = numerator * f.denominator - denominator * f.numerator;
    result.denominator = denominator * f.denominator;

    [result reduce];
    return result;
}

-(Fraction *) multiply:(Fraction *)f {
    
    Fraction *result = [[Fraction alloc] init];
    
//    NSLog(@"%i %i", numerator, f.numerator);
//    NSLog(@"%i %i", denominator, f.denominator);

    result.numerator = numerator *f.numerator;
    result.denominator = denominator * f.denominator;
    
    [result reduce];
    return result;
}

-(Fraction *) divide:(Fraction *)f {
    
    Fraction *result = [[Fraction alloc] init];

    result.numerator = numerator * f.denominator;
    result.denominator = denominator * f.numerator;
    
    [result reduce];
    return result;
}

-(void) reduce {
    
    int u = numerator;
    int v = denominator;
    int temp;
    
    if (u == 0) {
        return;
    }
//    else if (u < 0) {
//        u = -u;
//    }
    
    while (v != 0) {
        temp = u % v;
        u =v;
        v= temp;
    }
    
    if (u < 0) {
        u = -u;
    }
    
//    NSLog(@"%i", u);

    numerator /= u;
    denominator /= u;
}











@end
