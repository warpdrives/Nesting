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

public class NEMonitor {
    private weak var delegate: NELinkage?
    private var headerView: UIView?
    private var navigationHeight: CGFloat = 0.0
    
    /// Set NELinkage protocol.
    public func setDelegate<T: Any>(targrt: T) {
        delegate = targrt as? NELinkage
    }
    
    /// Synchronous headerView.
    ///
    /// - Parameter header:                 The header of nested view controller.
    /// - Parameter navigationBarHeight:    The height of the navigation bar of the current view controller.
    public func syncProperty(header: UIView, navigationBarHeight: CGFloat) {
        headerView = header
        navigationHeight = navigationBarHeight
    }
    
    deinit {
        ne_print("NEMonitor is released")
    }
}

extension NEMonitor {
    static var scrollMonitorKey: UInt8 = 0
    
    var scrollMonitor: NEScrollMonitor {
        get {
            let value = ne_associatedObject(base: self, key: &NEMonitor.scrollMonitorKey) {
                return NEScrollMonitor()
            }
            value.delegate = delegate
            value.headerView = headerView
            value.navigationHeight = navigationHeight
            return value
        }
        set(newValue) {
            ne_associateObject(base: self, key: &NEMonitor.scrollMonitorKey, value: newValue)
        }
    }
}

class NEScrollMonitor: NSObject {
    private let KVOKeyPath = "contentOffset"
    private var ne_monitorTableViews = [UITableView]()
    private var ne_monitorScrollView = UIScrollView()
    
    fileprivate weak var delegate: NELinkage?
    fileprivate var callback: ((CGPoint) -> ())?
    fileprivate var headerView: UIView?
    fileprivate var navigationHeight: CGFloat = 0.0
    
    /// Monitor the tableView.
    ///
    /// - Parameter tableView:  Monitored object.
    public func monitor(tableView: UITableView) {
        /// Determine if the KVO observer has been added.
        let ne_addKvo = ne_monitorTableViews.filter( {$0 == tableView} ).first
        if ne_addKvo == nil {
            ne_monitorTableViews.append(tableView)
            tableView.addObserver(self, forKeyPath: KVOKeyPath, options: [.new,.old], context: nil)
        }
    }
    
    /// Monitor the scrollView.
    ///
    /// - Parameter scrollView:     Monitored object.
    /// - Parameter closure:        A closure containing a CGPoint type return parameter.
    public func monitor(scrollView: UIScrollView, closure: ((CGPoint) -> ())?) {
        ne_monitorScrollView = scrollView
        ne_monitorScrollView.addObserver(self, forKeyPath: KVOKeyPath, options: .new, context: nil)
        callback = closure
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let obj = object as? UIScrollView else { return }
        
        if obj.isKind(of: UITableView.classForCoder()) {
            let oldOffset = change?[NSKeyValueChangeKey.newKey] as? CGPoint
            let newOffset = change?[NSKeyValueChangeKey.oldKey] as? CGPoint
            /// Dragging, when push nextViewController, reset offset.

            /// Selected statusBar run kvo , use !(oldOffset?.y == newOffset?.y) filter.
            if keyPath == KVOKeyPath && (obj.isDragging || !(oldOffset?.y == newOffset?.y)) {
                let contentOffset = obj.contentOffset
                delegate?.ne_changeHeaderView(originY: contentOffset.y)
                updateTableViews(syncTarget: obj)
                /// Check contentSize.
                adjustMinScrollAreaIfNeeded()
            }
           
        } else if obj.isKind(of: UIScrollView.classForCoder()) {
            let contentOffset = obj.contentOffset
            if let theCallback = callback {
                theCallback(contentOffset)
                /// - TODO: need set sub scrollView header refresh frame.
            }
        }
    }
    
    deinit {
        removeAllObserver()
        ne_print("\(self.classForCoder) is released")
    }
}

private extension NEScrollMonitor {
    /// Remove all Observer.
    private func removeAllObserver() {
        ne_monitorScrollView.removeObserver(self, forKeyPath: KVOKeyPath)
        ne_monitorTableViews.forEach( {$0.removeObserver(self, forKeyPath: KVOKeyPath)} )
        ne_monitorTableViews.removeAll()
    }
    
    /// Synchronously update the contentOffset of all tableViews.
    ///
    /// - Parameter syncTarget:  Synchronized target object.
    private func updateTableViews(syncTarget: UIScrollView) {
        guard ne_monitorTableViews.count > 0 else { return }
        ne_monitorTableViews.forEach { if $0 != syncTarget { $0.contentOffset = syncTarget.contentOffset } }
    }
    
    /// Adjust the minimum scrolling area of the tableView when needed.
    private func adjustMinScrollAreaIfNeeded() {
        guard ne_monitorTableViews.count > 0 else { return }
        ne_monitorTableViews.forEach {
            guard $0.contentSize.height < $0.frame.size.height else { return }
            if $0.tableFooterView == nil {
                guard let theHeaderView = headerView else { return }
                let allElementsHeight: CGFloat = $0.contentSize.height + navigationHeight + theHeaderView.ne_categoryHeight
                let footerHeight: CGFloat = UIScreen.main.bounds.size.height - allElementsHeight
                let footerView = UIView()
                footerView.frame = CGRect(x: 0, y: 0, width: $0.frame.size.width, height: footerHeight)
                $0.tableFooterView = footerView
            } else {
                /// - TODO: do something...
            }
        }
    }
}
