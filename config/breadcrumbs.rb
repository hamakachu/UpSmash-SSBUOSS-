crumb :root do
  link "Home", root_path
end

crumb :users do
  link "ユーザーページ", user_path(:id)
  parent :root
end

crumb :rooms do
  link "フリー対戦", rooms_path
  parent :root
end

crumb :room do
  link "対戦ルーム", room_path(:id)
  parent :rooms
end

crumb :forms do
  link "フォーム作成", startforms_path
  parent :root
end

crumb :form1 do
  link "活動開始フォーム", new_startform_path
  parent :forms
end

crumb :form2 do
  link "振り返りフォーム", new_feedbackform_path
  parent :forms
end

crumb :formA do
  link "活動開始フォーム", startform_path(:id)
  parent :users
end

crumb :formB do
  link "振り返りフォーム", feedbackform_path(:id)
  parent :users
end


# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).