//
//  OCHamcrest - IsCloseToTest.m
//  Copyright 2011 hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

    // Inherited
#import "AbstractMatcherTest.h"

    // OCHamcrest
#define HC_SHORTHAND
#import <OCHamcrest/HCIsCloseTo.h>


@interface IsCloseToTest : AbstractMatcherTest
@end

@implementation IsCloseToTest

- (id<HCMatcher>) createMatcher
{
    double irrelevant = 0.1;
    return closeTo(irrelevant, irrelevant);
}


- (void) testEvaluatesToTrueIfArgumentIsEqualToADoubleValueWithinSomeError
{
    id<HCMatcher> p = closeTo(1.0, 0.5);
    
    assertMatches(@"equal", p, [NSNumber numberWithDouble:1.0]);
    assertMatches(@"less but within delta", p, [NSNumber numberWithDouble:0.5]);
    assertMatches(@"greater but within delta", p, [NSNumber numberWithDouble:1.5]);
    
    assertDoesNotMatch(@"too small", p, [NSNumber numberWithDouble:0.4]);
    assertDoesNotMatch(@"too big", p, [NSNumber numberWithDouble:1.6]);
}


- (void) testFailsIfMatchingAgainstNonNumber
{
    id<HCMatcher> p = closeTo(1.0, 0.5);
    
    assertDoesNotMatch(@"not a number", p, @"a");
    assertDoesNotMatch(@"not a number", p, nil);
}


- (void) testHasAReadableDescription
{
    assertDescription(@"a numeric value within <0.5> of <1>", closeTo(1.0, 0.5));
}


- (void) testSuccessfulMatchDoesNotGenerateMismatchDescription
{
    assertNoMismatchDescription(closeTo(1.0, 0.5), ([NSNumber numberWithDouble:1.0]));
}


- (void) testMismatchDescriptionShowsActualDeltaIfArgumentIsNumeric
{
    assertMismatchDescription(@"<1.7> differed by <0.7>",
                              (closeTo(1.0, 0.5)), [NSNumber numberWithDouble:1.7]);
}


- (void) testMismatchDescriptionShowsActualArgumentIfNotNumeric
{
    assertMismatchDescription(@"was \"bad\"", (closeTo(1.0, 0.5)), @"bad");
}


- (void) testDescribeMismatchShowsActualDeltaIfArgumentIsNumeric
{
    assertDescribeMismatch(@"<1.7> differed by <0.7>",
                           (closeTo(1.0, 0.5)), [NSNumber numberWithDouble:1.7]);
}


- (void) testDescribeMismatchShowsActualArgumentIfNotNumeric
{
    assertDescribeMismatch(@"was \"bad\"", (closeTo(1.0, 0.5)), @"bad");
}

@end
