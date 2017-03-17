#!/usr/bin/env ruby

Point = Struct.new :x, :y, :involved do
  def - e
    if e.class == Point
      Point.new(x - e.x, y - e.y)
    else
      Point.new(x - e, y - e)
    end
  end
  def hyp
    Math.sqrt x ** 2 + y ** 2
  end

  def dist other_point
    (self - other_point).hyp
  end

  def to_s
    "x: " + x.to_s + ", y: " + y.to_s
  end
end

Pair = Struct.new :l, :r do
  def <=> other_pair
    self.dist <=> other_pair.dist
  end

  def dist
    l.dist r
  end
end

if __FILE__ == $0

  require 'optparse'

  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: #{$0} [options]"

    opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
      options[:verbose] = v
    end
  end.parse!

  argv = ARGV.select{true}

  points = []
  argv.each do | arg |
    arg.split(',').each do | s_point |
      points << Point.new(*(s_point.split(':').map{|e|e.to_i}))
    end
  end

  if options[:verbose]
    puts "Points:"
    p points
  end

  l_groups = points.count - 1
  pairs = points.permutation(2).to_a.select.with_index do | e, i |
    group_numero = i / l_groups
    group_numero == 0 or (i / group_numero - l_groups) != 0
  end.map do | pair |
    Pair.new *pair
  end

  if options[:verbose]
    puts "Pairs:"
    pairs.each do | e |
      p e
    end
  end

  pairs.sort!

  if options[:verbose]
    puts "Sorted pairs:"
    pairs.each do | e |
      p e
    end
  end

  circuit = []
  pairs.each do | pair |
    unless pair.l.involved or pair.r.involved
      circuit << pair.l
      pair.l.involved = true
      circuit << pair.r
      pair.r.involved = true
    end
  end

  if options[:verbose]
    puts "Circuit:"
    p circuit
  end

  circuit.each do | point |
    puts point.to_s
  end
  puts "Connect the tail with the head to close the circuit."

end
