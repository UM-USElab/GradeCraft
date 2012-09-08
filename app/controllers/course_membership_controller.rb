class CourseMembershipController < ApplicationController

    before_filter :ensure_staff?

end