require 'bob/math'
require 'bob/meta_builder'

module Builder
  class Builder
    def self.builders
      @@builders ||= Array.new
    end

    def self.respond_to? sym, *args
      sym.to_s =~ /([a-z]+\??=?)(!?)$/ || super
    end

    def self.method_missing sym, *args, &block
      sym.to_s =~ /([a-z]+\??=?)(!?)$/

      unless ($~.nil?)
        hash = args.first.to_h rescue {}
        hash[:save] = !$2.blank?
        return builders.flat_map(&:get_all_builders).find{|b| b.sym == $1.to_sym}.execute hash, &block
      end

      super
    end

    def self.meta_build sym, klass= sym.to_s.capitalize.constantize, &builder
      builders << Meta_Builder.new(sym, klass: klass, &builder)
    end

    def self.for_each symbol, options = {}, &behaviour
      options[:klass] = options[:build]
      options.except!(:build)
      builders.find{ |beh| beh.sym == symbol }.add_after_callback symbol, options, &behaviour
    end

    private

      def self.rnd_list builder, distinct: false, min: 0, max: 25
        res = Array.new(Math.triangleRandom(min: min, max: 25).round){builder[]}
        res.to_set.to_a if distinct
        res
      end
  end
end