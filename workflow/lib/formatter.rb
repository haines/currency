class Formatter
  def initialize(feedback)
    @feedback = feedback
  end

  def format(results)
    results.each do |result|
      feedback.add_item title: result.to_s
    end
    self
  end

  def to_xml
    feedback.to_xml
  end

  private

  attr_reader :feedback
end
