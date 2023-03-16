//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit
import Combine

// MARK: PillButton

/// A `PillButton` is a button in the shape of a pill that can have two states: on (Selected) and off (not selected)
@objc(MSFPillButton)
open class PillButton: UIButton, TokenizedControlInternal {

    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        guard let newWindow else {
            return
        }
        tokenSet.update(newWindow.fluentTheme)
        updateAppearance()
    }

    @objc public init(pillBarItem: PillButtonBarItem,
                      style: PillButtonStyle = .primary) {
        self.pillBarItem = pillBarItem
        self.style = style
        self.tokenSet = PillButtonTokenSet(style: { style })
        super.init(frame: .zero)
        setupView()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(isUnreadValueDidChange),
                                               name: PillButtonBarItem.isUnreadValueDidChangeNotification,
                                               object: pillBarItem)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(titleValueDidChange),
                                               name: PillButtonBarItem.titleValueDidChangeNotification,
                                               object: pillBarItem)

        tokenSet.registerOnUpdate(for: self) { [weak self] in
            self?.updateAppearance()
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        updateUnreadDot()
    }

    public override var isSelected: Bool {
        didSet {
            if oldValue != isSelected && isSelected == true {
                pillBarItem.isUnread = false
                updateUnreadDot()
            }
            updateAppearance()
            updateAccessibilityTraits()
        }
    }

    public override var isEnabled: Bool {
        didSet {
            updateAppearance()
            updateAccessibilityTraits()
        }
    }

    public override var isHighlighted: Bool {
        didSet {
            updateAppearance()
        }
    }

    @objc public static let cornerRadius: CGFloat = 16.0

    @objc public let pillBarItem: PillButtonBarItem

    @objc public let style: PillButtonStyle

    public typealias TokenSetKeyType = PillButtonTokenSet.Tokens
    public var tokenSet: PillButtonTokenSet

    lazy var unreadDotColor: UIColor = {
        UIColor(dynamicColor: tokenSet[.enabledUnreadDotColor].dynamicColor)
    }()

    private func setupView() {
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()

            configuration.contentInsets = NSDirectionalEdgeInsets(top: PillButtonTokenSet.topInset,
                                                                  leading: PillButtonTokenSet.horizontalInset,
                                                                  bottom: PillButtonTokenSet.bottomInset,
                                                                  trailing: PillButtonTokenSet.horizontalInset)
            self.configuration = configuration

            // This updates the attributed title stored in self.configuration,
            // so it needs to be called after we set the configuration.
            updateAttributedTitle()

            configurationUpdateHandler = { [weak self] _ in
                self?.updateAppearance()
            }
        } else {
            setTitle(pillBarItem.title, for: .normal)
            titleLabel?.font = UIFont.fluent(tokenSet[.font].fontInfo, shouldScale: false)

            contentEdgeInsets = UIEdgeInsets(top: PillButtonTokenSet.topInset,
                                             left: PillButtonTokenSet.horizontalInset,
                                             bottom: PillButtonTokenSet.bottomInset,
                                             right: PillButtonTokenSet.horizontalInset)
        }

        layer.cornerRadius = PillButton.cornerRadius
        clipsToBounds = true

        layer.cornerCurve = .continuous
        largeContentTitle = titleLabel?.text
        showsLargeContentViewer = true
    }

    private func updateAccessibilityTraits() {
        if isSelected {
            accessibilityTraits.insert(.selected)
        } else {
            accessibilityTraits.remove(.selected)
        }

        if isEnabled {
            accessibilityTraits.remove(.notEnabled)
        } else {
            accessibilityTraits.insert(.notEnabled)
        }
    }

    private func initUnreadDotLayer() -> CALayer {
        let unreadDotLayer = CALayer()

        unreadDotLayer.bounds.size = CGSize(width: PillButtonTokenSet.unreadDotSize, height: PillButtonTokenSet.unreadDotSize)
        unreadDotLayer.cornerRadius = PillButtonTokenSet.unreadDotSize / 2

        return unreadDotLayer
    }

    @objc private func isUnreadValueDidChange() {
        isUnreadDotVisible = pillBarItem.isUnread
        setNeedsLayout()
    }

    private lazy var unreadDotLayer: CALayer = {
        let unreadDotLayer = CALayer()
        let unreadDotSize = PillButtonTokenSet.unreadDotSize
        unreadDotLayer.bounds.size = CGSize(width: unreadDotSize, height: unreadDotSize)
        unreadDotLayer.cornerRadius = unreadDotSize / 2
        return unreadDotLayer
    }()

    @objc private func titleValueDidChange() {
        if #available(iOS 15.0, *) {
            updateAttributedTitle()
        } else {
            setTitle(pillBarItem.title, for: .normal)
        }
    }

    @available(iOS 15, *)
    private func updateAttributedTitle() {
        let itemTitle = pillBarItem.title
        var attributedTitle = AttributedString(itemTitle)
        attributedTitle.font = UIFont.fluent(tokenSet[.font].fontInfo, shouldScale: false)
        configuration?.attributedTitle = attributedTitle

        let attributedTitleTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.fluent(self.tokenSet[.font].fontInfo, shouldScale: false)
            return outgoing
        }
        configuration?.titleTextAttributesTransformer = attributedTitleTransformer

        // Workaround for Apple bug: when UIButton.Configuration is used with UIControl's isSelected = true, accessibilityLabel doesn't get set automatically
        accessibilityLabel = itemTitle

        // This sets colors on the attributed string, so it must run whenever we recreate it.
        updateAppearance()
    }

    private func updateUnreadDot() {
        isUnreadDotVisible = pillBarItem.isUnread
        if isUnreadDotVisible {
            let anchor = self.titleLabel?.frame ?? .zero
            let xPos: CGFloat
            if effectiveUserInterfaceLayoutDirection == .leftToRight {
                xPos = round(anchor.maxX + PillButtonTokenSet.unreadDotOffsetX)
            } else {
                xPos = round(anchor.minX - PillButtonTokenSet.unreadDotOffsetX - PillButtonTokenSet.unreadDotSize)
            }
            unreadDotLayer.frame.origin = CGPoint(x: xPos, y: anchor.minY + PillButtonTokenSet.unreadDotOffsetY)
            unreadDotLayer.backgroundColor = unreadDotColor.cgColor
        }
    }

    private var isUnreadDotVisible: Bool = false {
        didSet {
            if oldValue != isUnreadDotVisible {
                if isUnreadDotVisible {
                    layer.addSublayer(unreadDotLayer)
                    accessibilityLabel = String(format: "Accessibility.TabBarItemView.UnreadFormat".localized, pillBarItem.title)
                } else {
                    unreadDotLayer.removeFromSuperlayer()
                    accessibilityLabel = pillBarItem.title
                }
            }
        }
    }

    private func updateAppearance() {
        // TODO: Once iOS 14 support is dropped, these should be converted to constants (let) that will be initialized by the logic below.
        var resolvedBackgroundColor: UIColor = .clear
        var resolvedTitleColor: UIColor = .clear

        if isSelected {
            if isEnabled {
                resolvedBackgroundColor = UIColor(dynamicColor: tokenSet[.backgroundColorSelected].dynamicColor)
                if #available(iOS 15.0, *) {
                    resolvedTitleColor = UIColor(dynamicColor: tokenSet[.titleColorSelected].dynamicColor)
                } else {
                    setTitleColor(UIColor(dynamicColor: tokenSet[.titleColorSelected].dynamicColor), for: .normal)
                }
            } else {
                resolvedBackgroundColor = UIColor(dynamicColor: tokenSet[.backgroundColorSelectedDisabled].dynamicColor)
                if #available(iOS 15.0, *) {
                    resolvedTitleColor = UIColor(dynamicColor: tokenSet[.titleColorSelectedDisabled].dynamicColor)
                } else {
                    setTitleColor(UIColor(dynamicColor: tokenSet[.titleColorSelectedDisabled].dynamicColor), for: .normal)
                }
            }
        } else {
            unreadDotColor = isEnabled
                        ? UIColor(dynamicColor: tokenSet[.enabledUnreadDotColor].dynamicColor)
                        : UIColor(dynamicColor: tokenSet[.disabledUnreadDotColor].dynamicColor)
            if isEnabled {
                resolvedBackgroundColor = UIColor(dynamicColor: tokenSet[.backgroundColor].dynamicColor)
                if #available(iOS 15.0, *) {
                    resolvedTitleColor = UIColor(dynamicColor: tokenSet[.titleColor].dynamicColor)
                } else {
                    setTitleColor(UIColor(dynamicColor: tokenSet[.titleColor].dynamicColor), for: .normal)
                }
            } else {
                resolvedBackgroundColor = UIColor(dynamicColor: tokenSet[.backgroundColorDisabled].dynamicColor)
                if #available(iOS 15.0, *) {
                    resolvedTitleColor = UIColor(dynamicColor: tokenSet[.titleColorDisabled].dynamicColor)
                } else {
                    setTitleColor(UIColor(dynamicColor: tokenSet[.titleColorDisabled].dynamicColor), for: .disabled)
                }
            }
        }

        if #available(iOS 15.0, *) {
            configuration?.background.backgroundColor = resolvedBackgroundColor
            configuration?.attributedTitle?.foregroundColor = resolvedTitleColor
        } else {
            backgroundColor = resolvedBackgroundColor
        }
    }
}
