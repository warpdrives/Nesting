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
//    static var `default` = NEMonitor()
    private static var _shared: NEMonitor?
    
    class func shared() -> NEMonitor {
        guard let instance = _shared else {
            _shared = NEMonitor()
            return _shared!
        }
        return instance
    }
    
    class func destroy() {
        guard _shared != nil else { return }
        _shared = nil
    }
    
    public var scrollMonitor: NEScrollMonitor!
    
    public func registerScrollMonitor() {
        scrollMonitor = NEScrollMonitor()
    }
    
    deinit {
        ne_print("NEMonitor is released")
    }
}

class NEScrollMonitor: NSObject {
    private let KVOKeyPath = "contentOffset"
    
    public func monitor(tableView: UITableView) {
        tableView.addObserver(self, forKeyPath: KVOKeyPath, options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if let obj = object as? UIScrollView {
            if keyPath == KVOKeyPath {
                let contentOffset = obj.contentOffset
                ne_print("contentOffset is: \(contentOffset)")
            }
        }
    }
    
    deinit {
        ne_print("\(self.classForCoder) is released")
    }
}
