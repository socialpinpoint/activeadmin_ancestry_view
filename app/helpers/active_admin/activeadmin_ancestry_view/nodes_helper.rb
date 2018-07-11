module ActiveAdmin
  module ActiveadminAncestryView
    module NodesHelper
      CLASSES = {
        child:  'panel-childless',
        parent: 'panel-parent',
        root:   'panel-root'
      }

      PRETTY_COLORS = {
        red:    [255, 102, 102], yellow: [255, 178, 102],
        green:  [102, 255, 102], blue:   [102, 178, 255], 
        violet: [178, 102, 255], gray:   [192, 192, 192]
      }

      def generate_panel_classes(resource)
        attributes = []
        attributes << resource.ancestor_ids if resource.ancestry
        attributes << child_class(resource)
        attributes << CLASSES[:root] if resource.root?
        attributes.flatten.join(' ')
      end

      # for 'data-last-child' attribute
      def last_child(resource)
        "#{resource.parent.id}" if last_child?(resource)
      end

      def panel_shift(resource, multiplicator = 4)
        unless resource.depth.zero?
          "margin-left: #{multiplicator * resource.depth}em;"
        end
      end

      def random_bckgr_color(resource, no_color = false)
        return if no_color
        return if childless_child?(resource)
        color = random_color.join(', ')
        "background-color: rgba(#{color}, 0.7) !important"
      end

      private

      def last_child?(resource)
        parent_last_child_id = resource&.parent&.children&.last&.id
        parent_last_child_id == resource.id
      end

      def childless_child?(resource)
        resource.is_childless? && resource.is_root? == false
      end

      def child_class(resource)
        childless_child?(resource) ? CLASSES[:child] : CLASSES[:parent]
      end

      def random_color(range = -50...50)
        sample_color.map do |light|
          light + Random.rand(range)
        end
      end

      def sample_color
        PRETTY_COLORS.values.sample
      end
    end
  end
end