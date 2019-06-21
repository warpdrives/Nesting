//
//  UEFALeagueCategoryView.swift
//  Example
//
//  Created by ShevaKuilin on 2019/6/14.
//  Copyright © 2019 Warpdrives Team. All rights reserved.
//

import UIKit

public protocol UEFALeagueCategoryViewDelagete: class {
    /// Click on the category title.
    ///
    /// - Parameter index:  The index of the category title being clicked.
    func selectTitleItem(index: Int)
}

class UEFALeagueCategoryView: UIView {
    weak public var delegate: UEFALeagueCategoryViewDelagete?

    private var titles: [String] = []
    private var containerScrollView: UIScrollView! 
    private var lineView: UIView!
    private var selectedIndex: Int!
    
    init(frame: CGRect, titles: [String]) {
        super.init(frame: frame)
        self.titles = titles
        self.backgroundColor = UIColor(red: 15/255.0, green: 46/255.0, blue: 86/255.0, alpha: 1.0)
        initLayoutElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Linkage category title.
    ///
    /// - Parameter offsetValue:    Scroll offset.
    @objc public func linkageCategoryTitle(offsetValue: CGFloat) {
        moveNavigationSelectedLine(scrollValue: offsetValue)
    }
}

private extension UEFALeagueCategoryView {
    private func initLayoutElements() {
        guard titles.count > 0 else {
            return
        }
        
        let contentWidth = calculateScrollViewContentWidth()
        containerScrollView = UIScrollView()
        containerScrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        containerScrollView.backgroundColor = self.backgroundColor
        containerScrollView.contentSize = CGSize(width: contentWidth, height: self.frame.size.height)
        containerScrollView.isPagingEnabled = false
        containerScrollView.bounces = true
        containerScrollView.scrollsToTop = false
        containerScrollView.showsHorizontalScrollIndicator = false
        containerScrollView.showsVerticalScrollIndicator = false
        self.addSubview(containerScrollView)
        
        let titleContainerHeight = containerScrollView.frame.size.height - 2
        var titleLocation: CGFloat = 0
        for title in titles {
            guard let currentIndex = titles.firstIndex(of: title) else {
                return
            }
            let isSelected = currentIndex == 0 ? true:false
            let titleWidth = calculateWidth(title: title, isSelected: isSelected)
            if currentIndex > 0 {
                titleLocation += 30 + calculateWidth(title: titles[currentIndex - 1], isSelected: isSelected)
            }
            let titleContainerWidth = titleWidth + 10
            let titleBtn = UIButton()
            titleBtn.frame = CGRect(x: titleLocation, y: 0, width: titleContainerWidth, height: titleContainerHeight)
            titleBtn.setTitle(title, for: .normal)
            titleBtn.setTitle(title, for: .selected)
            titleBtn.setTitleColor(.white, for: .normal)
            titleBtn.setTitleColor(UIColor(red: 254/255.0, green: 187/255.0, blue: 49/255.0, alpha: 1.0), for: .selected)
            titleBtn.setTitleColor(UIColor(red: 254/255.0, green: 187/255.0, blue: 49/255.0, alpha: 1.0), for: [.selected, .highlighted])
            titleBtn.tag = currentIndex
            titleBtn.isSelected = isSelected
            titleBtn.titleLabel?.font = titleBtn.isSelected ? UIFont.systemFont(ofSize: 18):UIFont.systemFont(ofSize: 16)
            titleBtn.addTarget(self, action: #selector(tapTitleAction(sender:)), for: .touchUpInside)
            containerScrollView.addSubview(titleBtn)
            
            if currentIndex == 0 {
                layoutSelectedLine(target: titleBtn, titleWidth: calculateWidth(title: title, isSelected: isSelected), titleContainerWidth: titleContainerWidth)
            }
        }
    }
    
    /// Layout underline
    private func layoutSelectedLine(target: UIButton, titleWidth: CGFloat, titleContainerWidth: CGFloat) {
        let lineAttributes = gainSelectedLineAttributes(titleWidth: titleWidth, titleContainerWidth: titleContainerWidth)
        lineView = UIView()
        lineView.backgroundColor = UIColor(red: 254/255.0, green: 187/255.0, blue: 49/255.0, alpha: 1.0)
        lineView.layer.masksToBounds = true
        lineView.layer.cornerRadius = 1
        lineView.frame = CGRect(x: target.frame.origin.x + lineAttributes.0, y: containerScrollView.frame.size.height - 2, width: lineAttributes.1, height: 2)
        containerScrollView.addSubview(lineView)
    }
    
    /// Calculate the content width of the scrollView.
    private func calculateScrollViewContentWidth() -> CGFloat {
        var contentWidth: CGFloat = 0.0
        for title in titles {
            guard let currentIndex = titles.firstIndex(of: title) else {
                return contentWidth
            }
            let isSelected = currentIndex == 0 ? true:false
            let titleWidth = calculateWidth(title: title, isSelected: isSelected)
            contentWidth += titleWidth
        }
        contentWidth += 30 * CGFloat(titles.count - 1) + 30
        return contentWidth
    }
    
    /// Calculate the title width.
    ///
    /// - Parameter title:      The title.
    /// - Parameter isSelected: Whether it is selected.
    private func calculateWidth(title: String, isSelected: Bool) -> CGFloat {
        let titleFont = isSelected ? UIFont.systemFont(ofSize: 18):UIFont.systemFont(ofSize: 16)
        return title.width(fontSize: titleFont.pointSize)
    }
    
    /// Calculate the scrollpoint center point.
    private func calculateScrollViewCenter() {
        let containerWidth = self.frame.size.width
        let scrollContentWidth = containerScrollView.contentSize.width
        guard containerWidth < scrollContentWidth else {
            return
        }
        var scrollChangeValue: CGFloat = 0.0
        let visibleCenter = self.center.x
        let moveMaxRange = scrollContentWidth - containerWidth
        let titleButtons = gainTitleButtons()
        for button in titleButtons {
            if button.tag == selectedIndex {
                let buttonFrame = button.convert(button.bounds, to: nil)
                let targetCenter = visibleCenter - (buttonFrame.size.width / 2)
                let distance = buttonFrame.origin.x - targetCenter
                if (button.frame.origin.x > targetCenter) {
                    scrollChangeValue = containerScrollView.contentOffset.x + distance
                    if (scrollChangeValue >= moveMaxRange) {
                        scrollChangeValue = moveMaxRange
                    }
                } else {
                    scrollChangeValue = 0
                }
                let resultValue = CGFloat(fabsf(Float(scrollChangeValue)))
                containerScrollView.setContentOffset(CGPoint(x: resultValue, y: 0), animated: true)
                break
            }
        }
    }
    
    /// Get the underline position and width.
    ///
    /// - Parameter titleWidth:             Title width.
    /// - Parameter titleContainerWidth:    Title container width.
    private func gainSelectedLineAttributes(titleWidth: CGFloat, titleContainerWidth: CGFloat) -> (CGFloat, CGFloat){
        let lineWidth: CGFloat = titleWidth
        let lineLocation: CGFloat = (titleContainerWidth - titleWidth) / 2
        
        return (lineLocation, lineWidth)
    }
    
    /// Get the created title button.
    private func gainTitleButtons() -> [UIButton] {
        var buttons = [UIButton]()
        let subViews = containerScrollView.subviews
        for view in subViews {
            if view.isKind(of: UIButton.classForCoder()) {
                let button = view as! UIButton
                buttons.append(button)
            }
        }
        return buttons
    }
}

private extension UEFALeagueCategoryView {
    /// Move selectedLine based on scroll offset
    ///
    /// - Parameter scrollValue:    The offset value.
    private func moveNavigationSelectedLine(scrollValue: CGFloat) {
        let titleButtons = gainTitleButtons()
        
        if scrollValue < 0 || scrollValue > CGFloat(titleButtons.count - 1) * UIScreen.main.bounds.size.width {
            return
        }
        
        let index: Int = Int(scrollValue/UIScreen.main.bounds.size.width)
        let page: CGFloat = scrollValue/UIScreen.main.bounds.size.width
        let rate: CGFloat = page - CGFloat(index)
        selectedIndex = Int(round(Float(scrollValue/UIScreen.main.bounds.size.width)))
        updateTitleButtonStatus()
        calculateScrollViewCenter()
        
        if index >= titleButtons.count {
            return
        }
        
        let currentBtn = titleButtons[index]
        let currentTitleWidth = calculateWidth(title: (currentBtn.titleLabel?.text)!, isSelected: currentBtn.isSelected)
        let currentLineAttributes = gainSelectedLineAttributes(titleWidth: currentTitleWidth, titleContainerWidth: currentBtn.frame.size.width)
        let currentLineWidth = currentLineAttributes.1
        
        var nextIndex = index + 1
        if nextIndex > titleButtons.count - 1 {
            nextIndex = titleButtons.count - 1
        } else if nextIndex < 0 {
            nextIndex = 0
        }
        let nextBtn = titleButtons[nextIndex]
        let nextTitleWidth = calculateWidth(title: (nextBtn.titleLabel?.text)!, isSelected: nextBtn.isSelected)
        let nextLineAttributes = gainSelectedLineAttributes(titleWidth: nextTitleWidth, titleContainerWidth: nextBtn.frame.size.width)
        let nextLineWidth = nextLineAttributes.1
        
        let moveDistance: CGFloat = (currentLineWidth + 30) * rate
        let leftRange = currentBtn.frame.origin.x + currentLineAttributes.0 + moveDistance
        let changeLineWidth = currentLineWidth + (nextLineWidth - currentLineWidth) * rate
        self.lineView.frame = CGRect(x: leftRange, y: self.lineView.frame.origin.y, width: changeLineWidth, height: self.lineView.frame.size.height)
    }
    
