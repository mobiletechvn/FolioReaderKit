//
//  FolioReaderConfig.swift
//  FolioReaderKit
//
//  Created by Heberti Almeida on 08/04/15.
//  Copyright (c) 2015 Folio Reader. All rights reserved.
//

import UIKit

import RealmSwift

// MARK: - FolioReaderScrollDirection

/// Defines the Reader scrolling direction
///
/// - vertical: Section and content scroll on vertical.
/// - horizontal: Section and content scroll on horizontal.
/// - horizontalWithVerticalContent: Sections scroll horizontal and content scroll on vertical.
/// - defaultVertical: The default scroll direction, if not overridden; works as .vertical.
public enum FolioReaderScrollDirection: Int {
    case vertical
    case horizontal
    case horizontalWithVerticalContent
    case defaultVertical

    /// The current scroll direction
    ///
    /// - Returns: Returns `UICollectionViewScrollDirection`
    func collectionViewScrollDirection() -> UICollectionView.ScrollDirection {
        switch self {
        case .vertical, .defaultVertical:
            return .vertical
        case .horizontal, .horizontalWithVerticalContent:
            return .horizontal
        }
    }
}

// MARK: - ClassBasedOnClickListener

/**
 A `ClassBasedOnClickListener` takes a closure which is performed if a given html `class` is clicked. The closure will reveice the content of the specified parameter.

 Eg. A ClassBasedOnClickListener with the className `quote` and parameterName `id` with the given epub html content `<section class="quote" id="12345">` would call the given closure on a click on this section with the String `12345` as parameter.
 */
public struct ClassBasedOnClickListener {

    /// The name of the URL scheme which should be used. Note: Make sure that the given `String` is a valid as scheme name.
    public var schemeName: String

    /// The query selector for the elements which the listener should be added to. See https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector for further information about query selectors.
    public var querySelector: String

    /// The name of the attribute whose content should be passed to the `onClickAction` action.
    public var attributeName: String

    /// Whether the listener should be added to all found elements or only to the first one. See https://developer.mozilla.org/en-US/docs/Web/API/Element/querySelectorAll for further information. The default value is `true`.
    public var selectAll: Bool

    /// The closure which will be called if the specified class was clicked. `attributeContent` contains the string content of the specified attribute and `touchPointRelativeToWebView` reprsents the touch point relative to the web view.
    public var onClickAction: ((_ attributeContent: String?, _ touchPointRelativeToWebView: CGPoint) -> Void)

    /**
     Initializes a `ClassBasedOnClickListener` instance. Append it to the `classBasedOnClickListeners` property from the `FolioReaderConfig` to receive on click events. The default `selectAll` value is `true`.

     - parameter schemeName:    The name of the URL scheme which should be used. Note: Make sure that the given `String` is a valid as scheme name.
     - parameter querySelector: The query selector for the elements which the listener should be added to. See https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector for further information about query selectors.
     - parameter attributeName: The name of the attribute whose content should be passed to the `onClickAction` action.
     - parameter selectAll:     Whether the listener should be added to all found elements or only to the first one. See https://developer.mozilla.org/en-US/docs/Web/API/Element/querySelectorAll for further information. The default value is `true`.
     - parameter onClickAction: The closure which will be called if the specified class was clicked. `attributeContent` contains the string content of the specified attribute and `touchPointRelativeToWebView` reprsents the touch point relative to the web view.
     */
    public init(schemeName: String, querySelector: String, attributeName: String, selectAll: Bool = true, onClickAction: @escaping ((_ attributeContent: String?, _ touchPointRelativeToWebView: CGPoint) -> Void)) {
        self.schemeName = schemeName.lowercased()
        self.querySelector = querySelector
        self.attributeName = attributeName
        self.selectAll = selectAll
        self.onClickAction = onClickAction
    }
}

// MARK: - FolioReaderConfig

/**
 Defines the Reader custom configuration
 */
open class FolioReaderConfig: NSObject {

