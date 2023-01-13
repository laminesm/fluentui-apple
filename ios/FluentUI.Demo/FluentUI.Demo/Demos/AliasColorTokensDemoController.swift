//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import FluentUI
import UIKit

class AliasColorTokensDemoController: DemoTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return AliasColorTokensDemoSection.allCases.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return AliasColorTokensDemoSection.allCases[section].title
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AliasColorTokensDemoSection.allCases[section].rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath)
        let section = AliasColorTokensDemoSection.allCases[indexPath.section]
        let row = section.rows[indexPath.row]

        cell.backgroundConfiguration?.backgroundColor = UIColor(dynamicColor: aliasTokens.colors[row])
        cell.selectionStyle = .none

        var contentConfiguration = cell.defaultContentConfiguration()
        let text = "\(row.text)"
        contentConfiguration.attributedText = NSAttributedString(string: text,
                                                                 attributes: [
                                                                    .foregroundColor: textColor(for: row)
                                                                 ])
        contentConfiguration.textProperties.alignment = .center
        cell.contentConfiguration = contentConfiguration

        return cell
    }

    private func textColor(for token: AliasTokens.ColorsTokens) -> UIColor {
        switch token {
        case .background1,
             .background1Pressed,
             .background1Selected,
             .background2,
             .background2Pressed,
             .background2Selected,
             .background3,
             .background3Pressed,
             .background3Selected,
             .background4,
             .background4Pressed,
             .background4Selected,
             .background5,
             .background5Pressed,
             .background5Selected,
             .background6,
             .background6Pressed,
             .background6Selected,
             .backgroundDisabled,
             .brandBackgroundDisabled,
             .canvasBackground,
             .stencil1,
             .stencil2,
             .foregroundDisabled2,
             .foregroundOnColor,
             .brandForegroundDisabled2,
             .stroke1,
             .stroke2,
             .strokeDisabled,
             .strokeFocus1,
             .brandBackgroundTint,
             .foregroundDisabled1:
            return UIColor(dynamicColor: aliasTokens.colors[.foreground1])
        case .brandBackground3Pressed,
             .foreground1,
             .foreground2,
             .foreground3,
             .foregroundInverted2,
             .strokeFocus2,
             .brandBackground1Pressed,
             .brandForeground1Pressed,
             .brandStroke1Pressed,
             .brandStroke1,
             .brandForegroundTint,
             .brandStroke1Selected:
            return UIColor(dynamicColor: aliasTokens.colors[.foregroundOnColor])
        case .foregroundInverted1,
             .foregroundLightStatic,
             .backgroundLightStatic,
             .backgroundLightStaticDisabled:
            return UIColor(dynamicColor: aliasTokens.colors[.foregroundDarkStatic])
        case .brandForeground1,
             .brandForeground1Selected,
             .brandForegroundDisabled1,
             .backgroundInverted,
             .brandBackground1,
             .brandBackground1Selected,
             .brandBackground2,
             .brandBackground2Pressed,
             .brandBackground2Selected,
             .brandBackground3,
             .strokeAccessible,
             .backgroundDarkStatic,
             .foregroundDarkStatic:
            return UIColor(dynamicColor: aliasTokens.colors[.foregroundInverted1])
        }
    }

    private var aliasTokens: AliasTokens {
        return self.view.fluentTheme.aliasTokens
    }

}

private enum AliasColorTokensDemoSection: CaseIterable {
    case neutralBackgrounds
    case brandBackgrounds
    case neutralForegrounds
    case brandForegrounds
    case neutralStrokes
    case brandStrokes

    var title: String {
        switch self {
        case .neutralBackgrounds:
            return "Neutral Backgrounds"
        case .brandBackgrounds:
            return "Brand Backgrounds"
        case .neutralForegrounds:
            return "Neutral Foregrounds"
        case .brandForegrounds:
            return "Brand Foregrounds"
        case .neutralStrokes:
            return "Neutral Strokes"
        case .brandStrokes:
            return "Brand Strokes"
        }
    }

