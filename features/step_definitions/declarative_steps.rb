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
  fill_in "Email", :with => email
  fill_in "Password", :with => password
  click_button("Log in")
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
