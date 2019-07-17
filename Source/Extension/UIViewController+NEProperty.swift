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

public extension UIViewController {
    /// Get UINavigationBar's height.
    var ne_navigationBarHeight: CGFloat {
        get {
            guard let frame: CGRect = self.navigationController?.navigationBar.value(forKey: "frame") as? CGRect else {
                return 0.0
            }
            let y = frame.origin.y
            let height = frame.size.height
            return y + height
        }
    }

    /// Monitor the scroll events of the UITableView.
    var ne_monitor: NEMonitor {
        get {
            let monitor: NEMonitor = ne_associatedObject(base: self, key: &NE_AssociatedKeys.ne_monitorKey) { return NEMonitor() }
            monitor.setDelegate(targrt: self)
            monitor.syncProperty(header: ne_header, navigationBarHeight: ne_navigationBarHeight)
            return monitor
        }
        set(newValue) {
            ne_associateObject(base: self, key: &NE_AssociatedKeys.ne_monitorKey, value: newValue)
        }
    }
    
    /// HeaderView of a nested view controller.
    var ne_header: UIView {
        get {
            return ne_associatedObject(base: self, key: &NE_AssociatedKeys.ne_headerKey, initialiser: {
                UIView()
            })
        }
        set(newValue) {
            ne_associateObject(base: self, key: &NE_AssociatedKeys.ne_headerKey, value: newValue)
        }
    }
    
    /// The bottommost UIScrollView container of the nested view controller.
    var ne_scrollView: UIScrollView {
        get {
            return ne_associatedObject(base: self, key: &NE_AssociatedKeys.ne_scrollViewKey, initialiser: {
                let spareScrollView = UIScrollView()
                spareScrollView.backgroundColor = .clear
                spareScrollView.isPagingEnabled = true
                spareScrollView.showsHorizontalScrollIndicator = false
                spareScrollView.showsVerticalScrollIndicator = false
                spareScrollView.scrollsToTop = false
                return spareScrollView
            })
        }
        set(newValue) {
            ne_associateObject(base: self, key: &NE_AssociatedKeys.ne_scrollViewKey, value: newValue)
        }
    }
    
    /// Generate a key of type NSString.
//    private func ne_map(key: String) -> NSString {
//        return NSString(string: "\(key)\(ne_address(instance: self))")
//    }
}