    var rows: [AliasTokens.ColorsTokens] {
        switch self {
        case .neutralBackgrounds:
            return [.background1,
                    .background1Pressed,
                    .background1Selected,
                    .background2,
                    .background2Pressed,
                    .background2Selected,
                    .background3,
                    .background3Pressed,
                    .background3Selected,
                    .background4,
                    .background4Pressed,
                    .background4Selected,
                    .background5,
                    .background5Pressed,
                    .background5Selected,
                    .background6,
                    .background6Pressed,
                    .background6Selected,
                    .backgroundInverted,
                    .backgroundDisabled,
                    .canvasBackground,
                    .stencil1,
                    .stencil2,
                    .backgroundDarkStatic,
                    .backgroundLightStatic,
                    .backgroundLightStaticDisabled]
        case .brandBackgrounds:
            return [.brandBackgroundTint,
                    .brandBackground1,
                    .brandBackground1Pressed,
                    .brandBackground1Selected,
                    .brandBackground2,
                    .brandBackground2Pressed,
                    .brandBackground2Selected,
                    .brandBackground3,
                    .brandBackground3Pressed,
                    .brandBackgroundDisabled]
        case .neutralForegrounds:
            return [.foreground1,
                    .foreground2,
                    .foreground3,
                    .foregroundDisabled1,
                    .foregroundDisabled2,
                    .foregroundOnColor,
                    .foregroundInverted1,
                    .foregroundInverted2,
                    .foregroundLightStatic,
                    .foregroundDarkStatic]
        case .brandForegrounds:
            return [.brandForegroundTint,
                    .brandForeground1,
                    .brandForeground1Pressed,
                    .brandForeground1Selected,
                    .brandForegroundDisabled1,
                    .brandForegroundDisabled2]
        case .neutralStrokes:
            return [.stroke1,
                    .stroke2,
                    .strokeDisabled,
                    .strokeAccessible,
                    .strokeFocus1,
                    .strokeFocus2]
        case .brandStrokes:
            return [.brandStroke1,
                    .brandStroke1Pressed,
                    .brandStroke1Selected]
        }
    }
}

private extension AliasTokens.ColorsTokens {
    var text: String {
        switch self {
        case .foreground1:
            return "Foreground 1"
        case .foreground2:
            return "Foreground 2"
        case .foreground3:
            return "Foreground 3"
        case .foregroundDisabled1:
            return "Foreground Disabled 1"
        case .foregroundDisabled2:
            return "Foreground Disabled 2"
        case .foregroundOnColor:
            return "Foreground On Color"
        case .foregroundInverted1:
            return "Foreground Inverted 1"
        case .foregroundInverted2:
            return "Foreground Inverted 2"
        case .brandForeground1:
            return "Brand Foreground 1"
        case .brandForeground1Pressed:
            return "Brand Foreground 1 Pressed"
        case .brandForeground1Selected:
            return "Brand Foreground 1 Selected"
        case .brandForegroundDisabled1:
            return "Brand Foreground Disabled 1"
        case .brandForegroundDisabled2:
            return "Brand Foreground Disabled 2"
        case .background1:
            return "Background 1"
        case .background1Pressed:
            return "Background 1 Pressed"
        case .background1Selected:
            return "Background 1 Selected"
        case .background2:
            return "Background 2"
        case .background2Pressed:
            return "Background 2 Pressed"
        case .background2Selected:
            return "Background 2 Selected"
        case .background3:
            return "Background 3"
        case .background3Pressed:
            return "Background 3 Pressed"
        case .background3Selected:
            return "Background 3 Selected"
        case .background4:
            return "Background 4"
        case .background4Pressed:
            return "Background 4 Pressed"
        case .background4Selected:
            return "Background 4 Selected"
        case .background5:
            return "Background 5"
        case .background5Pressed:
            return "Background 5 Pressed"
        case .background5Selected:
            return "Background 5 Selected"
        case .background6:
            return "Background 6"
        case .background6Pressed:
            return "Background 6 Pressed"
        case .background6Selected:
            return "Background 6 Selected"
        case .backgroundInverted:
            return "Background Inverted"
        case .backgroundDisabled:
            return "Background Disabled"
        case .brandBackground1:
            return "Brand Background 1"
        case .brandBackground1Pressed:
            return "Brand Background 1 Pressed"
        case .brandBackground1Selected:
            return "Brand Background 1 Selected"
        case .brandBackground2:
            return "Brand Background 2"
        case .brandBackground2Pressed:
            return "Brand Background 2 Pressed"
        case .brandBackground2Selected:
            return "Brand Background 2 Selected"
        case .brandBackground3:
            return "Brand Background 3"
        case .brandBackground3Pressed:
            return "Brand Background 3 Pressed"
        case .brandBackgroundDisabled:
            return "Brand Background Disabled"
        case .brandBackgroundTint:
            return "Brand Background Tint"
        case .brandForegroundTint:
            return "Brand Foreground Tint"
        case .stencil1:
            return "Stencil 1"
        case .stencil2:
            return "Stencil 2"
        case .canvasBackground:
            return "Canvas Background"
        case .stroke1:
            return "Stroke 1"
        case .stroke2:
            return "Stroke 2"
        case .strokeDisabled:
            return "Stroke Disabled"
        case .strokeAccessible:
            return "Stroke Accessible"
        case .strokeFocus1:
            return "Stroke Focus 1"
        case .strokeFocus2:
            return "Stroke Focus 2"
        case .brandStroke1:
            return "Brand Stroke 1"
        case .brandStroke1Pressed:
            return "Brand Stroke 1 Pressed"
        case .brandStroke1Selected:
            return "Brand Stroke 1 Selected"
        case .foregroundDarkStatic:
            return "Foreground Dark Static"
        case .foregroundLightStatic:
            return "Foreground Light Static"
        case .backgroundDarkStatic:
            return "Background Dark Static"
        case .backgroundLightStatic:
            return "BackgroundLightStatic"
        case .backgroundLightStaticDisabled:
            return "BackgroundLightStaticDisabled"
        }
    }
}
