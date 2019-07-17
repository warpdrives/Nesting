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

public extension UIView {
    /// If set to TRUE, initiates gesture penetrating, which will allow gesture events to be passed down to the bottommost view. Default FALSE.
    var ne_enableGesturePenetrate: Bool {
        get {
            return ne_associatedValue(base: self, key: &NE_AssociatedKeys.ne_gesturePenetrateKey, initialiser: {
                return false
            })
        }
        set(newValue) {
            ne_associateValue(base: self, key: &NE_AssociatedKeys.ne_gesturePenetrateKey, value: newValue)
        }
    }
    
    /// The height of the categoryView in the headerView of the nested view controller.
    var ne_categoryHeight: CGFloat {
        get {
            return ne_associatedValue(base: self, key: &NE_AssociatedKeys.ne_categoryHeightKey, initialiser: {
                return 0.0
            })
        }
        set(newValue) {
            ne_associateValue(base: self, key: &NE_AssociatedKeys.ne_categoryHeightKey, value: newValue)
        }
    }
    
    /// Convert to derived class of UIView.
    ///
    /// - Parameter derivedClass:   derived class of UIView.
    func convert(derivedClass: AnyClass) {
        object_setClass(self, derivedClass)
    }
}
