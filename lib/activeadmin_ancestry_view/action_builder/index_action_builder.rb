module ActiveadminAncestryView
  class IndexActionBuilder < ActionBuilder
    def call(opt = {}, &block)
      %{index as: :block do |res| 
          #{block.call(opt) if block_given?}
          #{render_partial(opt)}
        end}
    end
  end
end