    // MARK: ClassBasedOnClickListener

    /**
     Array of `ClassBasedOnClickListener` objects. A `ClassBasedOnClickListener` takes a closure which is performed if a given html `class` is clicked. The closure will reveice the content of the specified parameter.

     Eg. A ClassBasedOnClickListener with the className `quote` and parameterName `id` with the given epub html content `<section class="quote" id="12345">` would call the given closure on a click on this section with the String `12345` as parameter.
     */
    open var classBasedOnClickListeners = [ClassBasedOnClickListener]()

    // MARK: Colors

    /// Base header custom TintColor
    open var tintColor = UIColor(rgba: "#e1bb00")

    /// Menu background color
    open var menuBackgroundColor = UIColor.white

    /// Menu separator Color
    open var menuSeparatorColor = UIColor(rgba: "#D7D7D7")

    /// Menu text color
    open var menuTextColor = UIColor(rgba: "#000")

    /// Menu text color
    open var menuTextColorSelected = UIColor(rgba: "#e1bb00")
    
    // Day mode nav color
    open var daysModeNavBackground = UIColor.white
    
    // Day mode nav color
    open var nightModeNavBackground = UIColor(rgba: "#131313")
    
    /// Night mode background color
    open var nightModeBackground = UIColor(rgba: "#131313")

    /// Night mode menu background color
    open var nightModeMenuBackground = UIColor(rgba: "#1E1E1E")

    /// Night mode separator color
    open var nightModeSeparatorColor = UIColor(white: 0.5, alpha: 0.2)

    /// Media overlay or TTS selection color
    open lazy var mediaOverlayColor: UIColor! = self.tintColor

    // MARK: Custom actions

    /// hide the navigation bar and the bottom status view
    open var hideBars = false

    /// If `canChangeScrollDirection` is `true` it will be overrided by user's option.
    open var scrollDirection: FolioReaderScrollDirection = .defaultVertical

    /// Enable or disable hability to user change scroll direction on menu.
    open var canChangeScrollDirection = true

    /// Enable or disable hability to user change font style on menu.
    open var canChangeFontStyle = true
    
    /// Should hide navigation bar on user tap
    open var shouldHideNavigationOnTap = true

    /// Allow sharing option, if `false` will hide all sharing icons and options
    open var allowSharing = true

    /// Enable TTS (Text To Speech)
    open var enableTTS = true
    
    /// Display book title in navbar
    open var displayTitle = false

    /// Hide the page indicator
    open var hidePageIndicator = false

    /// Go to saved position when open a book
    open var loadSavedPositionForCurrentBook = true
    
    // MARK: Quote image share

    /// Custom Quote logo
    open var quoteCustomLogoImage = UIImage(readerImageNamed: "icon-logo")

    /// Add custom backgrounds and font colors to Quote Images
    open var quoteCustomBackgrounds = [QuoteImage]()

    /// Enable or disable default Quote Image backgrounds
    open var quotePreserveDefaultBackgrounds = true

    // MARK: Realm

    /// Realm configuration for storing highlights
    open var realmConfiguration = Realm.Configuration(schemaVersion: 2)

    // MARK: Localized strings

    /// Localizes Highlight title
    open var localizedHighlightsTitle = "Ghi chú"

    /// Localizes Content title
    open var localizedContentsTitle = "Nội dung"

    /// Use the readers `UIMenuController` which enables the highlighting etc. The default is `true`. If set to false it's possible to modify the shared `UIMenuController` for yourself. Note: This doesn't disable the text selection in the web view.
    open var useReaderMenuController = true

    /// Used to distinguish between multiple or different reader instances. The content of the user defaults (font settings etc.) depends on this identifier. The default is `nil`.
    open var identifier: String?

