module Statusable
  extend ActiveSupport::Concern
  include EnumCallbackable
  include EnumHumanizable

  included do
    enum status: [:offline, :online]

    enum_callbackable :status

    after_initialize { self.status ||= :offline }

    before_online do
      self.last_time_online = nil
      true
    end

    before_offline do
      self.last_time_online = DateTime.now
      true
    end

    scope :offline_more_than, -> (interval) { offline.where("(? - last_time_online) > interval ?", DateTime.now, interval) }
    scope :pinged_more_than,  -> (interval) { online.where("(? - last_ping_time) > interval ?", DateTime.now, interval) }

    humanized_enum :status
  end

  class_methods do
    def make_offline_last_ping_more_than!(interval = '5 minutes')
      pinged_more_than(interval).update_all(status: statuses[:offline], last_ping_time: nil)
    end
  end

  def statusable?
    true
  end
end
