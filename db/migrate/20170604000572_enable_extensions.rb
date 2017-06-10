class EnableExtensions < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    enable_extension 'citext'
  end
end
