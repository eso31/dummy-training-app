# frozen_string_literal: true

# Helper actions for the Training Sessions
module TrainingSessionHelper

  # Generates an HTML 5 starts element to rate a training instructor
  def session_rate(rate, options = {})
    capture do
      (1..5).each do |i|
        if options.key?(:clickable) && options[:clickable]
          concat link_to_rate(i, i <= rate)
        else
          concat content_tag(:i, nil, id: "rate_#{i}",
                             class: i <= rate ? 'fa fa-star' : 'fa fa-star-o')
        end
      end
    end
  end

  # Generates a link with a start inside to rate a training instructor
  def link_to_rate(rate, filled)
    link_to(nil,
            data: { toggle: 'modal', target: '#ratingModal', rating: rate }, id: "rate_#{rate}") do
      content_tag(:i, nil, class: filled ? 'fa fa-star' : 'fa fa-star-o')
    end
  end
end
