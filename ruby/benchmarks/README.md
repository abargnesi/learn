Benchmarks for Ruby
---

IPS benchmarking `respond_to?` using Symbol / String

```ruby
[8] pry(main)> require 'benchmark'
=> true
[9] pry(main)> require 'benchmark/ips'
=> true
[10] pry(main)> Benchmark.ips do |x|
[10] pry(main)*   x.config(:time => 20, :warmup => 5)  
[10] pry(main)*   x.report("respond_to? by symbol") {  
[10] pry(main)*     Object.respond_to?(:pry)
[10] pry(main)*   }  
[10] pry(main)*   x.report("respond_to? by string") {
[10] pry(main)*     Object.respond_to?("pry")
[10] pry(main)*   }  
[10] pry(main)* end  
Calculating -------------------------------------
respond_to? by symbol
                       118.271k i/100ms
respond_to? by string
                       100.736k i/100ms
-------------------------------------------------
respond_to? by symbol
                          5.967M (± 1.7%) i/s -    119.335M
respond_to? by string
                          2.976M (± 1.6%) i/s -     59.535M
=> #<Benchmark::IPS::Report:0x000000044a3a18
 @entries=
  [#<Benchmark::IPS::Report::Entry:0x00000003cafcd0
    @ips=5966723.618600759,
    @ips_sd=101943,
    @iterations=119335439,
    @label="respond_to? by symbol",
    @measurement_cycle=118271,
    @microseconds=20006269.216537476,
    @show_total_time=false>,
   #<Benchmark::IPS::Report::Entry:0x00000003e557d8
    @ips=2976477.3727638503,
    @ips_sd=48653,
    @iterations=59534976,
    @label="respond_to? by string",
    @measurement_cycle=100736,
    @microseconds=20007226.46713257,
    @show_total_time=false>]>
[11] pry(main)> 
[tony@starship bel.rb]$ ruby -v
ruby 2.2.2p95 (2015-04-13 revision 50295) [x86_64-linux]
```
