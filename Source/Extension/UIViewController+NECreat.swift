//
//  Nesting
//
//  Copyright (c) 2019-Present Warpdrives Team - https://github.com/warpdrives
//
//  The software is available under the Apache 2.0 license. See the LICENSE file
//  for more info.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
    

import UIKit

extension UIViewController {
    /// Creat a nested container.
    ///
    /// - Parameter childConrtoller:    The childControllers in the container.
    /// - Parameter headerView:         Head view that does not participate in the linkage between the bottom lists.
    /// - Parameter refreshTemplate:    Refresh style template for nested view controllers. Default normal.
    /// - Parameter callback:           Callback the scroll offset of ne_scrollView.
    public func ne_creatNestedContainer(_ childConrtoller: [UIViewController], _ headerView: UIView?, _ refreshTemplate: NERefreshTemplate = .normal, callback: ((CGPoint) -> ())?) {
        ne_assert(type: .childControllerCount, value: childConrtoller.count)
        
        let screenSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        let navigationBarHeight = ne_navigationBarHeight
        
        /// Get base scrollView.
        adaptation(scrollView: ne_scrollView)
        let scrollView = ne_scrollView
        scrollView.frame = CGRect(x: 0, y: navigationBarHeight, width: screenSize.width, height: screenSize.height)
        scrollView.contentSize = CGSize(width: CGFloat(childConrtoller.count) * screenSize.width, height: screenSize.height - navigationBarHeight)
        self.view.addSubview(scrollView)
        
        /// Add headerView.
        if let header = headerView {
            ne_header = header
            /// - Note: Determine the enabled state of gesture penetrate.
            ne_header.subviews.forEach { ne_determineEnabledState(targetObject: $0) }
            self.view.addSubview(ne_header)
        }
        
        /// Monitor the scroll event of the scrollView.
        ne_monitor.scrollMonitor.monitor(scrollView: scrollView, closure: callback)
        
        /// Add childController.
        for i in 0..<childConrtoller.count {
            let viewController = childConrtoller[i]
            self.addChild(viewController)
            viewController.view.frame = CGRect(x: CGFloat(i) * screenSize.width, y: 0, width: screenSize.width, height: screenSize.height)
            scrollView.addSubview(viewController.view)
            /// Monitor tableview scroll events.
            ne_monitorTableView(viewController: viewController, headerView: headerView, refreshTemplate: refreshTemplate)
        }
    }
}

private extension UIViewController {
    /// Monitor tableview scroll events.
    ///
    /// - Parameter viewController:     Nested view controller's childViewController.
    /// - Parameter headerView:         Head view that does not participate in the linkage between the bottom lists.
    /// - Parameter refreshTemplate:    Refresh style template for nested view controllers.
    private func ne_monitorTableView(viewController: UIViewController, headerView: UIView?, refreshTemplate: NERefreshTemplate) {
        let subviews = viewController.view.subviews
        for view in subviews {
            /// - Todo: Temporarily does not support the existence of multiple tableviews in childViewController.
            if view.isKind(of: UITableView.classForCoder()) {
                let tableView = view as! UITableView
                tableView.ne_setContent(headerView, refreshTemplate)
                ne_monitor.scrollMonitor.monitor(tableView: tableView)
            }
        }
    }
    
    /// Determine the enabled state of gesture penetrate.
    ///
    /// - Parameter targetObject:   Inspected object.
    private func ne_determineEnabledState(targetObject: UIView) {
        if targetObject.ne_enableGesturePenetrate {
            targetObject.convert(derivedClass: NEHeaderView.self)
            if !ne_header.isKind(of: NEHeaderView.classForCoder()) {
                ne_header.ne_enableGesturePenetrate = true
                ne_header.convert(derivedClass: NEHeaderView.self)
            }
        }
    }
    
    /// Adapt UIScrollView.
    ///
    /// - Parameter scrollView: Adapted object.
    private func adaptation(scrollView: UIScrollView) {
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
}
