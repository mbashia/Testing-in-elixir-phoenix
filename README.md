# Contact Form Testing Example

## Getting Started

To follow along with this guide, you'll need to set up the project locally. Here are the steps:

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/mbashia/Testing-in-elixir-phoenix.git
   cd contact_form

   Install Dependencies:

Make sure you have Elixir and Phoenix installed. Then, run:


```mix deps.get
Create and Migrate the Database:

Set up your database configuration in config/dev.exs, then run:


mix ecto.create
mix ecto.migrate
Run the Tests:

To verify that everything is working correctly, run:

mix test
Start the Phoenix Server ():

If you want to see the application in action, start the server with:

mix phx.server
You can then navigate to http://localhost:4000 in your browser to view the application.