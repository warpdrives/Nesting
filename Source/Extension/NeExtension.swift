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
    /// Creat a nested viewController.
    ///
    /// - Parameter childControllerCount:    The Count of childControllers in the nestedViewController.
    func ne_creatNestedViewController(_ childControllerCount: Int) {
        ne_assert(type: .childControllerCount, value: childControllerCount)
    
        let scrollSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        let scrollView = self.ne_scrollView
        scrollView.contentSize = CGSize(width: scrollSize.width * CGFloat(childControllerCount), height: scrollSize.height)
        scrollView.frame = self.view.frame
        self.view.addSubview(scrollView)
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

public extension UIViewController{
    /// Get neConfig
    func ne_getCurrentConfig() -> CreatNestedProtocolModel {
        let address_pointer = self.ne_getCurrentVCAddressPointer()
        ne_print(address_pointer)
        let ne_value = NeConfig.default.ne_nestedDict[address_pointer]
        guard let theValue = ne_value else {
            NeConfig.default.ne_nestedDict[address_pointer] = ne_value
            return CreatNestedProtocolModel()
        }
        return theValue
    }
    
    /// remove neConfig
    func ne_removeConfig() {
        let address_pointer = self.ne_getCurrentVCAddressPointer()
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
