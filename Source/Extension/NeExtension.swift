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

extension UIViewController: CreatNested {
    /// Creat a nested container.
    ///
    /// - Parameter childConrtoller:    The childControllers in the container.
    /// - Parameter headerView:         Head view that does not participate in the linkage between the bottom lists.
    func ne_creatNestedContainer(_ childConrtoller: [UIViewController], _ headerView: UIView?) {
        ne_assert(type: .childControllerCount, value: childConrtoller.count)
        
        let screenSize = CGSize(width: UIScreen.main.bounds.size.width,
                                height: UIScreen.main.bounds.size.height)
        let navigationBarHeight = ne_navigationBarHeight
        
        let scrollView = self.ne_scrollView
        scrollView.frame = CGRect(x: 0,
                                  y: navigationBarHeight,
                                  width: screenSize.width,
                                  height: screenSize.height)
        scrollView.contentSize = CGSize(width: CGFloat(childConrtoller.count) * screenSize.width,
                                        height: screenSize.height - navigationBarHeight)
        self.view.addSubview(scrollView)
        
        var currentViewController = ne_getCurrentConfig().ne_currentViewController
        for i in 0..<childConrtoller.count {
            let viewController = childConrtoller[i]
            self.addChild(viewController)
            viewController.view.frame = CGRect(x: CGFloat(i) * screenSize.width,
                                               y: 0,
                                               width: screenSize.width,
                                               height: screenSize.height)
            if i == 0 {
                currentViewController = viewController
                currentViewController.view.frame = viewController.view.frame
                scrollView.addSubview(currentViewController.view)
            } else {
                scrollView.addSubview(viewController.view)
            }
        }
    }
}

public extension UIViewController {
    /// Get neConfig
    func ne_getCurrentConfig() -> CreatNestedProtocolModel {
        let address_pointer = ne_getCurrentVCAddressPointer()
        ne_print(address_pointer)
        let ne_value = NeConfig.default.ne_nestedDict[address_pointer]
        guard let theValue = ne_value else {
            NeConfig.default.ne_nestedDict[address_pointer] = ne_value
            return CreatNestedProtocolModel()
        }
        return theValue
    }
    
    /// Remove neConfig
    func ne_removeConfig() {
        let address_pointer = ne_getCurrentVCAddressPointer()
        NeConfig.default.ne_nestedDict.removeValue(forKey: address_pointer)
    }
    
    /// Get currentVC address pointer
    ///
    /// - Returns: address pointer String
    func ne_getCurrentVCAddressPointer () -> String {
        let address_pointer = "\(Unmanaged.passUnretained(self).toOpaque())"
        return address_pointer
    }
}

public extension UIViewController {
    /// Get UINavigationBar's height
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
}

private extension UIViewController {
    /// Get scrollView
    private var ne_scrollView: UIScrollView {
        get {
            let scrollView = UIScrollView()
            scrollView.delegate = self as? UIScrollViewDelegate
            scrollView.backgroundColor = self.ne_backgroundColor
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            scrollView.scrollsToTop = false
            return scrollView
        }
    }
}
