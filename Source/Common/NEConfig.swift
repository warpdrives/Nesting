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

public class NEConfig {
    private static var _configProperty = [String: AnyObject]()
    
    var ne_backgroundColor: UIColor {
        get {
            let color = NEConfig._configProperty["BackgroundColor"] as? UIColor ?? UIColor.clear
            return color
        }
        set(newValue) {
            NEConfig._configProperty["BackgroundColor"] = newValue
        }
    }
    
    var ne_header: UIView {
        get {
            let view = NEConfig._configProperty["Header"] as? UIView ?? UIView()
            return view
        }
        set(newValue) {
            NEConfig._configProperty["Header"] = newValue
        }
    }
}
