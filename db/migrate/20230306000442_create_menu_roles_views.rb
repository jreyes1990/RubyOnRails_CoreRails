class CreateMenuRolesViews < ActiveRecord::Migration[6.0]
  def change
    create_view :menu_roles_views
  end
end
