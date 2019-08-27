class Builds < ActiveRecord::Base
  scope :visible, lambda {|*args|
    joins(:project).
    where(Project.allowed_to_condition(args.shift || User.current, :view_news, *args))
  }

  def visible?(user=User.current)
    !user.nil? && user.allowed_to?(:view_news, project)
  end

end
