library(shiny)
library(ggplot2)
library(dplyr)
library(lintr)
library(plotly)
pageone <- tabPanel(
  "Poverty and Education",
  titlePanel("Relationship Between Education and
            Poverty in the Midwest"),
  sidebarLayout(
      sidebarPanel(
      selectInput(inputId = "education",
                  label = "Select Education Level",
                  choices = c("High_School", "College")),
      br(),
      sliderInput(inputId = "size",
      label = "Size of plot points",
      min = 0.1,
      max = 3,
      value = 1.5
      )
      ),
    mainPanel(
      plotlyOutput(outputId = "education_plot")
    )
  )
)

pagetwo <- tabPanel(
  "Diversity",
  titlePanel("Diversity in Midwest by State"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "race",
                label = "Racial Population",
                choices = c("White", "Black",
                            "American_Indians",
                            "Asian", "Other")),
      br(),
      radioButtons(inputId = "color", label = "Select a color",
                   choices = c("blue", "red", "green",
                               "black"),
                   selected = "black"),
    ),
    mainPanel(
      plotlyOutput(outputId = "race_diversity")
    )
  )
)

ui <- navbarPage("",
                 pageone,
                 pagetwo)
