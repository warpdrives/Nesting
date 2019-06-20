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
