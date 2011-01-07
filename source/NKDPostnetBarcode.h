/*
 Copyright (c) 2002 Jeff LaMarche
 
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


#import <Foundation/Foundation.h>
#import "NKDBarcode.h"
/*!
 @header NKDPostnetBarcode.h

 This is a concrete subclass of NKDBarcode that implements a two of five barcode that uses the <i>height</i>
 of the bars, rather than the width, to encode numeric data according to US Postal Service specifications.

 We are using a bar width of .015" and a gap space of .030" - this spacing is within the US Postal
 Service's specs and since the gap space is exactly twice the bar width, we can represent the gap
 with two zeros and represent all bars as one one. The real logic for this barcode is in the barTop
 method, which makes it a somewhat unusual subclass of NKDBarcode.
 */

/*!
 @defined TALL_BAR
 @discussion Defines the height, according to USPS specification, of a tall bar
 */
#define	TALL_BAR .125

/*!
 @defined SHORT_BAR
 @discussion Defines the height, according to USPS specification, of a short bar
 */
#define SHORT_BAR .05

/*!
 @class NKDPostnetBarcode
 @abstract US Postal Service mail routing bar code
 @discussion This is a two of five barcode that uses the <i>height</i> of the bars, rather
            than the width, to encode numeric data
 */
@interface NKDPostnetBarcode : NKDBarcode
{

}
/*!
 @method initWithContent:printsCaption
 @abstract Overridden method that sets values for this barcode according to USPS specifications
 @discussion    We are using a bar width of .015" and a gap space of .030" - this spacing is within the US Postal
                Service's specs and since the gap space is exactly twice the bar width, we can represent the gap
                with two zeros and represent all bars as one one. The real logic for this barcode is in the barTop
                method, which makes it a somewhat unusual subclass of NKDBarcode.

                This constructor also calculates the checkdigit; Check digit is a mandatory part of PostNet.
 @param inContent The content to be encoded
 @param inPrints Ignored; PostNet never uses a caption.
 @result Initialized barcode encoding <i>content</i> using PostNet encoding
 */
-(id)initWithContent: (NSString *)inContent
       printsCaption: (BOOL)inPrints;

/*!
 @method printsCaption
 @abstract Overridden because PostNet NEVER uses a caption
 @result NO
 */
-(BOOL)printsCaption;

/*!
 @method initiator
 @abstract Initiator in PostNet is a single tall bar plus a gap of twice the bar width.
 @result "100"
 */
-(NSString *)initiator;
/*!
 @method terminator
 @abstract Terminating character in PostNet is a single tall bar.
 @result "1"
 */
-(NSString *)terminator;

/*!
 @method _encodeChar:
 @abstract Simple routine to return five bars separated by double-width gaps
 @discussion All postnet characters are five equally spaced bars of the same width; the encoding is in the bar
 heights, so the real work of this subclass is done in the barTop: method
 @result "100100100100100"
 */
-(NSString *)_encodeChar:(char)inChar;

/*!
 @method barTop:
 @abstract Returns the location of the top of a specified bar (assuming origin at lower left)
 @discussion This method calls out to _heightForDigit:andBar: to find out if a given bar should be a tall bar or short
            bar. The top value for tall and short bars are defined constants TALL_BAR and SHORT_BAR
 @result TALL_BAR or SHORT_BAR corresponding to the top of the specified bar
 */
-(float)barTop:(int)index;

/*!
 @method generateChecksum
 @abstract Generates a simple check digit that is modulus 10 algorithm - add up all the digits, and then however many you
            need to add to that sum to make it evenly divisible by 10 is the check digit character
 */

/*!
 @method isContentValid
 @abstract Validates that this barcode supports the data it is encoding.
 @discussion Enforces numerics only and length of content; does not validate check digit.
 */
-(BOOL) isContentValid;

-(void)generateChecksum;
/*!
 @method _heightForDigit:andBar:
 @abstract Private method used by the overridden _encodeChar, to determine whether to use a tall or short
            bar at a given bar for a particular numeric character
 @param index Integer that specifies the index (0-4 because it's a 2 of 5 code) within an encoded character
 @param bar Index within <i>content</i> of the character we're asking about
 @result Either TALL_BAR or SHORT_BAR.
 */
-(float)_heightForDigit:(int)index
                andBar:(int)bar;
@end
