class Product < ActiveRecord::Base
  extend FriendlyId

  has_many :product_attributes, inverse_of: :product, dependent: :destroy
  has_many :report_products, class_name: 'ReportProduct'
  has_many :reports, through: :report_products

  validates :title, presence: true

  attachment :avatar_image, type: :image

  accepts_nested_attributes_for :product_attributes, allow_destroy: true

  friendly_id :title, use: [:slugged, :finders]

  def report(user = nil)
    [].tap do |data|
      scope = report_products
        .eager_load(:report)

      unless user.nil?
        scope = scope.where('reports.user_id': user.try(:id) || user)
      end

      scope = scope.group_by_month(:created_at)

      medium = Hash[scope
        .sum(:unit_value)
        .select { |key, value| !value.zero? }
        .map do |key, value|
          items = report_products
            .eager_load(:report)
            .where('reports.created_at >= :min AND reports.created_at <= :max', min: key.at_beginning_of_month, max: key.at_end_of_month)

          [key, ((value.zero? ? 1 : value) / (items.count.zero? ? 1 : items.count))]
        end]

      better = Hash[medium
        .map do |key, value|
          [key, ((value.zero? ? 1 : value) * (90)) / 100]
        end]

      high = Hash[medium
        .map do |key, value|
          [key, ((value.zero? ? 1 : value) * (110)) / 100]
        end]

      data << ({ name: 'Melhor Preço', data: better })
      data << ({ name: 'Preço Máximo', data: high })
      data << ({ name: 'Preço Médio', data: medium })
    end
  end

  def better_price(user = nil)
    (report(user).find { |value| value[:name] == 'Melhor Preço' }[:data].find { |date, data| date.month == Date.today.month && date.year == Date.today.year } || [])[1] || 0
  end

  def high_price(user = nil)
    (report(user).find { |value| value[:name] == 'Preço Máximo' }[:data].find { |date, data| date.month == Date.today.month && date.year == Date.today.year } || [])[1] || 0
  end

  def medium_price(user = nil)
    (report(user).find { |value| value[:name] == 'Preço Médio' }[:data].find { |date, data| date.month == Date.today.month && date.year == Date.today.year } || [])[1] || 0
  end

  def related_products
    # TODO
    Product.order("RANDOM()").limit(3)
  end
end
