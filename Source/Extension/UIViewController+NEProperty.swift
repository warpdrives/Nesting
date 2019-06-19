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
    
    /// An NSMapTable responsible for storing NEMonitor.
    private static var _monitorProperty = NSMapTable<NSString, NEMonitor>(keyOptions: .strongMemory, valueOptions: .weakMemory)

    /// Monitor the scroll events of the list.
    var ne_monitor: NEMonitor {
        get {
            let monitor: NEMonitor = UIViewController._monitorProperty.object(forKey: ne_address(instance: self) as NSString) ?? NEMonitor()
            monitor.registerScrollMonitor()
            monitor.setDelegate(targrt: self)
            return monitor
        }
        set(newValue) {
            UIViewController._monitorProperty.setObject(newValue, forKey: ne_address(instance: self) as NSString)
        }
    }
}
