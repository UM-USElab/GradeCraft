class ScopeController < ApplicationController

  def change
    kind, id = params[:scope].split("|")

    new_scope = find_scope(id)

    if new_scope
      session[:scope_id] = new_scope.id
    end

    redirect_to root_url
  end

  def find_scope(id)
    current_user.find_scoped_courses(id)
  end

end
