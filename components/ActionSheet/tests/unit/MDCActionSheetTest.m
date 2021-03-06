// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MaterialActionSheet.h"

#import <XCTest/XCTest.h>

#import "../../src/private/MDCActionSheetHeaderView.h"

@interface MDCActionSheetHeaderView (Testing)
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;
@end

@interface MDCActionSheetController (Testing)
@property(nonatomic, strong) MDCActionSheetHeaderView *header;
@end

@interface MDCActionSheetTest : XCTestCase
@property(nonatomic, strong) MDCActionSheetController *actionSheet;
@end

@implementation MDCActionSheetTest

- (void)setUp {
  [super setUp];

  self.actionSheet = [[MDCActionSheetController alloc] init];
}

- (void)testTitleColor {
  // When
  self.actionSheet.title = @"Test";

  // Then
  UIColor *expectedColor = [UIColor.blackColor colorWithAlphaComponent:0.6f];
  UIColor *titleColor = self.actionSheet.header.titleLabel.textColor;
  XCTAssertEqualObjects(titleColor, expectedColor);
}

- (void)testMessageColor {
  // When
  self.actionSheet.message = @"Test";

  // Then
  UIColor *expectedColor = [UIColor.blackColor colorWithAlphaComponent:0.6f];
  UIColor *messageColor = self.actionSheet.header.messageLabel.textColor;
  XCTAssertEqualObjects(messageColor, expectedColor);
}

- (void)testTitleAndMessageColor {
  // When
  self.actionSheet.title = @"Test title";
  self.actionSheet.message = @"Test message";

  // Then
  UIColor *expectedTitleColor = [UIColor.blackColor colorWithAlphaComponent:0.87f];
  UIColor *titleColor = self.actionSheet.header.titleLabel.textColor;
  XCTAssertEqualObjects(titleColor, expectedTitleColor);

  UIColor *expectedMessageColor = [UIColor.blackColor colorWithAlphaComponent:0.6f];
  UIColor *messageColor = self.actionSheet.header.messageLabel.textColor;
  XCTAssertEqualObjects(messageColor, expectedMessageColor);
}

- (void)testTitleAndMessageColorWhenMessageSetFirst {
  // When
  self.actionSheet.message = @"Test message";
  self.actionSheet.title = @"Test title";

  // Then
  UIColor *expectedTitleColor = [UIColor.blackColor colorWithAlphaComponent:0.87f];
  UIColor *titleColor = self.actionSheet.header.titleLabel.textColor;
  XCTAssertEqualObjects(titleColor, expectedTitleColor);

  UIColor *expectedMessageColor = [UIColor.blackColor colorWithAlphaComponent:0.6f];
  UIColor *messageColor = self.actionSheet.header.messageLabel.textColor;
  XCTAssertEqualObjects(messageColor, expectedMessageColor);
}

- (void)testTitleAndMessageCustomRGBColor {
  // Given
  self.actionSheet.title = @"Test title";
  self.actionSheet.message = @"Test message";

  // When
  UIColor *titleColor = [UIColor colorWithRed:0.5f green:0.7f blue:0.9f alpha:1.0f];
  UIColor *messageColor = [UIColor colorWithRed:0.9f green:0.7f blue:0.5f alpha:1.0f];

  self.actionSheet.titleTextColor = titleColor;
  self.actionSheet.messageTextColor = messageColor;

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.textColor, titleColor);
  XCTAssertEqualObjects(self.actionSheet.header.messageLabel.textColor, messageColor);
}

- (void)testTitleAndMessageCustomHSBColor {
  // Given
  self.actionSheet.title = @"Test title";
  self.actionSheet.message = @"Test message";

  // When
  UIColor *titleColor = [UIColor colorWithHue:0.5f saturation:0.7f brightness:0.9f alpha:1.0f];
  UIColor *messageColor = [UIColor colorWithHue:0.9f saturation:0.7f brightness:0.5f alpha:1.0f];

  self.actionSheet.titleTextColor = titleColor;
  self.actionSheet.messageTextColor = messageColor;

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.textColor, titleColor);
  XCTAssertEqualObjects(self.actionSheet.header.messageLabel.textColor, messageColor);
}

- (void)testTitleAndMessageCustomColor {
  // Given
  self.actionSheet.title = @"Test title";
  self.actionSheet.message = @"Test message";

  // When
  UIColor *titleColor = [UIColor.blackColor colorWithAlphaComponent:0.3f];
  UIColor *messageColor = [UIColor.blackColor colorWithAlphaComponent:0.2f];

  self.actionSheet.titleTextColor = titleColor;
  self.actionSheet.messageTextColor = messageColor;

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.textColor, titleColor);
  XCTAssertEqualObjects(self.actionSheet.header.messageLabel.textColor, messageColor);
}

- (void)testTitleAndMessageColorCorrectAlpha {
  // Given
  self.actionSheet.title = @"Test title";
  self.actionSheet.message = @"Test message";
  UIColor *titleColor = UIColor.blackColor;
  UIColor *messageColor = UIColor.blackColor;

  // When
  UIColor *titleColorChangeAlpha = [titleColor colorWithAlphaComponent:0.6f];
  UIColor *messageColorChangeAlpha = [messageColor colorWithAlphaComponent:0.5f];

  self.actionSheet.titleTextColor = titleColorChangeAlpha;
  self.actionSheet.messageTextColor = messageColorChangeAlpha;

  // Then
  XCTAssertFalse([titleColor isEqual:self.actionSheet.header.titleLabel.textColor]);
  XCTAssertFalse([messageColor isEqual:self.actionSheet.header.messageLabel.textColor]);
}

- (void)testSetTitleAndMessageAfterCustomColorsSet {
  // Given
  UIColor *titleColor = UIColor.blueColor;
  UIColor *messageColor = UIColor.redColor;

  // When
  self.actionSheet.titleTextColor = titleColor;
  self.actionSheet.messageTextColor = messageColor;
  self.actionSheet.title = @"Test title";
  self.actionSheet.message = @"Test message";

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.textColor, titleColor);
  XCTAssertEqualObjects(self.actionSheet.header.messageLabel.textColor, messageColor);
}

- (void)testTitleCustomDoesNotChangeAfterSetMessage {
  // Given
  UIColor *titleColor = [UIColor.blueColor colorWithAlphaComponent:0.6f];
  self.actionSheet.title = @"Test title";

  // When
  self.actionSheet.titleTextColor = titleColor;
  self.actionSheet.message = @"Test message";

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.textColor, titleColor);
}

- (void)testSetNilTitleAndMessageColor {
  // Given
  self.actionSheet.title = @"Test title";
  self.actionSheet.message = @"Test message";

  // When
  self.actionSheet.titleTextColor = nil;
  self.actionSheet.messageTextColor = nil;

  // Then
  XCTAssertEqualObjects(self.actionSheet.header.titleLabel.textColor,
                        [UIColor.blackColor colorWithAlphaComponent:0.87f]);
  XCTAssertEqualObjects(self.actionSheet.header.messageLabel.textColor,
                        [UIColor.blackColor colorWithAlphaComponent:0.6f]);
}

@end
