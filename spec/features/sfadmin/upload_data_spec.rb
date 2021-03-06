require "rails_helper"

feature "Uploading data" do
  scenario "uploading a JSON file" do
    data_url = "https://example.com/example.json"
    sample_upload_json_file = Rails.root + "spec/fixtures/sample_upload.json"
    body = File.read(sample_upload_json_file)

    stub_request(:get, data_url).to_return(status: 200, body: body)

    login_admin
    visit "/"
    click_on "New Import Job"
    fill_in "import_job_url", with: data_url
    click_on "Create Import job"

    expect(page).to have_content("30th Street Senior Center")
    expect(page).to have_content("finished_job")
  end
end
