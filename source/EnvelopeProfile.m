/*
 Copyright (c) 2011 Nik Sanz
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "EnvelopeProfile.h"

@implementation EnvelopeProfile

- (id)init
{
    if (!(self = [self initWithPrintInfo:[NSPrintInfo sharedPrintInfo]])) return nil;
    return self;
}

- (id)initWithPrintInfo:(NSPrintInfo *)info
{
    if (!(self = [super init])) return nil;

    [self setPrintInfo:info];

    [self setMarginFromLeft:20];
    [self setMarginFromRight:300];
    [self setMarginFromTop:20];
    [self setMarginFromBottom:200];
    [self setMarginToLeft:250];
    [self setMarginToRight:20];
    [self setMarginToTop:150];
    [self setMarginToBottom:40];
	
	[self setPrefs:[[NSMutableDictionary alloc] init]];

    return self;
}


- (id)initWithCoder:(NSCoder *)coder
{
    int i;
    NSInteger version = [coder versionForClassName:@"EnvelopeProfile"];
	NSMutableDictionary *infoDict;
    NSArray *dictKeys;
	NSString *key;
	
	if (!(self = [self init])) return nil;
    
    // Encoding/decoding printInfo object does not work correctly for custom
    // paper sizes, so encode/decode it's dictionary instead.

    infoDict = [coder decodeObject];
    dictKeys = [infoDict allKeys];
    
	[self setPrintInfo:[NSPrintInfo sharedPrintInfo]];

    for ( i = 0; i < [dictKeys count]; i++ )
    {
		key = [dictKeys objectAtIndex:i];
		if ( ! [key isEqualToString:NSPrintJobDisposition] )
			[[[self printInfo] dictionary] setObject:[infoDict objectForKey:key] forKey:key];
    }

    [coder decodeValueOfObjCType:"i" at:&marginFromLeft];
    [coder decodeValueOfObjCType:"i" at:&marginFromRight];
    [coder decodeValueOfObjCType:"i" at:&marginFromTop];
    [coder decodeValueOfObjCType:"i" at:&marginFromBottom];
    [coder decodeValueOfObjCType:"i" at:&marginToLeft];
    [coder decodeValueOfObjCType:"i" at:&marginToRight];
    [coder decodeValueOfObjCType:"i" at:&marginToTop];
    [coder decodeValueOfObjCType:"i" at:&marginToBottom];
	
	if ( version > 0 )
	{
		[self setPrefs:[coder decodeObject]];
	}
	else
	{
		//  For pre 0.6.5 versions, move most prefs from top level of prefs to within the envelope profile(s)
		NSLog(@"Old version.  Moving top-level prefs to profile prefs.");
		
		[prefs setValue:[NSNumber numberWithLong:[[NSUserDefaults standardUserDefaults] integerForKey:@"hide_to_prefix"]] forKey:@"hide_to_prefix"];
		[prefs setValue:[NSNumber numberWithLong:[[NSUserDefaults standardUserDefaults] integerForKey:@"hide_to_suffix"]] forKey:@"hide_to_suffix"];
		[prefs setValue:[NSNumber numberWithLong:[[NSUserDefaults standardUserDefaults] integerForKey:@"hide_from_prefix"]] forKey:@"hide_from_prefix"];
		[prefs setValue:[NSNumber numberWithLong:[[NSUserDefaults standardUserDefaults] integerForKey:@"hide_from_suffix"]] forKey:@"hide_from_suffix"];

		[prefs setValue:[NSNumber numberWithLong:[[NSUserDefaults standardUserDefaults] integerForKey:@"hide_from_country"]] forKey:@"hide_from_country"];
		[prefs setValue:[NSNumber numberWithLong:[[NSUserDefaults standardUserDefaults] integerForKey:@"hide_from_same_country"]] forKey:@"hide_from_same_country"];
		[prefs setValue:[NSNumber numberWithLong:[[NSUserDefaults standardUserDefaults] integerForKey:@"hide_to_country"]] forKey:@"hide_to_country"];
		
		[prefs setValue:[NSNumber numberWithLong:[[NSUserDefaults standardUserDefaults] integerForKey:@"hide_from_title"]] forKey:@"hide_from_title"];
		[prefs setValue:[NSNumber numberWithLong:[[NSUserDefaults standardUserDefaults] integerForKey:@"hide_from_name"]] forKey:@"hide_from_name"];
		[prefs setValue:[NSNumber numberWithLong:[[NSUserDefaults standardUserDefaults] integerForKey:@"hide_from_job_title"]] forKey:@"hide_from_job_title"];
		[prefs setValue:[NSNumber numberWithLong:[[NSUserDefaults standardUserDefaults] integerForKey:@"hide_from_company"]] forKey:@"hide_from_company"];
		
		[prefs setValue:[NSNumber numberWithLong:[[NSUserDefaults standardUserDefaults] integerForKey:@"hide_to_title"]] forKey:@"hide_to_title"];
		[prefs setValue:[NSNumber numberWithLong:[[NSUserDefaults standardUserDefaults] integerForKey:@"hide_to_name"]] forKey:@"hide_to_name"];
		[prefs setValue:[NSNumber numberWithLong:[[NSUserDefaults standardUserDefaults] integerForKey:@"hide_to_job_title"]] forKey:@"hide_to_job_title"];
		[prefs setValue:[NSNumber numberWithLong:[[NSUserDefaults standardUserDefaults] integerForKey:@"hide_to_company"]] forKey:@"hide_to_company"];
		
		[prefs setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"from_prefix"] forKey:@"from_prefix"];
		[prefs setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"from_suffix"] forKey:@"from_suffix"];
		[prefs setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"to_prefix"] forKey:@"to_prefix"];
		[prefs setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"to_suffix"] forKey:@"to_suffix"];
		
		if ( [[NSUserDefaults standardUserDefaults] objectForKey:@"to_attributes"] )
			[prefs setValue:[NSUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"to_attributes"]] forKey:@"to_attributes"];
		if ( [[NSUserDefaults standardUserDefaults] objectForKey:@"from_attributes"] )
			[prefs setValue:[NSUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"from_attributes"]] forKey:@"from_attributes"];
		
		if ( [[NSUserDefaults standardUserDefaults] objectForKey:@"background_content"] )
			[prefs setValue:[NSUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"background_content"]]  forKey:@"background_content"];
		}
	
	//  Localise attributes strings and make sure that all required field attributes are included in the correct orders and ranges
	
	//  Set text attributes
	
	if ( ! [prefs objectForKey:@"to_attributes"] )
		[prefs setObject:[[AddressManager sharedAddressManager] defaultAddressAttributesString] forKey:@"to_attributes"];
	
	if ( ! [prefs objectForKey:@"from_attributes"] )
		[prefs setObject:[[AddressManager sharedAddressManager] defaultAddressAttributesString] forKey:@"from_attributes"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [EnvelopeProfile setVersion:1];
	
	// Encoding/decoding printInfo object does not work correctly for custom
    // paper sizes, so encode/decode it's dictionary instead.

    [coder encodeObject:[[self printInfo] dictionary]];
    
    [coder encodeValueOfObjCType:"i" at:&marginFromLeft];
    [coder encodeValueOfObjCType:"i" at:&marginFromRight];
    [coder encodeValueOfObjCType:"i" at:&marginFromTop];
    [coder encodeValueOfObjCType:"i" at:&marginFromBottom];
    [coder encodeValueOfObjCType:"i" at:&marginToLeft];
    [coder encodeValueOfObjCType:"i" at:&marginToRight];
    [coder encodeValueOfObjCType:"i" at:&marginToTop];
    [coder encodeValueOfObjCType:"i" at:&marginToBottom];
	
	[coder encodeObject:prefs];
}

- (id)copyWithZone:(NSZone *)zone
{
	EnvelopeProfile *profile = [NSUnarchiver unarchiveObjectWithData:[NSArchiver archivedDataWithRootObject:self]];
	
	return profile;
}

- (NSPrintInfo *)printInfo
{
    return printInfo;
}

- (void)setPrintInfo:(NSPrintInfo *)info
{
//    [printInfo autorelease];
	[[info dictionary] setValue:@"nil" forKey:NSPrintJobDisposition];
    printInfo = [info copy];
}

- (void)setPrintInfoLeftMargin
{
    if ( marginFromLeft < marginToLeft )
	[[self printInfo] setLeftMargin:marginFromLeft];
    else
	[[self printInfo] setLeftMargin:marginToLeft];
}

- (void)setPrintInfoRightMargin
{
    if ( marginFromRight < marginToRight )
	[[self printInfo] setRightMargin:marginFromRight];
    else
	[[self printInfo] setRightMargin:marginToRight];
}

- (void)setPrintInfoTopMargin
{
    if ( marginFromTop < marginToTop )
	[[self printInfo] setTopMargin:marginFromTop];
    else
	[[self printInfo] setTopMargin:marginToTop];
}

- (void)setPrintInfoBottomMargin
{
    if ( marginFromBottom < marginToBottom )
	[[self printInfo] setBottomMargin:marginFromBottom];
    else
	[[self printInfo] setBottomMargin:marginToBottom];
}

- (int)marginFromLeft
{
    return marginFromLeft;
}

- (void)setMarginFromLeft:(int)points
{
    marginFromLeft = points;
    [self setPrintInfoLeftMargin];
}

- (int)marginFromRight
{
    return marginFromRight;
}

- (void)setMarginFromRight:(int)points
{
    marginFromRight = points;
    [self setPrintInfoRightMargin];
}

- (int)marginFromTop
{
    return marginFromTop;
}

- (void)setMarginFromTop:(int)points
{
    marginFromTop = points;
    [self setPrintInfoTopMargin];
}

- (int)marginFromBottom
{
    return marginFromBottom;
}

- (void)setMarginFromBottom:(int)points
{
    marginFromBottom = points;
    [self setPrintInfoBottomMargin];
}

- (int)marginToLeft
{
    return marginToLeft;
}

- (void)setMarginToLeft:(int)points
{
    marginToLeft = points;
    [self setPrintInfoLeftMargin];
}

- (int)marginToRight
{
    return marginToRight;
}

- (void)setMarginToRight:(int)points
{
    marginToRight = points;
    [self setPrintInfoRightMargin];
}

- (int)marginToTop
{
    return marginToTop;
}

- (void)setMarginToTop:(int)points
{
    marginToTop = points;
    [self setPrintInfoTopMargin];
}

- (int)marginToBottom
{
    return marginToBottom;
}

- (void)setMarginToBottom:(int)points
{
    marginToBottom = points;
    [self setPrintInfoBottomMargin];
}

- (NSMutableDictionary *)prefs
{
	if ( ! prefs )
		[self setPrefs:[[NSMutableDictionary alloc] init]];

	return prefs;
}

- (void)setPrefs:(NSMutableDictionary *)aDict
{
	prefs = [aDict mutableCopy];
}

@end