    /// Localizes Highlight date format. This is a `dateFormat` from `NSDateFormatter`, so be careful 🤔
    open var localizedHighlightsDateFormat = "MMM dd, YYYY | HH:mm"
    open var localizedHighlightMenu = NSLocalizedString("Ghi chú", comment: "")
    open var localizedDefineMenu = NSLocalizedString("Định nghĩa", comment: "")
    open var localizedPlayMenu = NSLocalizedString("Bắt đầu", comment: "")
    open var localizedPauseMenu = NSLocalizedString("Tạm dừng", comment: "")
    open var localizedFontMenuNight = NSLocalizedString("Đêm", comment: "")
    open var localizedPlayerMenuStyle = NSLocalizedString("Style", comment: "")
    open var localizedFontMenuDay = NSLocalizedString("Ngày", comment: "")
    open var localizedLayoutHorizontal = NSLocalizedString("Xem ngang", comment: "")
    open var localizedLayoutVertical = NSLocalizedString("Xem dọc", comment: "")
    open var localizedReaderOnePageLeft = NSLocalizedString("Còn 1 trang", comment: "")
    open var localizedReaderManyPagesLeft = NSLocalizedString("Số trang còn lại", comment: "")
    open var localizedReaderManyMinutes = NSLocalizedString("phút", comment: "")
    open var localizedReaderOneMinute = NSLocalizedString("1 phút", comment: "")
    open var localizedReaderLessThanOneMinute = NSLocalizedString("Ít hơn 1 phút", comment: "")
    open var localizedShareWebLink: URL? = nil
    open var localizedShareChapterSubject = NSLocalizedString("Kiểm tra chương từ", comment: "")
    open var localizedShareHighlightSubject = NSLocalizedString("Ghi chú từ", comment: "")
    open var localizedShareAllExcerptsFrom = NSLocalizedString("Tất cả các trích đoạn từ", comment: "")
    open var localizedShareBy = NSLocalizedString("bởi", comment: "")
    open var localizedCancel = NSLocalizedString("Huỷ", comment: "")
    open var localizedShare = NSLocalizedString("Chia sẻ", comment: "")
    open var localizedChooseExisting = NSLocalizedString("Chọn sách có sẵn", comment: "")
    open var localizedTakePhoto = NSLocalizedString("Chụp ảnh", comment: "")
    open var localizedShareImageQuote = NSLocalizedString("Chia sẻ ảnh ghi chú", comment: "")
    open var localizedShareTextQuote = NSLocalizedString("Chia sẻ ghi chú", comment: "")
    open var localizedSave = NSLocalizedString("Lưu", comment: "")
    open var localizedHighlightNote = NSLocalizedString("Ghi chú", comment: "")

    public convenience init(withIdentifier identifier: String) {
        self.init()

        self.identifier = identifier
    }

    /**
     Simplify attibution of values based on direction, basically is to avoid too much usage of `switch`,
     `if` and `else` statements to check. So basically this is like a shorthand version of the `switch` verification.

     For example:
     ```
     let pageOffsetPoint = readerConfig.isDirection(CGPoint(x: 0, y: pageOffset), CGPoint(x: pageOffset, y: 0), CGPoint(x: 0, y: pageOffset))
     ```

     As usually the `vertical` direction and `horizontalContentVertical` has similar statements you can basically hide the last
     value and it will assume the value from `vertical` as fallback.
     ```
     let pageOffsetPoint = readerConfig.isDirection(CGPoint(x: 0, y: pageOffset), CGPoint(x: pageOffset, y: 0))
     ```

     - parameter vertical:                  Value for `vertical` direction
     - parameter horizontal:                Value for `horizontal` direction
     - parameter horizontalContentVertical: Value for `horizontalWithVerticalContent` direction, if nil will fallback to `vertical` value

     - returns: The right value based on direction.
     */
    func isDirection<T> (_ vertical: T, _ horizontal: T, _ horizontalContentVertical: T) -> T {
        switch self.scrollDirection {
        case .vertical, .defaultVertical:       return vertical
        case .horizontal:                       return horizontal
        case .horizontalWithVerticalContent:    return horizontalContentVertical
        }
    }
}
