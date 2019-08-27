class Builds < ActiveRecord::Base

  validates :status, presence: true
  validates :project_id, presence: true

  scope :visible, lambda {|*args|
    joins(:project).
    where(Project.allowed_to_condition(args.shift || User.current, :view_news, *args))
  }

  def visible?(user=User.current)
    !user.nil? && user.allowed_to?(:view_news, project)
  end

end
