from shiny import App, render, ui

# Define the User Interface (UI)
app_ui = ui.page_fluid(
    ui.h2("My Simple Shiny App"),
    ui.input_slider("number", "Pick a number:", 1, 100, 50),
    ui.output_text_verbatim("output_text")
)

# Define the server logic
def server(input, output, session):
    @output
    @render.text
    def output_text():
        return f"You selected: {input.number()}"

# Create the Shiny app
app = App(app_ui, server)

# To run the app, use: shiny run filename.py