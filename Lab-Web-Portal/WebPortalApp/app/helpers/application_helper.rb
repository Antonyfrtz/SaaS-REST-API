require_relative 'navigation_helper.rb'
require_relative 'posts_helper.rb'

module ApplicationHelper
    include NavigationHelper
    include PostsHelper
end
