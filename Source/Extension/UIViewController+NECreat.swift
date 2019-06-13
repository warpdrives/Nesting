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

extension UIViewController: NECreatNested {
    /// Creat a nested container.
    ///
    /// - Parameter childConrtoller:    The childControllers in the container.
    /// - Parameter headerView:         Head view that does not participate in the linkage between the bottom lists.
    /// - Parameter refreshTemplate:    Refresh style template for nested view controllers. Default normal.
    func ne_creatNestedContainer(_ childConrtoller: [UIViewController], _ headerView: UIView?, _ refreshTemplate: NERefreshTemplate = .normal) {
        ne_assert(type: .childControllerCount, value: childConrtoller.count)
        
        /// Register scroll event monitor
        NEMonitor.shared().registerScrollMonitor()
        
        let screenSize = CGSize(width: UIScreen.main.bounds.size.width,
                                height: UIScreen.main.bounds.size.height)
        let navigationBarHeight = ne_navigationBarHeight
        
        let scrollView = ne_scrollView
        scrollView.frame = CGRect(x: 0,
                                  y: navigationBarHeight,
                                  width: screenSize.width,
                                  height: screenSize.height)
        scrollView.contentSize = CGSize(width: CGFloat(childConrtoller.count) * screenSize.width,
                                        height: screenSize.height - navigationBarHeight)
        self.view.addSubview(scrollView)
        
        /// Add headerView
        if let header = headerView {
            self.view.addSubview(header)
        }
        /// Add childController
        for i in 0..<childConrtoller.count {
            let viewController = childConrtoller[i]
            self.addChild(viewController)
            viewController.view.frame = CGRect(x: CGFloat(i) * screenSize.width,
                                               y: 0,
                                               width: screenSize.width,
                                               height: screenSize.height)
            scrollView.addSubview(viewController.view)
            /// Monitor tableview scroll events
            ne_monitorTableView(viewController: viewController, headerView: headerView, refreshTemplate: refreshTemplate)
        }
    }
    
    /// Monitor tableview scroll events
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
                NEMonitor.shared().scrollMonitor.monitor(tableView: tableView)
            }
        }
    }
}

private extension UIViewController {
    /// Get scrollView
    private var ne_scrollView: UIScrollView {
        get {
            let scrollView = UIScrollView()
            scrollView.delegate = self as? UIScrollViewDelegate
            scrollView.backgroundColor = ne_backgroundColor
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            scrollView.scrollsToTop = false
            return scrollView
        }
    }
}