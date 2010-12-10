# Author: Justin Knowlden
# Adaption of jsmin.rb published by Uladzislau Latynski
#
# -------------------
# jsmin.rb 2007-07-20
# Author: Uladzislau Latynski
# This work is a translation from C to Ruby of jsmin.c published by
# Douglas Crockford.  Permission is hereby granted to use the Ruby
# version under the same conditions as the jsmin.c on which it is
# based.
#
# /* jsmin.c
#    2003-04-21
#
# Copyright (c) 2002 Douglas Crockford  (www.crockford.com)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# The Software shall be used for Good, not Evil.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'stringio'
require 'jsmin'

module Smurf
  class Javascript
    def self.minifies?(paths) !paths.grep(%r[\.js(\?\d+)?$]).empty?; end

    def initialize(content)
      @content = nil
      java_exists = %x[which java].present?
      
      if java_exists
        @content = minify_with_closure_compiler(content)
        Rails.logger.info "Closure Compiler failed" if @content.blank?
      end
      
      if @content.blank?
        Rails.logger.info "Closure Compiler not found" unless java_exists
        @content = JSMin.minify(content)
      end
      
      @content
    end

    def minified; @content end

    def minify_with_closure_compiler(content)
      jar_file = File.join(File.dirname(__FILE__), '..', 'closure-compiler', 'compiler.jar')
      IO.popen("java -jar #{jar_file}", "r+") do |p|
        p.write content
        p.close_write
        content = p.read
      end
      content if $? == 0
    end
    
  end
end
