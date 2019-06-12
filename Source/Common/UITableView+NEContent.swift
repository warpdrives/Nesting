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

public extension UITableView {
    /// Set the contentInset and contentOffset of the UITableView.
    ///
    /// - Parameter headerView:         Header view of nested view controller.
    /// - Parameter refreshTemplate:    Refresh style template for nested view controllers.
    func ne_setContent(_ headerView: UIView?,  _ refreshTemplate: NERefreshTemplate) {
        guard let header = headerView else { return }
        if refreshTemplate == .normal || refreshTemplate == .overall {
            self.contentInset = UIEdgeInsets(top: header.frame.size.height,
                                             left: 0,
                                             bottom: 0,
                                             right: 0)
            self.contentOffset = CGPoint(x: 0,
                                         y: -header.frame.size.height)
        }
    }
}
