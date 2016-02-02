# Command line interface
module TravisReport
  require 'travis_report/version'

  require 'parallel'
  require 'travis'

  class << self
    NUMBER_OF_THREADS = 10

    OPT_FAIL = 'fail'
    OPT_NEW = 'new'
    OUT_FAIL = '🔴'
    OUT_PASS = '✅'

    def make_option(name)
      "--#{name}"
    end

    def date_ago(date)
      days = date_difference date
      return '1 day ago' if days == 1
      days == 0 ? 'today' : "#{days} days ago"
     end

    def date_difference(date)
      time = Time.new
      return 0 if date.nil?

      difference = -((date - time) / 60 / 60 / 24)
      difference.round(0)
    end

    def pretty_duration(seconds)
      return "#{seconds} seconds" if seconds < 60

      minutes = seconds / 60
      return '1 minute' if minutes == 1
      "#{minutes} minutes"
    end

    def output_info(name, t)
      build = t.last_build
      o = ''
      if t.passed?
        o << OUT_PASS
      else
        o << OUT_FAIL
      end

      o << "  #{name}\n   "

      if t.passed?
        o << 'Passing'
      else
        o << 'Failing'
      end

      o << "\n   #{date_ago build.finished_at} #{build.finished_at} \n"
      o << "   Duration: #{pretty_duration build.duration} \n   "
      o << build.commit.author_name
      o << ': '
      o << build.commit.subject
      j = build.jobs[0]
      jid = j.build_id
      o << "\n   https://travis-ci.org/#{name}/builds/#{jid}"
      o
    end

    def cli
      o_fail = make_option OPT_FAIL
      o_new = make_option OPT_NEW
      if ARGV.count == 0
        puts "Usage: #{PROJECT} <file> [#{o_fail}] [#{o_new}]"
        exit
      end

      cli_fail = ARGV.include? o_fail
      cli_new = ARGV.include? o_new

      filename = ARGV[0]

      begin
        c = File.read filename
      rescue => e
        puts "Error opening #{filename}: #{e}"
        exit 1
      end

      list = c.split "\n"
      p = list.select { |l| l.include? '/' }
        .map { |l| l.sub 'https://github.com/', ''}

      if p.count == 0
        puts 'No projects found'
        exit
      end

      puts "Collecting reports for #{p.count} projects"
      puts 'Only reporting failing' if cli_fail
      puts 'Only reporting new builds' if cli_new
      error = nil
      Parallel.each(p, in_threads: NUMBER_OF_THREADS) do |r|
        begin
          t = Travis::Repository.find r
          b = t.last_build
          diff = date_difference b.finished_at

          next if cli_fail && t.passed?
          next if cli_new && diff != 0

          puts output_info(r, t)
        rescue => e
          puts "Error getting #{r}: #{e}"
          error = 'Sadness'
        end
      end # Parallel.each

      exit 1 unless error.nil?
    end # cli
  end # class
end
