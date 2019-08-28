Redmine::Plugin.register :continous_integration do
  name 'Continous Integration plugin'
  author 'Olivier Bitsch'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  menu :project_menu, :builds, { :controller => 'builds', :action => 'index' }, :caption => 'Builds', :after => :repository, :param => :project_id
  project_module :builds do
    permission :index_builds, :builds => :index
    permission :view_builds, :builds => :view
  end
end
