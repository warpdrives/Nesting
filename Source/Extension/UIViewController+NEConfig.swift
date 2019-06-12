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
    /// Get neConfig
    func ne_getCurrentConfig() -> CreatNestedProtocolModel {
        let address_pointer = ne_getCurrentVCAddressPointer()
        ne_print(address_pointer)
        let ne_value = NEConfig.default.ne_nestedDict[address_pointer]
        guard let theValue = ne_value else {
            NEConfig.default.ne_nestedDict[address_pointer] = ne_value
            return CreatNestedProtocolModel()
        }
        return theValue
    }
    
    /// Remove neConfig
    func ne_removeConfig() {
        let address_pointer = ne_getCurrentVCAddressPointer()
        NEConfig.default.ne_nestedDict.removeValue(forKey: address_pointer)
    }
    
    /// Get currentVC address pointer
    ///
    /// - Returns: address pointer String
    func ne_getCurrentVCAddressPointer () -> String {
        let address_pointer = "\(Unmanaged.passUnretained(self).toOpaque())"
        return address_pointer
    }
}
