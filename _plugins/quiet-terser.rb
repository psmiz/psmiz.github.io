# jekyll-terser prints "Terser: Minifying <file>" for every JS file on each build,
# with no option to turn it off. Mute that message; Terser errors still go to STDERR.
module Jekyll
  module Terser
    module QuietGenerator
      private

      def puts(*); end
    end

    TerserGenerator.prepend(QuietGenerator) if defined?(TerserGenerator)
  end
end
