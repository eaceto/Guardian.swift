// MockNSURLSession.swift
//
// Copyright (c) 2016 Auth0 (http://auth0.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

class MockNSURLSession: NSURLSession {
    
    var a0_request: NSURLRequest?
    let a0_data: NSData?
    let a0_response: NSURLResponse?
    let a0_error: NSError?
    
    init(data: NSData?, response: NSURLResponse?, error: NSError?) {
        self.a0_data = data
        self.a0_response = response
        self.a0_error = error
        self.a0_request = nil
    }
    
    override func dataTaskWithRequest(request: NSURLRequest, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
        self.a0_request = request
        let task: () -> Void = {
            completionHandler(self.a0_data, self.a0_response, self.a0_error)
        }
        return MockTask(completionHandler: task)
    }
}

class MockTask: NSURLSessionDataTask {
    
    let a0_completionHandler: () -> Void
    
    init(completionHandler: () -> Void) {
        self.a0_completionHandler = completionHandler
    }
    
    override func resume() {
        a0_completionHandler()
    }
}