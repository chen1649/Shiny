library(shiny)
library(ggplot2)
library(dplyr)
library(lintr)
library(plotly)
lint("app_server.R")
server <- function(input, output) {
  midwest_new <- mutate(midwest, High_School = perchsd,
                        College = percollege,
                        White = popwhite, Black = popblack,
                        American_Indians = popamerindian,
                        Asian = popasian, Other = popother)
  sum_pop <- midwest_new %>%
    group_by(state) %>%
    summarize(White = sum(popwhite), Black = sum(popblack),
              American_Indians = sum(popamerindian),
              Asian = sum(popasian), Other = sum(popother))
  output$education_plot <- renderPlotly({
  plot <- ggplot(midwest_new) +
    geom_point(mapping = aes_string(x = input$education,
                                    y = "percbelowpoverty"),
               size = input$size)
    interactiveplot <- ggplotly(plot)
      interactiveplot <- interactiveplot %>%
        layout(title =
                 "Relationship Between Education and poverty in the Midwest",
             xaxis = list(title = paste0("Percentage of ",
                                         input$education, " Degree")),
             yaxis = list(title = "Percentage of below poverty")) %>%
        layout(autosize = F, width = 700, height = 500,
               margin = list(l = 40, r = 40, b = 10, t = 100, pad = 4))
  })
  output$race_diversity <- renderPlotly({
    plot <- ggplot(sum_pop) +
      geom_col(mapping = aes_string(x = "state", y = input$race),
               fill = input$color)
      interactiveplot <- ggplotly(plot, textfont = list(size = 0.2))
      interactiveplot <- interactiveplot %>%
        layout(title =
                 "Relationship Between Education and poverty in the Midwest",
               xaxis = list(title = "State"),
               yaxis = list(title = paste0(input$race,
                                           " population in Midwet"))) %>%
        layout(autosize = F, height = 500,
               margin = list(l = 40, r = 40, b = 10, t = 100, pad = 4))
  })
}
