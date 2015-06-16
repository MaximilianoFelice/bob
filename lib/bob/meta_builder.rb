require 'math'

class Meta_Builder
  attr_reader :sym, :behaviour

  attr_reader :after_callbacks

  def add_after_callback symbol, options, &behaviour
    (@after_callbacks ||= Array.new) << Meta_Builder.new(symbol, options, &behaviour)
  end

  def initialize sym, options, &builder
    @sym = sym
    @behaviour = generate_behaviour builder, options[:klass]
    @rnd_qty = options[:rnd_qty] || false
    @min_qty = options[:min_qty] || 0
    @max_qty = options[:qty]
  end

  # => WARNING: For easy handling, this is a really coupled solution: It depends on argument names #
  def build_params args, params
    (keys, params_without_keys) = params.partition{ |(p, k)| p == :key }
    params = params_without_keys.map{ |(p, k)| args[k] }.compact
    hash = keys.map(&:reverse).map{ |(k, *)| [k, args[k]] }
    hash = hash.select{ |(k, v)| !k.blank? && !v.blank?}.to_h

    should_have_more = params.any?{ |(p, *)| p == :rest}
    rest = args.select{ |(k, v)| !params.any?{ |(p, v)| k == v } } if should_have_more

    return params + [hash] if !should_have_more
    return params + [rest]

  end

  def generate_behaviour builder, klass

    Proc.new do |args|
      upper = (@max_qty || args[:qty] || 1)
      lower = (@rnd_qty) ? @min_qty : upper
      upper = lower if upper < lower
      qty = Math.triangleRandom min: lower, max: upper
      log = args[:log] ||= false
      save = args[:save] ||= false
      with = args[:with] ||= []

      res = (klass || ActiveRecord::Base).transaction do
        Array.new(qty.to_i) do

          instance = klass.new if klass
          
          params = builder.parameters

          builder.call(*with, *([instance].compact), *build_params(args, params))
          instance.save! if klass && save

          args[:log_with].call("Instantiated #{klass.name}") if (klass && log && !save)
          args[:log_with].call("Created #{klass.name} ##{instance.id}") if (klass && log && save)

          args[:with] << instance
          (@after_callbacks || []).each{|cb| cb.execute args.except(:qty) }
          args[:with].delete(instance)

          instance.save! if klass && save

          instance
        end
      end

      (res.length > 1)? res : res.first
    end
  end
