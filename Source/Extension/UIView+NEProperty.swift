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
    private static var _gesturePenetrateProperty = [String: Bool]()
    
    /// If set to TRUE, initiates gesture penetrating, which will allow gesture events to be passed down to the bottommost view. Default FALSE.
    var ne_enableGesturePenetrate: Bool {
        get {
            let value = UIView._gesturePenetrateProperty[ne_address(instance: self)] ?? false
            return value
        }
        set(newValue) {
            UIView._gesturePenetrateProperty[ne_address(instance: self)] = newValue
        }
    }
}
