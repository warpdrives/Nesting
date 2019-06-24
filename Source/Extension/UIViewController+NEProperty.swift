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
    
    /// An NSMapTable responsible for storing property.
    private static var _mapTable = NSMapTable<NSString, AnyObject>(keyOptions: .strongMemory, valueOptions: .weakMemory)
    
    private static var _mapMonitorTable = NSMapTable<UIViewController, AnyObject>(keyOptions: .weakMemory, valueOptions: .strongMemory)
    /// Monitor the scroll events of the UITableView.
    var ne_monitor: NEMonitor {
        get {
            var monitor:NEMonitor?  = UIViewController._mapMonitorTable.object(forKey: self) as? NEMonitor
            if monitor == nil {
                monitor = NEMonitor()
                UIViewController._mapMonitorTable.setObject(monitor!, forKey: self)
            }
            monitor?.registerScrollMonitor()
            monitor?.setDelegate(targrt: self)
            return monitor!
        }
        set(newValue) {
            UIViewController._mapMonitorTable.setObject(newValue, forKey: self)
            //UIViewController._mapTable.setObject(newValue, forKey: ne_map(key: "NEMonitor"))
        }
    }
    
    func ne_printmapMonitorTable() {

        //CFGetRetainCount
        UIViewController._mapMonitorTable.objectEnumerator()?.enumerated().forEach({ (obj) in
            print(CFGetRetainCount(obj.element as CFTypeRef))
        })
        print(UIViewController._mapMonitorTable)
        print(CFGetRetainCount(self))
        //https://juejin.im/post/5c1644ba5188250baa558cdb
    }
    
    /// HeaderView of a nested view controller.
    var ne_header: UIView {
        get {
            let view = UIViewController._mapTable.object(forKey: ne_map(key: "Header")) as? UIView ?? UIView()
            return view
        }
        set(newValue) {
            UIViewController._mapTable.setObject(newValue, forKey: ne_map(key: "Header"))
        }
    }
    
    /// The bottommost UIScrollView container of the nested view controller.
    var ne_scrollView: UIScrollView {
        get {
            guard let scrollView = UIViewController._mapTable.object(forKey: ne_map(key: "ScrollView")) as? UIScrollView else {
                let spareScrollView = UIScrollView()
                spareScrollView.backgroundColor = .clear
                spareScrollView.isPagingEnabled = true
                spareScrollView.showsHorizontalScrollIndicator = false
                spareScrollView.showsVerticalScrollIndicator = false
                spareScrollView.scrollsToTop = false
                UIViewController._mapTable.setObject(spareScrollView, forKey: ne_map(key: "ScrollView"))
                return spareScrollView
            }
            return scrollView
        }
        set(newValue) {
            UIViewController._mapTable.setObject(newValue, forKey: ne_map(key: "ScrollView"))
        }
    }
    
    /// Generate a key of type NSString.
    private func ne_map(key: String) -> NSString {
        return NSString(string: "\(key)\(ne_address(instance: self))")
    }
}
