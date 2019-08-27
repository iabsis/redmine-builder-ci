class Builds < ActiveRecord::Base

  belongs_to :project
  validates :status, presence: true
  validates :status, inclusion: { in: %w(Success Failed Building),
    message: "%{value} must be Success, Building or Failed" }

  validates :project_id_exists, presence: true

  scope :visible, lambda {|*args|
    joins(:project).
    where(Project.allowed_to_condition(args.shift || User.current, :view_news, *args))
  }

  def visible?(user=User.current)
    !user.nil? && user.allowed_to?(:view_news, project)
  end

  def project_id_exists
    return false if Project.find_by_id(self.project_id).nil?
    return true
  end

end
