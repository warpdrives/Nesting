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
    /// Change the scroll offset of a nested view controller.
    ///
    /// - Parameter index:      The index(position) of the childViewController or titleButton in the nested view controller.
    /// - Parameter animate:    Whether to enable scrolling animation.
    open func linkageScrollView(index: Int, animated: Bool = true) {
        ne_scrollView.setContentOffset(CGPoint(x: CGFloat(index) * UIScreen.main.bounds.size.width, y: 0), animated: animated)
    }
    
    /// Change the scroll offset of a nested view controller.
    ///
    /// - Parameter offset:     Scroll view offset.
    /// - Parameter animate:    Whether to enable scrolling animation.
    open func linkageScrollView(offset: CGPoint, animated: Bool = true) {
        ne_scrollView.setContentOffset(offset, animated: animated)
    }
}

extension UIViewController: NELinkage {
    func ne_changeHeaderView(originY: CGFloat) {
        /// The headerView initial offset on the y-axis.
        let headerInitialY: CGFloat = ne_navigationBarHeight
        /// The initial offset of the nested view controller's scrollView on the y-axis.
        let scrollViewInitialY: CGFloat = ne_header.frame.size.height
        /// Height of the categoryView in the ne_header.
        let categoryHeight: CGFloat = ne_header.ne_categoryHeight
        /// TableView vertical scroll offset.
        let verticalOffset: CGFloat = CGFloat(fabsf(Float(scrollViewInitialY + originY)))
        var headerOffsetY: CGFloat = headerInitialY - verticalOffset
        
        /// The boundary value of the offset of the headerView on the y-axis.
        if headerOffsetY <= -(scrollViewInitialY - headerInitialY) + categoryHeight && originY > -scrollViewInitialY {
            headerOffsetY = -(scrollViewInitialY - headerInitialY) + categoryHeight
        } else if headerOffsetY >= headerInitialY || originY <= -scrollViewInitialY {
            headerOffsetY = headerInitialY
        }
        ne_print("current headerOffsetY: \(headerOffsetY), originY: \(originY)")
        /// Update ne_header's frame.
        ne_header.frame = CGRect(x: ne_header.frame.origin.x,
                                 y: headerOffsetY,
                                 width: ne_header.frame.size.width,
                                 height: ne_header.frame.size.height)
    }
}
