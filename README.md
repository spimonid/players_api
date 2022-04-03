
# Underdog Fantasy Backend Challenge

## Set up

Clone the repo - https://github.com/spimonid/players_api.git

`cd players_api`

run `rails db:create`

run `rails db:migrate`

run `rake initial_import` to import the data from CBS

run `rails server`

## Requirements

<img width="661" alt="Screen Shot 2022-04-02 at 5 46 38 PM" src="https://user-images.githubusercontent.com/33667846/161403912-fe72d933-e278-4916-9d84-6aa6b1e54d77.png">

<img width="700" alt="Screen Shot 2022-04-02 at 6 00 33 PM" src="https://user-images.githubusercontent.com/33667846/161404171-2d84f36c-c824-4494-9024-7515a91be7ce.png">

<img width="633" alt="Screen Shot 2022-04-02 at 6 12 20 PM" src="https://user-images.githubusercontent.com/33667846/161404437-f349429a-7783-4bbf-ada8-15543a725216.png">

🟥 import from CBS https://github.com/spimonid/players_api/blob/38c8034e9943e74ccc6d3ffd0c195a3944f11a53/Gemfile#L60 https://github.com/spimonid/players_api/blob/401ae97002443fe8a42abe0bb0be1c2a64390c6c/lib/tasks/initial_import.rake#L6-L10

🟦 persist by [setting up the table](https://github.com/spimonid/players_api/blob/main/db/migrate/20220402132537_add_columns_to_players_table.rb) and saving each record with custom logic on [`name_brief`](https://github.com/spimonid/players_api/blob/main/lib/brief_name_generator.rb) and [`average_position_age_diff`](https://github.com/spimonid/players_api/blob/main/lib/average_position_age_diff_calculator.rb). https://github.com/spimonid/players_api/blob/401ae97002443fe8a42abe0bb0be1c2a64390c6c/lib/tasks/initial_import.rake#L37-L51

🟩 Routing - an endpoint to show an individual player and a search endpoint https://github.com/spimonid/players_api/blob/401ae97002443fe8a42abe0bb0be1c2a64390c6c/config/routes.rb#L1-L5
https://github.com/spimonid/players_api/blob/401ae97002443fe8a42abe0bb0be1c2a64390c6c/app/controllers/players_controller.rb#L1-L21


🟨 Scoping and logic to power the search endpoint
https://github.com/spimonid/players_api/blob/401ae97002443fe8a42abe0bb0be1c2a64390c6c/app/models/player.rb#L1-L20

## Beside Requirements

### Search bonus
If `feeling_lucky` param is present, returns just the first result of your search, otherwise there could be multiple records in the response
https://github.com/spimonid/players_api/blob/401ae97002443fe8a42abe0bb0be1c2a64390c6c/app/controllers/players_controller.rb#L8-L14

### QA and Testing

Fire up your preferred API testing tool

<img width="800" alt="Screen Shot 2022-04-03 at 9 07 11 AM" src="https://user-images.githubusercontent.com/33667846/161446799-dcdfe620-08b9-45fb-bbb8-d235524e911d.png">
<img width="800" alt="Screen Shot 2022-04-03 at 9 07 50 AM" src="https://user-images.githubusercontent.com/33667846/161446801-4e8bf3d1-49fc-466e-8f8a-dcb12f069521.png">
<img width="800" alt="Screen Shot 2022-04-03 at 9 08 14 AM" src="https://user-images.githubusercontent.com/33667846/161446802-cfdf0115-4b1d-4843-9a01-911ee33fe6bd.png">


Run `rails test test/models/player_test.rb` and `rails test test/controllers/players_controller_test.rb`

## A couple things that would come next that I couldn't get to
- Refactoring the search from three `.where`s in a row to something more concise
- More robust testing set up and execution