    /// Click event.
    ///
    /// - Parameter target: The title button.
    @objc private func tapTitleAction(sender: UIButton) {
        let titleBtn = sender
        selectedIndex = titleBtn.tag
        selectedLineMoveAnimation(target: titleBtn)
        calculateScrollViewCenter()
        delegate?.selectTitleItem(index: titleBtn.tag)
    }
    
    /// Underline move animation.
    ///
    /// - Parameter target: The title button.
    private func selectedLineMoveAnimation(target: UIButton) {
        guard let title = target.titleLabel?.text else {
            return
        }
        let targetLocation = target.frame.origin.x
        let titleWidth = calculateWidth(title: title, isSelected: true)
        let lineAttributes = gainSelectedLineAttributes(titleWidth: titleWidth, titleContainerWidth: target.frame.size.width)
        UIView.animate(withDuration: 0.3) {
            self.updateTitleButtonStatus()
            self.lineView.frame = CGRect(x: targetLocation + lineAttributes.0, y: self.lineView.frame.origin.y, width: lineAttributes.1, height: self.lineView.frame.size.height)
        }
    }
    
    /// Update title button status.
    private func updateTitleButtonStatus() {
        let buttons = gainTitleButtons()
        for button in buttons {
            if selectedIndex == button.tag {
                button.isSelected = true
                button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            } else {
                button.isSelected = false
                button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            }
        }
    }
}

private extension String {
    func width(fontSize: CGFloat) -> CGFloat {
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
        let convertStr = self as NSString
        let size = convertStr.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 30), options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin, .usesFontLeading], attributes: attribute, context: nil).size
        return size.width
    }
}
