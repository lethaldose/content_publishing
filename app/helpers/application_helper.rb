module ApplicationHelper

  def user_display_name
    "#{current_user.email} (#{current_user.role.name.capitalize})" if user_signed_in?
  end

  def menu_for_role
    if user_signed_in?
      get_menu_items[current_user.role.name.to_sym][:view]
    else
      get_menu_items[:guest][:view]
    end
  end

  def action_menu_for_role
    if user_signed_in?
      get_menu_items[current_user.role.name.to_sym][:action]
    else
      get_menu_items[:guest][:action]
    end
  end

  def get_menu_items
    @@menu ||= {
      guest: { view: {"Articles" => articles_path}, action: {}} ,
      reporter: {view:{"Home" => root_path, "Articles" => articles_path}, action: { "New Article" => new_article_path}},
      editor: {view:{"Home" => root_path, "Articles" => articles_path}, action: {"New Article" => new_article_path}},
      admin: {view:{"Home" => root_path, "Articles" => articles_path, "Users" => users_path}, action: {"New Article" => new_article_path, "New User" => new_user_path}}
    }
  end
end
