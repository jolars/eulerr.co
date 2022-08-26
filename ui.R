library(shiny)
library(eulerr)

shinyUI(
  navbarPage(
    "eulerr",
    inverse = TRUE,
    tabPanel(
      "App",
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
                numericInput("seed", "Seed", value = 1, width = "100%")
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
                  selectInput(
                    "legend_side",
                    NULL,
                    width = "100%",
                    list("right", "left", "top", "bottom")
                  )
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
      "About",
      fluidPage(
        fluidRow(
          column(
            6,
            offset = 3,
            h1("About"),
            h2("Area-Proportional Diagrams with eulerr"),
            p(
              "This",
              a(href = "https://shiny.rstudio.com/", "shiny"),
              "app is based on an",
              a(href = "www.r-project.org", "R"),
              "package that I have developed called eulerr.",
              "It generates area-proportional euler diagrams using numerical",
              "optimization routines."
            ),
            p(
              a(href = "https://en.wikipedia.org/wiki/Euler_diagram", "Euler diagrams"),
              "are generalized venn diagrams for which the requirement that",
              "all intersections be present is relaxed. They are constructed",
              "from a specification of set relationships but may sometimes",
              "fail to display these appropriately. For instance, try giving",
              "the app the specification",
              code("A = 5, B = 3, C = 1, A&B = 2, AB&C = 2"),
              "to see what I mean."
            ),
            p(
              "When this happens, eulerr tries to give an indication of",
              "how badly the diagram fits the data through the metrics",
              em("stress"),
              "and",
              em("diag error."),
              "The latter of these show the largest difference in percentage",
              "points between the specification of any one set combination",
              "and its resulting fit. It is the maximum value of",
              em("region error,"),
              "which is given for each combination. This metric has been",
              "adopted from",
              a(
                href = "https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0101717",
                "a paper by Micallef and Peter Rodgers."
              ),
              "Stress is more difficult to explain, but I advise the",
              "interested reader to read",
              a(
                "Leland Wilkinson's excellent paper",
                href = "https://www.cs.uic.edu/~wilkinson/Publications/venneuler.pdf",
              ),
              "for a proper brief."
            ),
            p(
              "Finally, I owe a great deal to the",
              "aforementioned Wilkinson as well as",
              a(href = "http://www.benfrederickson.com/", "Ben Frederickson"),
              "whose work eulerr is inspired by."
            ),
            p(em("Johan Larsson")),
            h2("Limitations in the Shiny App"),
            p(
              "The Shiny app that is hosted here does not completely cover",
              "all the functionality that the R package offers.",
              "The number of sets is for instance limited to six here",
              "but there is no such limitation in the package.",
              "If you want to install the R package, then you need to first",
              a("install R.", href = "https://www.r-project.org/"),
              "After this you can simply install the package by calling ",
              tags$code('install.packages("eulerr")', .noWS = "outside"),
              "."
            ),
            p("To read more about the R package, please visit",
              a(
                " the package page on CRAN",
                href = "https://CRAN.R-project.org/package=eulerr",
                .noWS = "outside"
              ),
              "."
            ),
            h2("Contribute"),
            p(
              "eulerr is an open-source project that welcomes contributions",
              "from anyone who's willing to chip in. Please see the",
              a(
                "development page for the R package",
                href = "https://github.com/jolars/eulerr"
              ),
              "if you are interested in taking part or just want to report",
              "an issue with the package.",
              "If you find any issues with this site, please visit",
              a(
                "the development page for the Shiny appplication",
                href = "https://github.com/jolars/eulerr.co"
              ),
              "and file an issue there."
            ),
          ),
        )
      )
    ),
    tabPanel(
      "Citation",
      fluidPage(
        fluidRow(
          column(
            6,
            offset = 3,
            h1("Citation"),
            p("To cite eulerr in publications, please use"),
            htmlOutput("cit"),
            br(),
            p("A BibTeX entry for LaTeX users is"),
            verbatimTextOutput("bib")
          )
        )
      )
    )
  )
)




