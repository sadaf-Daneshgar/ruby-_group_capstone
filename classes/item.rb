class Item
  attr_accessor :label, :publish_date, :archived
  attr_reader :id

  def initialize(params = {})
    # the constractor method is called a hash because it takes more than 5 arguments
    @genre = params[:genre]
    @author = params[:author]
    @source = params[:source]
    @label = params[:label]
    @publish_date = params[:publish_date]
    @archived = params[:archived] || false
    @id = Random.rand(1..1000)
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end

  # method to add a label to an item
  def add_label(label)
    Label.new(label)
  end

  private

  def can_be_archived?
    publish_date < 10.years.ago
  end
end
