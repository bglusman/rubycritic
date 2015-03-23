require "rubycritic/source_control_systems/base"
require "rubycritic/analysers_runner"
require "rubycritic/reporter"

module Rubycritic
  module Command
    class Ci
      def initialize(paths)
        @paths = paths
        Config.source_control_system = SourceControlSystem::Base.create
      end

      def execute
        report(critique)
      end

      def critique(opts = {})
        if opts[:analysers]
          AnalysersRunner.new(@paths).run_with_specified_analysers(opts[:analysers])
        else
          AnalysersRunner.new(@paths).run
        end
      end

      def report(analysed_modules)
        Reporter.generate_report(analysed_modules)
      end
    end
  end
end
