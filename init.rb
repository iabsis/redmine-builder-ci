Redmine::Plugin.register :continous_integration do
  name 'Continous Integration plugin'
  author 'Olivier Bitsch'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  menu :project_menu, :builds, { :controller => 'builds', :action => 'index' }, :caption => 'Builds', :after => :repository, :param => :project_id
  menu :top_menu, :builds, { :controller => 'builds', :action => 'all' }, :caption => 'Builds'
  project_module :builds do
    permission :view_builds, :builds => [:view, :index]
    permission :new_builds, :builds => [:new, :update]
  end
end
