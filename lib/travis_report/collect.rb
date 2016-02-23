# Collect reports
module TravisReport
  require 'parallel'
  require 'travis'

  class << self

    def collect(p, threads, cli_fail, cli_new)
      error = nil

      Parallel.each(p, in_threads: threads) do |r|
        begin
          t = Travis::Repository.find r

          next if cli_fail && t.passed?

          b = t.last_build
          diff = date_difference b.finished_at
          next if cli_new && diff != 0

          # puts output_info(r, t)
          yield r, t
        rescue => e
          puts "Error getting #{r}: #{e}"
          error = 'Sadness'
        end        
      end # Parallel.each

      error
    end

  end # class
end
