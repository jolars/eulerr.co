library(shiny)
library(eulerr)

shinyUI(
  navbarPage(
    "eulerr",
    inverse = TRUE,
    tabPanel(
      "Application",
      fluidPage(
        fluidRow(
          column(
            3,
            wellPanel(
              p("String together combinations by joining them
                with an ampersand (&)."),
              radioButtons(
                "shape",
                "Shape",
                c("Circle" = "circle", "Ellipse" = "ellipse"),
                inline = TRUE
              ),
              splitLayout(
                cellWidths = c("70%", "30%"),
                radioButtons(
                  "input_type",
                  "Type of relationships",
                  c("Disjoint combinations" = "disjoint", "Unions" = "union")
                ),
                textInput(
                  "seed",
                  "Seed",
                  value = "",
                  placeholder = NULL,
                  width = "100%"
                )
              ),
              splitLayout(
                cellWidths = c("70%", "30%"),
                textInput("combo_1", NULL, "A"),
                numericInput("size_1", NULL, 5, min = 0)
              ),
              splitLayout(
                cellWidths = c("70%", "30%"),
                textInput("combo_2", NULL, "B"),
                numericInput("size_2", NULL, 3, min = 0)
              ),
              splitLayout(
                cellWidths = c("70%", "30%"),
                textInput("combo_3", NULL, "A&B"),
                numericInput("size_3", NULL, 2, min = 0)
              ),

              tags$div(id = "placeholder"),

              splitLayout(
                actionButton("insert_set", "Insert", width = "100%"),
                actionButton("remove_set", "Remove", width = "100%")
              )
              ),
            wellPanel(
              fluidRow(
                column(
                  6,
                  strong("stress"),
                  textOutput("stress")
                ),
                column(
                  6,
                  strong("diagError"),
                  textOutput("diagError")
                )
              )
            ),
            tableOutput("table")
          ),
          column(
            6,
            plotOutput("euler_diagram", height = "500px"),
            textOutput("citation")
          ),
          column(
            3,
            strong("Colors"),
            em(p("A comma-separated list of ",
                 a(href = "https://stat.columbia.edu/~tzheng/files/Rcolor.pdf",
                   "x11"),
              "or",
              a(href = "https://en.wikipedia.org/wiki/Web_colors#Hex_triplet",
                "hex colors."))),
            textInput(
              inputId = "fill",
              label = NULL,
              value = "",
              placeholder = "grey70, white, steelblue4",
              width = "100%"
            ),
            fluidRow(
              column(
                4,
                checkboxInput("legend", "Legend")
              ),
              column(
                8,
                conditionalPanel(
                  condition = "input.legend == true",
                  selectInput("legend_side", NULL, width = "100%",
                              list("right", "left", "top", "bottom"))
                )
              )
            ),
            radioButtons(
              "font",
              "Font",
              list("Plain", "Bold", "Italic", "Bold italic"),
              selected = "Bold",
              inline = TRUE
            ),
            radioButtons(
              "borders",
              "Borders",
              list("Solid", "Varying", "None"),
              inline = TRUE
            ),
            numericInput(
              inputId = "pointsize",
              label = "Pointsize",
              value = 12,
              min = 1,
              max = 100,
              step = 1,
              width = "100%"
            ),
            checkboxInput("quantities", "Show quantities"),
            sliderInput("alpha", "Opacity", min = 0, max = 1, value = 1,
                        width = "100%"),
            hr(),
            fluidRow(
              column(
                6,
                numericInput(
                  inputId = "width",
                  label = "Width (inches)",
                  value = 6,
                  width = "100%"
                )
              ),
              column(
                6,
                numericInput(
                  inputId = "height",
                  label = "Height (inches)",
                  value = 4,
                  width = "100%"
                )
              )
            ),
            fluidRow(
              column(
                6,
                downloadButton("download_plot", "Save plot")
              ),
              column(
                6,
                radioButtons(
                  "savetype",
                  NULL,
                  list("pdf", "png"),
                  inline = TRUE
                )
              )
            )
          )
        )
      )
    ),
    tabPanel(
      "Citation",
      fluidPage(
        fluidRow(
          column(
            10,
            offset = 1,
            verbatimTextOutput("cit")
          )
        )
      )
    ),
    tabPanel(
      "Information",
      fluidPage(
        fluidRow(
          column(
            6,
            offset = 3,
            wellPanel(
              h3("Area-proportional diagrams with eulerr"),
              p("This", a(href = "https://shiny.rstudio.com/", "shiny"),
                "app is based on an",
                a(href = "www.r-project.org", "R"),
                "package that I have developed called eulerr. It generates
                area-proportional euler diagrams using some rather groovy algorithms
                and optimization routines written in", code("R"), "and", code("C++.")),
              p(a(href = "https://en.wikipedia.org/wiki/Euler_diagram",
                  "euler diagrams"),
                "are generalized venn diagrams for which the requirement that all
                intersections be present is relaxed. They are constructed from
                a specification of set relationships but may sometimes fail
                to display these appropriately. For instance, try giving the
                app the specification",
                code("A = 5, B = 3, C = 1, A&B = 2,AB&C = 2"),
                "to see what I mean."),
              p("When this happens, eulerr tries to give an indication of how
                badly the diagram fits the data through the metrics",
                em("stress"), "and", em("diag error"), ". The latter of these
                show the largest difference in percentage points between the specification
                of any one set combination and its resulting fit. It is the
                maximum value of", em("region error"), ", which is given for
                each combination. This metric has been adopted from",
                a(href = "https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0101717", "a paper by
                Micallef and Peter Rodgers."), "Stress is more difficult to
                explain, but I advise the interested reader to read",
                a(href = "https://www.cs.uic.edu/~wilkinson/Publications/venneuler.pdf",
                  "Leland Wilkinson's excellent paper"), "for a proper brief."),
              p("I have listed some links on the right if you are keen on
                learning more about eulerr, perhaps even to contribute to its
                development. Finally, I owe a great deal to the
                aforementioned Wilkinson as well as",
                a(href = "http://www.benfrederickson.com/", "Ben Frederickson"),
                "whose work eulerr is built upon."),
              br(),
              p("Johan Larsson")
            )
          ),
          column(
            2,
            wellPanel(
              p(strong(a(href = "https://CRAN.R-project.org/package=eulerr",
                         "eulerr on the R package repository CRAN"))),
              p(strong(a(href = "http://larssonjohan.com",
                         "My personal website"))),
              p(strong(a(href = "https://github.com/jolars/eulerr",
                         "The Github repository for the R package"))),
              p(strong(a(href = "https://github.com/jolars/eulerr.co",
                         "The Github repository for the shiny app")))
            )
          )
        )
      )
    ),
    tabPanel(
      "News",
      fluidPage(
        fluidRow(
          column(
            6,
            offset = 3,
            wellPanel(
              h4("2018-02-19"),
              p(a(href = "https://github.com/jolars/eulerr/releases/tag/v4.0.0",
                  "Updated eulerr to version 4.0.0")),
              p("Migrated to http://eulerr.co"),
              h4("2017-11-15"),
              p(a(href = "https://github.com/jolars/eulerr/releases/tag/v3.0.0",
                  "Updated eulerr to 3.0.0.")),
              p("Added option to set pointsize (mostly for fonts)."),
              p("Added settings for height and width when downloading plots."),
              h4("2017-07-30"),
              p("Added the option to supply a seed to enable reproducible layouts"),
              p(a(href = "https://github.com/jolars/eulerr/releases/tag/v2.0.0",
                  "Updated eulerr to version 2.0.0"))
            )
          )
        )
      )
    )
  )
)




