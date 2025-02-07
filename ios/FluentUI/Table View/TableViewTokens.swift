//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//
import UIKit

open class TableViewCellTokens: ControlTokens {
    /// The background color of the TableView.
    open var backgroundColor: DynamicColor {
        .init(light: globalTokens.neutralColors[.white],
              dark: globalTokens.neutralColors[.black])
    }

    /// The grouped background color of the TableView.
    open var backgroundGroupedColor: DynamicColor {
        .init(light: aliasTokens.backgroundColors[.neutral2].light,
              dark: aliasTokens.backgroundColors[.neutral1].dark)
    }

    /// The background color of the TableViewCell.
    open var cellBackgroundColor: DynamicColor {
        .init(light: aliasTokens.backgroundColors[.neutral1].light,
              dark: aliasTokens.backgroundColors[.neutral1].dark,
              darkElevated: aliasTokens.backgroundColors[.neutral2].darkElevated)
    }

    /// The grouped background color of the TableViewCell.
    open var cellBackgroundGroupedColor: DynamicColor {
        .init(light: aliasTokens.backgroundColors[.neutral1].light,
              dark: aliasTokens.backgroundColors[.neutral3].dark,
              darkElevated: ColorValue(0x212121))
    }

    /// The selected background color of the TableViewCell.
    open var cellBackgroundSelectedColor: DynamicColor { aliasTokens.backgroundColors[.neutral5] }

    /// The leading image color.
    open var imageColor: DynamicColor { aliasTokens.foregroundColors[.neutral1] }

    /// The size dimensions of the customView.
    open var customViewDimensions: CGSize {
        switch customViewSize {
        case .zero:
            return .zero
        case .small:
            return CGSize(width: globalTokens.iconSize[.medium],
                          height: globalTokens.iconSize[.medium])
        case .medium, .default:
            return CGSize(width: globalTokens.iconSize[.xxLarge],
                          height: globalTokens.iconSize[.xxLarge])
        }
    }

    /// The trailing margin of the customView.
    open var customViewTrailingMargin: CGFloat {
        switch customViewSize {
        case .zero:
            return globalTokens.spacing[.none]
        case .small:
            return globalTokens.spacing[.medium]
        case .medium, .default:
            return globalTokens.spacing[.small]
        }
    }

    /// The title label color.
    open var titleColor: DynamicColor { aliasTokens.foregroundColors[.neutral1] }

    /// The subtitle label color.
    open var subtitleColor: DynamicColor { aliasTokens.foregroundColors[.neutral3] }

    /// The footer label color.
    open var footerColor: DynamicColor { aliasTokens.foregroundColors[.neutral3] }

    /// The color of the selectionImageView when it is not selected.
    open var selectionIndicatorOffColor: DynamicColor { aliasTokens.foregroundColors[.neutral3] }

    /// The font for the title.
    open var titleFont: FontInfo { aliasTokens.typography[.body1] }

    /// The font for the subtitle when the TableViewCell has two lines.
    open var subtitleTwoLinesFont: FontInfo { aliasTokens.typography[.caption1] }

    /// The font for the subtitle when the TableViewCell has three lines.
    open var subtitleThreeLinesFont: FontInfo { aliasTokens.typography[.body2] }

    /// The font for the footer.
    open var footerFont: FontInfo { aliasTokens.typography[.caption1] }

    /// The minimum height for the title label.
    open var titleHeight: CGFloat { 22 }

    /// The minimum height for the subtitle label when the TableViewCell has two lines.
    open var subtitleTwoLineHeight: CGFloat { 18 }

    /// The minimum height for the subtitle label when the TableViewCell has three lines.
    open var subtitleThreeLineHeight: CGFloat { 20 }

    /// The minimum height for the footer label.
    open var footerHeight: CGFloat { 18 }

    /// The leading margin for the labelAccessoryView.
    open var labelAccessoryViewMarginLeading: CGFloat { globalTokens.spacing[.xSmall] }

    /// The trailing margin for the labelAccessoryView.
    open var labelAccessoryViewMarginTrailing: CGFloat { globalTokens.spacing[.xSmall] }

    /// The leading margin for the customAccessoryView.
    open var customAccessoryViewMarginLeading: CGFloat { globalTokens.spacing[.xSmall] }

    /// The minimum vertical margin for the customAccessoryView.
    open var customAccessoryViewMinVerticalMargin: CGFloat { 6 }

    /// The vertical margin for the label when it has one or three lines.
    open var labelVerticalMarginForOneAndThreeLines: CGFloat { 11 }

    /// The vertical margin for the label when it has two lines.
    open var labelVerticalMarginForTwoLines: CGFloat { globalTokens.spacing[.small] }

    /// The vertical spacing for the label.
    open var labelVerticalSpacing: CGFloat { globalTokens.spacing[.none] }

    /// The minimum TableViewCell height; the height of a TableViewCell with one line of text.
    open var minHeight: CGFloat { globalTokens.spacing[.xxxLarge] }

    /// The height of a TableViewCell with two lines of text.
    open var mediumHeight: CGFloat { 64 }

    /// The height of a TableViewCell with three lines of text.
    open var largeHeight: CGFloat { 84 }

    /// The trailing margin for the selectionImage.
    open var selectionImageMarginTrailing: CGFloat { globalTokens.spacing[.medium] }

    /// The size for the selectionImage.
    open var selectionImageSize: CGSize { CGSize(width: globalTokens.iconSize[.medium], height: globalTokens.iconSize[.medium]) }

    /// The duration for the selectionModeAnimation.
    open var selectionModeAnimationDuration: TimeInterval { 0.2 }

    /// The minimum width for any text area.
    open var textAreaMinWidth: CGFloat { 100 }

    /// The alpha value that enables the user's ability to interact with a cell.
    open var enabledAlpha: CGFloat { 1 }

    /// The alpha value that disables the user's ability to interact with a cell; dims cell's contents.
    open var disabledAlpha: CGFloat { 0.35 }

    /// The default horizontal spacing in the cell.
    open var horizontalSpacing: CGFloat { globalTokens.spacing[.medium] }

    /// The leading padding in the cell.
    open var paddingLeading: CGFloat { globalTokens.spacing[.medium] }

    /// The vertical padding in the cell.
    open var paddingVertical: CGFloat { 11 }

    /// The trailing padding in the cell.
    open var paddingTrailing: CGFloat { globalTokens.spacing[.medium] }

    /// The color for the accessoryDisclosureIndicator.
    open var accessoryDisclosureIndicatorColor: DynamicColor { aliasTokens.foregroundColors[.neutral4] }

    /// The color for the accessoryDetailButtonColor.
    open var accessoryDetailButtonColor: DynamicColor { aliasTokens.foregroundColors[.neutral3] }

    /// The main primary brand color of the theme.
    open var mainBrandColor: DynamicColor { globalTokens.brandColors[.primary] }

    /// Defines the size of the customView size.
    public internal(set) var customViewSize: MSFTableViewCellCustomViewSize = .default
}

/// Pre-defined sizes of the customView size.
@objc public enum MSFTableViewCellCustomViewSize: Int, CaseIterable {
    case `default`
    case zero
    case small
    case medium
}

open class ActionsCellTokens: TableViewCellTokens {
    /// The destructive text color in an ActionsCell.
    open var destructiveTextColor: DynamicColor { DynamicColor(light: ColorValue(0xD92C2C),
                                                    dark: ColorValue(0xE83A3A)) }

    /// The communication text color in an ActionsCell.
    open var communicationTextColor: DynamicColor { DynamicColor(light: ColorValue(0x0078D4),
                                                    dark: ColorValue(0x0086F0)) }
}
