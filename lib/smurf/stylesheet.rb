module Smurf
  class Stylesheet
    def self.minifies?(paths) !paths.grep(%r[\.css(\?\d+)?$]).empty?; end

    def initialize(content)
      @content = content.nil? ? nil : minify(content)
    end
    
    def minified; @content; end

    # TODO: deal with string values better (urls, content blocks, etc.)
    def minify(content)
      Rainpress.compress(content)
    end

  end # Stylesheet
end # Smurf
