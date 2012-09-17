class TeamMembershipController < ApplicationController

  before_filter :ensure_staff?

end