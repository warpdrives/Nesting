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

class NEMonitor {
    private init() {}
    private static var _shared: NEMonitor?
    public weak var delegate: NELinkage?
    
    class func shared() -> NEMonitor {
        guard let instance = _shared else {
            _shared = NEMonitor()
            return _shared!
        }
        return instance
    }
    
    class func destroy() {
        guard _shared != nil else { return }
        NEMonitor._scrollMonitorProperty.removeValue(forKey: ne_address(instance: self))
        _shared = nil
    }
    
    /// Registration of rolling event monitoring.
    public func registerScrollMonitor() {
        scrollMonitor = NEMonitor._scrollMonitorProperty[ne_address(instance: self)] ?? NEScrollMonitor()
    }
    
    /// Set NELinkage protocol.
    public func setDelegate<T: Any>(targrt: T) {
        delegate = targrt as? NELinkage
    }
    
    deinit {
        ne_print("NEMonitor is released")
    }
}

extension NEMonitor {
    /// ScrollMonitor hash table, the value of key is the memory address.
    private static var _scrollMonitorProperty = [String: NEScrollMonitor]()
    var scrollMonitor: NEScrollMonitor {
        get {
            let value = NEMonitor._scrollMonitorProperty[ne_address(instance: self)] ?? NEScrollMonitor()
            value.delegate = delegate
            return value
        }
        set(newValue) {
            NEMonitor._scrollMonitorProperty[ne_address(instance: self)] = newValue
        }
    }
}

class NEScrollMonitor: NSObject {
    private let KVOKeyPath = "contentOffset"
    private var ne_monitorTableViews = [UITableView]()
    public weak var delegate: NELinkage?
    
    /// Monitor the tableView.
    ///
    /// - Parameter tableView:  Monitored object.
    public func monitor(tableView: UITableView) {
        /// Determine if the KVO observer has been added.
        let ne_addKvo = ne_monitorTableViews.filter( {$0 == tableView} ).first
        if ne_addKvo == nil {
            ne_monitorTableViews.append(tableView)
            tableView.addObserver(self, forKeyPath: KVOKeyPath, options: .new, context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if let obj = object as? UIScrollView {
            if keyPath == KVOKeyPath {
                let contentOffset = obj.contentOffset
                ne_print("contentOffset is: \(contentOffset)")
                delegate?.ne_changeHeaderView(originY: contentOffset.y)
            }
        }
    }
    
    deinit {
        ne_monitorTableViews.forEach( {$0.removeObserver(self, forKeyPath: KVOKeyPath)} )
        ne_monitorTableViews.removeAll()
        ne_print("\(self.classForCoder) is released")
    }
}
