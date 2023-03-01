class CreateAreasViews < ActiveRecord::Migration[6.0]
  def change
    create_view :areas_views
  end
end
