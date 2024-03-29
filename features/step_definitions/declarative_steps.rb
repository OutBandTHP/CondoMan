Given /^(?:|I )am on the (.+) page$/ do |page_name|
  visit path_to(page_name)
end

Given /^(?:|I )choose menu (.+)$/ do |menu_item|
  click_on menu_item
end

Given /the following (.+) exist:/ do |object, table|
  eval("
    table.hashes.each do |item|
      #{object.singularize.capitalize}.create item
    end
  ")
end

Given /the following users were created:/ do |users_table|
  users_table.hashes.each do |user|
    User.create user
  end
end

When /^(?:|I )login as (.+) with password (.+)$/ do |email, password|
  fill_in "Email",    :with => email
  fill_in "Password", :with => password
  click_button("Log in")
end

And /^(?:|I )create the project (.+), managed by (.+) with (\d+) buildings and (\d+) units/ do |project, admin, buildings, units|
  fill_in "Name",             :with => project
  fill_in "eMail of Admin",   :with => admin
  fill_in "eMail of Project", :with => "project@mail.com"
  fill_in "Address",          :with => "Project Address"
  fill_in "No. of Buildings", :with => buildings
  fill_in "No. of Units",     :with => units
  click_button("Save Changes")
end

Then /^(?:|I )can find (.+) by (.+) (.+)$/ do |object, key, value|
  expect(eval ("#{object.singularize.capitalize}.find_by(#{key}: \"#{value}\").#{key}")).to match(value)
end

Then /^(?:|I )should (|not )see menu (.+)$/ do |see, menu_item|
  eval ("page.should" + (see == "not "?"_not " : " ") + "have_content(menu_item)")
end

When /^(?:|I )follow (.+)$/ do |button|
  pending # Write code here that turns the phrase above into concrete actions
end

Then /^(?:|I )should be on the (.+) page$/ do |page_name|
  regexp = /.*(#{page_name}).*/
  expect(page.body).to match(regexp)
end

Then /there (are|is) (\d+) (.+)$/ do |ignore, amount, object|
  expect(eval ("#{object.singularize.capitalize}.count")).to match(amount)
end
