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

#import "Library.h"
#import "Loan.h"

#include <Foundation/NSSet.h>

@interface Library ()

- checkOutBook:book;
- enterLoanIntoLedgerForBorrower:borrower borrowingBook:book;

@end

@implementation Library

- init
{
  self = [super init];
  if (self) {
    _bookStack = [NSCountedSet new];
    _lendingLedger = [NSMutableSet new];
  };
  return self;
}

- (oneway void)dealloc
{
  [_bookStack release];
  [_lendingLedger release];
  [super dealloc];
}

- checkInBook:book fromBorrower:borrower
{
  [_lendingLedger removeObject: [Loan ofBook:book toBorrower:borrower]];
  [_bookStack addObject:book];
  return self;
}

- checkOutBook:book toBorrower:borrower
{
  [[self checkOutBook:book] enterLoanIntoLedgerForBorrower:borrower
					     borrowingBook:book];
  return self;
}

- checkOutBook:book
{
  NSInteger availableCopies = [_bookStack countForObject:book];
  [_bookStack removeObject:book];
  return (availableCopies) ? self : nil;
}

- enterLoanIntoLedgerForBorrower:borrower borrowingBook:book
{
  [_lendingLedger addObject:[Loan ofBook:book toBorrower:borrower]];
  return self;
}

- addBook:book
{
  [_bookStack addObject:book];
  return self;
}

- withdrawBook:book
{
  [_bookStack removeObject:book];
  return self;
}

@end
