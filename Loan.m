/* 
   Project: PolyLibrary

   Author: Graham Lee

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#import "Loan.h"

#include <Foundation/NSDate.h>

@interface Loan ()

- initWithBook:book borrower:borrower;

@end

@implementation Loan

+ ofBook:book toBorrower:borrower
{
  return [[[self alloc] initWithBook:book borrower:borrower] autorelease];
}

static const NSTimeInterval twoWeeks = 86400*14;

- initWithBook:book borrower:borrower
{
  self = [super init];
  if (self) {
    _book = [book retain];
    _borrower = [borrower retain];
    _dueDate = [[NSDate dateWithTimeIntervalSinceNow:twoWeeks] retain];
  }
  return self;
}

- (oneway void)dealloc
{
  [_book release];
  [_borrower release];
  [_dueDate release];
  [super dealloc];
}

- (BOOL)isEqualTo:other
{
  if ([other isKindOfClass:[self class]]) {
    Loan *otherLoan = other;
    return [_book isEqualTo: otherLoan->_book] &&
      [_borrower isEqualTo: otherLoan->_borrower];
  } else {
    return NO;
  }
}

@end
