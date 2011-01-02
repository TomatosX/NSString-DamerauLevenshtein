//
//  DamerauLevenshteinTests.m
//  Damerau-Levenshtein
//
//  Created by Jan on 02.01.11.
//  Copyright 2011 geheimwerk.de. All rights reserved.
//

#import "DamerauLevenshteinTests.h"

#import "NSString+DamerauLevenshtein.h"

@implementation DamerauLevenshteinTests

- (void)test_empty {
	STAssertEquals((NSUInteger)0, [@"" distanceFromString:@""], @"Empty test #1 failed.");

	STAssertEquals((NSUInteger)1, [@"" distanceFromString:@"a"], @"Empty test #2 failed.");

	STAssertEquals((NSUInteger)1, [@"a" distanceFromString:@""], @"Empty test #3 failed.");
}

- (void)test_simple {
	STAssertEquals((NSUInteger)1, [@"ab" distanceFromString:@"abc"], @"Simple insertion test failed.");

	STAssertEquals((NSUInteger)1, [@"ab" distanceFromString:@"a"], @"Simple deletion test failed.");

	STAssertEquals((NSUInteger)1, [@"ab" distanceFromString:@"az"], @"Simple substitution test failed.");

#ifndef DISABLE_DAMERAU_TRANSPOSITION
	STAssertEquals((NSUInteger)1, [@"ab" distanceFromString:@"ba"], @"Simple transposition test failed.");
#endif
}

#ifndef DISABLE_DAMERAU_TRANSPOSITION
- (void)test_restricted {
	STAssertEquals((NSUInteger)3, [@"CA" distanceFromString:@"ABC"], @"Restricted test failed.");
}
#endif

- (void)test_case_insensitive {
	levensteinDistance = [@"a" distanceFromString:@"A" 
										  options:JXLDCaseInsensitiveComparison];
	STAssertEquals((NSUInteger)0, levensteinDistance, @"Case insensitive test failed.");
}

- (void)test_literal {
	NSString *nWithTilde = @"\U000000F1";
	NSString *nWithTildeDecomposed = @"n\U00000303";
	
	levensteinDistance = [nWithTilde distanceFromString:nWithTildeDecomposed 
												options:0];
	STAssertEquals((NSUInteger)0, levensteinDistance, @"Non-literal test failed.");
	
	levensteinDistance = [nWithTilde distanceFromString:nWithTildeDecomposed 
												options:JXLDLiteralComparison];
	STAssertEquals((NSUInteger)2, levensteinDistance, @"Literal test failed.");
}

@end