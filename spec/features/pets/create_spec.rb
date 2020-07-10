RSpec.describe "Creating a new shelter pet" do
  it "Should create a new pet for a shelter " do
    cozy_kitten = Shelter.create(name: "Cozy Kitten Animal Shelter", address: "123 Maple Street", city: "Brooklyn", state: "NY", zip:12345)
    visit "/shelters/#{cozy_kitten.id}/pets"
    name = "ALISON"
    image = ""
    description = "The cutest kitten!"
    approx_age = 2
    sex = "Female"
    click_link "ADD A NEW PET TO #{cozy_kitten.name.upcase}"
    expect(current_path).to eq("/shelters/#{cozy_kitten.id}/pets/new")
    fill_in :image, with: image
    fill_in :name, with: name
    fill_in :description, with: description
    fill_in :approx_age, with: approx_age
    fill_in :sex, with: sex
    click_button "Create Pet"
    expect(current_path).to eq("/shelters/#{cozy_kitten.id}/pets")
    expect(page).to have_content(image)
    expect(page).to have_content(name)
    expect(page).to have_content(approx_age)
    expect(page).to have_content(sex)
  end

  it "Has a link to shelter index page" do
    cozy_kitten = Shelter.create(name: "Cozy Kitten Animal Shelter", address: "123 Maple Street", city: "Brooklyn", state: "NY", zip:12345)
    visit "/shelters/#{cozy_kitten.id}/pets"
    click_link "ADD A NEW PET TO #{cozy_kitten.name.upcase}"
    expect(page).to have_link("ALL SHELTERS")
  end

  it "Has a link to pet index page" do
    cozy_kitten = Shelter.create(name: "Cozy Kitten Animal Shelter", address: "123 Maple Street", city: "Brooklyn", state: "NY", zip:12345)
    visit "/shelters/#{cozy_kitten.id}/pets"
    click_link "ADD A NEW PET TO #{cozy_kitten.name.upcase}"
    expect(page).to have_link("ALL PETS")
  end

  it "Has a favorite indicator in the nav" do
    cozy_kitten = Shelter.create(name: "Cozy Kitten Animal Shelter", address: "123 Maple Street", city: "Brooklyn", state: "NY", zip:12345)
    cat1 = Pet.create(name: 'Fred', approx_age: 2, sex: "Male", image: "", description: "Fred is the sweetest boy", adoption_status: "Adoptable", shelter_id: cozy_kitten.id)
    cat2 = Pet.create(name: 'Gordo', approx_age: 5, sex: "Male", image: "", description: "Gordo is so fluffy", adoption_status: "Adoptable", shelter_id: cozy_kitten.id)
    favorite1 = Favorite.create(pet_id: cat1.id)
    favorite2 = Favorite.create(pet_id: cat2.id)
    visit "/shelters/#{cozy_kitten.id}/pets"
    expect(page).to have_content("Favorite Indicator")
    expect(page).to have_content("2")
  end
end
