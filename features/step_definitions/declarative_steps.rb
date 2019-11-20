Given /^(?:|I )am on the (.+) page$/ do |page_name|
  visit path_to(page_name)
end

Given /^(?:|I )choose option (.+)$/ do |page_name|
  click_on page_name
end

When /^(?:|I )follow (.+)$/ do |button|
  pending # Write code here that turns the phrase above into concrete actions
end

Then /^(?:|I )should be on the (.+) page$/ do |page_name|
  regexp = /.*(#{page_name}).*/
  expect(page.body).to match(regexp)
end
